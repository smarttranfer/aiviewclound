import 'dart:convert';
import 'dart:async';
import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:aiviewcloud/websocket/randon_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mqtt_client/mqtt_client.dart';

enum SignalingState {
  ConnectionOpen,
  ConnectionClosed,
  ConnectionError,
}

enum CallState {
  CallStateNew,
  CallStateRinging,
  CallStateInvite,
  CallStateConnected,
  CallStateBye,
}

/*
 * callbacks for Signaling API.
 */
typedef void SignalingStateCallback(SignalingState state);
typedef dynamic IceStateCallback(RTCIceConnectionState state);
typedef void CallStateCallback(Session session, CallState state);
typedef void StreamStateCallback(Session? session, MediaStream stream);
typedef void OtherEventCallback(dynamic event);
typedef void DataChannelMessageCallback(
    Session session, RTCDataChannel dc, RTCDataChannelMessage data);
typedef void DataChannelCallback(Session session, RTCDataChannel dc);

class Session {
  late String pid;
  late String sid;
  late RTCPeerConnection pc;
  late RTCDataChannel dc;
  List<RTCIceCandidate> remoteCandidates = [];
  Session({required this.sid, required this.pid});
}

class Signaling {
  late String _selfId = randomNumeric(6);
  late UserStore _userStore;
  late Map<String, Session> _sessions = {};
  late MediaStream? _localStream;
  late List<MediaStream> _remoteStreams = <MediaStream>[];
  late Peer? receivedPeer;
  late SignalingStateCallback onSignalingStateChange;
  late CallStateCallback onCallStateChange;
  late StreamStateCallback onLocalStream;
  late StreamStateCallback onAddRemoteStream;
  late IceStateCallback? onIceStateCallback;
  late StreamStateCallback onRemoveRemoteStream;
  late OtherEventCallback onPeersUpdate;
  late DataChannelMessageCallback onDataChannelMessage;
  late DataChannelCallback onDataChannel;
  late Session session;
  late RTCDataChannel? _dataChannel;
  late Map<String, dynamic> _iceServers;
  MqttClientService mqttClientServices = MqttClientService();

  Signaling(this._userStore, this.receivedPeer, this._iceServers);

  String get sdpSemantics =>
      WebRTC.platformIsDesktop ? 'plan-b' : 'unified-plan';

  // Map<String, dynamic> _iceServers = {
  //   'iceServers': [
  //     {'url': 'stun:stun.l.google.com:19302'},
  //     {
  //       'url': 'turn:psppdev.hcdt.vn:3478',
  //       'username': 'dev',
  //       'credential': 'dev',
  //       'credentialType': "password"
  //     },
  //   ]
  // };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ]
  };

  final Map<String, dynamic> _dcConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': false,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  close() async {
    await _cleanSessions();
  }

  void switchCamera() {
    if (_localStream != null) {
      Helper.switchCamera(_localStream!.getVideoTracks()[0]);
    }
  }

  void muteMic() {
    if (_localStream != null) {
      bool enabled = _localStream!.getAudioTracks()[0].enabled;
      _localStream!.getAudioTracks()[0].enabled = !enabled;
    }
  }

  Future<void> invite(String peerId, String channel) async {
    var sessionId = _selfId + '-' + peerId;
    session = await _createSession(
        peerId: peerId,
        sessionId: sessionId,
        media: 'video',
        screenSharing: false,
        session: null);
    _sessions[sessionId] = session;
    _createOffer(session, peerId, channel);
  }

  void bye(String sessionId) {
    _closeSession(_sessions[sessionId]!);
  }

  void onMessage(message) async {
    Map<String, dynamic> mapData = message;
    var data = mapData["data"];
    switch (mapData["type"]) {
      case 'peers':
        {
          List<dynamic> peers = data;
          if (onPeersUpdate != null) {
            Map<String, dynamic> event = Map<String, dynamic>();
            event['self'] = _selfId;
            event['peers'] = peers;
          }
        }
        break;
      case 'offer':
        {
          var peerId = data['from'];
          var description = data['description'];
          var media = data['media'];
          var sessionId = data['session_id'];
          var session = _sessions[sessionId];
          var newSession = await _createSession(
              session: session!,
              peerId: peerId,
              sessionId: sessionId,
              media: media,
              screenSharing: false);
          _sessions[sessionId] = newSession;
          await newSession.pc.setRemoteDescription(
              RTCSessionDescription(description['sdp'], description['type']));
          await _createAnswer(newSession, media);
          if (newSession.remoteCandidates.length > 0) {
            newSession.remoteCandidates.forEach((candidate) async {
              await newSession.pc.addCandidate(candidate);
            });
            newSession.remoteCandidates.clear();
          }
          onCallStateChange.call(newSession, CallState.CallStateNew);
        }
        break;
      case 'answer':
        {
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          String decoded = utf8.decode(base64Decode(data));
          Map jsonParsed = jsonDecode(decoded);
          await session.pc.setRemoteDescription(
              RTCSessionDescription(jsonParsed["sdp"], jsonParsed["type"]));
          // var description = data['description'];
          // var sessionId = data['session_id'];
          // var session = _sessions[sessionId];
        }
        break;
      case 'icecandidate':
        {
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          String decoded = utf8.decode(base64Decode(data));
          Map jsonParsed = jsonDecode(decoded);
          RTCIceCandidate candidate = RTCIceCandidate(jsonParsed['candidate'],
              jsonParsed['sdpMid'], jsonParsed['sdpMLineIndex']);
          // print("icecandidate " + jsonParsed["candidate"]);
          // print("sdpMLineIndex ${jsonParsed["sdpMLineIndex"]}");
          // print("sdpMid " + jsonParsed["sdpMid"]);
          // candidate:2757454651 1 udp 16777215 222.254.34.101 45048 typ relay raddr 0.0.0.0 rport 44491","sdpMid":"","sdpMLineIndex":0
          session.pc.addCandidate(candidate);
          // if (session != null) {
          //   if (session.pc != null) {
          //     await session.pc.addCandidate(candidate);
          //   } else {
          //     session.remoteCandidates.add(candidate);
          //   }
          // } else {
          //   _sessions[sessionId] = Session(pid: peerId, sid: sessionId)
          //     ..remoteCandidates.add(candidate);
          // }
        }
        break;
      case 'leave':
        {
          var peerId = data as String;
          closeSessionByPeerId(peerId);
        }
        break;
      case 'bye':
        {
          var sessionId = data['session_id'];
          print('bye: ' + sessionId);
          var session = _sessions.remove(sessionId);
          onCallStateChange.call(session!, CallState.CallStateBye);
          _closeSession(session);
        }
        break;
      case 'keepalive':
        {
          print('keepalive response!');
        }
        break;
      default:
        break;
    }
  }

  Future<MediaStream> createStream(String media, bool userScreen) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth':
              '640', // Provide your own width, height and frame rate here
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    MediaStream stream = userScreen
        ? await navigator.mediaDevices.getDisplayMedia(mediaConstraints)
        : await navigator.mediaDevices.getUserMedia(mediaConstraints);
    onLocalStream.call(null, stream);
    return stream;
  }

  Future<Session> _createSession(
      {required Session? session,
      required String peerId,
      required String sessionId,
      required String media,
      required bool screenSharing}) async {
    var newSession = session ?? Session(sid: sessionId, pid: peerId);
    RTCPeerConnection pc = await createPeerConnection({
      ..._iceServers,
      ...{'sdpSemantics': "unified-plan"},
      ...{'iceTransportPolicy': "all"}
    }, _config);
    pc.onTrack = (event) {
      if (event.track.kind == 'video') {
        onAddRemoteStream.call(newSession, event.streams[0]);
      }
    };
    pc.onAddStream = (MediaStream stream) {
      onAddRemoteStream.call(newSession, stream);
    };

    // Unified-Plan: Simuclast
    // await pc.addTransceiver(
    //   track: _localStream!.getVideoTracks()[0],
    //   kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
    //   init: RTCRtpTransceiverInit(
    //       direction: TransceiverDirection.SendOnly,
    //       streams: [
    //         _localStream!
    //       ],
    //       sendEncodings: [
    //         RTCRtpEncoding(rid: 'f', active: true),
    //         RTCRtpEncoding(
    //           rid: 'h',
    //           active: true,
    //           scaleResolutionDownBy: 2.0,
    //           maxBitrate: 150000,
    //         ),
    //         RTCRtpEncoding(
    //           rid: 'q',
    //           active: true,
    //           scaleResolutionDownBy: 4.0,
    //           maxBitrate: 100000,
    //         ),
    //       ]),
    // );

    // var sender = pc.getSenders().find(s => s.track.kind == "video");
    // var parameters = sender.getParameters();
    // if(!parameters)
    //   parameters = {};
    // parameters.encodings = [
    //   { rid: "h", active: true, maxBitrate: 900000 },
    //   { rid: "m", active: true, maxBitrate: 300000, scaleResolutionDownBy: 2 },
    //   { rid: "l", active: true, maxBitrate: 100000, scaleResolutionDownBy: 4 }
    // ];
    // sender.setParameters(parameters);
    pc.onRenegotiationNeeded = () {
      print("onRenegotiationNeeded ");
    };
    pc.onSignalingState = (value) {
      print("onRenegotiationNeeded ${value}");
    };
    pc.onIceCandidate = (event) {
      if (event == null) {
        return;
      }
      String topic = "";
      Iterable<TransportInfosFunctions> functionList = this
          .receivedPeer!
          .transports!
          .transportInfos![0]
          .data!
          .functions!
          .where((element) => element.function == 'send');

      if (functionList.isNotEmpty) {
        topic = functionList.first.path!;
      }
      print('topic to send from channel ${topic}');
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      var iceCandidateData = jsonEncode(event.toMap());
      String result = base64Encode(utf8.encode(iceCandidateData));

      // String encodedData = stringToBase64.encode(iceCandidateData.toString());

      Map<String, dynamic> format64 = {
        "context": "signal.webrtc",
        "type": 'icecandidate',
        "data": result,
        "source_id": _userStore.peer!.peerId,
        "target_id": peerId,
        "data_encode_type": 'base64',
        "auth": null,
      };
      final builder = MqttClientPayloadBuilder();

      builder.addUTF8String(jsonEncode(format64));
      mqttClientServices.client
          .publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    };

    pc.onIceConnectionState = onIceStateCallback;
    pc.onRemoveStream = (stream) {
      onRemoveRemoteStream.call(newSession, stream);
      _remoteStreams.removeWhere((it) {
        return (it.id == stream.id);
      });
    };

    pc.onDataChannel = _onDataChannel;

    newSession.pc = pc;
    _createDataChannel(newSession);

    return newSession;
  }

  void _onDataChannel(RTCDataChannel dataChannel) {
    print(dataChannel);
    dataChannel.onMessage = (message) {
      if (message.type == MessageType.text) {
        print(message.text);
      } else {
        // do something with message.binary
      }
    };
    // or alternatively:
    dataChannel.messageStream.listen((message) {
      if (message.type == MessageType.text) {
        print(message.text);
      } else {
        // do something with message.binary
      }
    });
  }

  void onSendCommand(message) {
    print(message);
    _dataChannel!.send(RTCDataChannelMessage(message));
  }

  void _addDataChannel(Session session, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {
      print("onDataChannelState $e");
    };
    channel.onMessage = (RTCDataChannelMessage data) {
      print(data);
      onDataChannelMessage.call(session, channel, data);
    };
    channel.messageStream.listen((message) {
      print(message);
      if (message.type == MessageType.text) {
        print(message.text);
      } else {
        // do something with message.binary
      }
    });
    session.dc = channel;
    // onDataChannel.call(session, channel);
  }

  Future<void> _createDataChannel(Session session,
      {label: 'fileTransfer'}) async {
    RTCDataChannelInit dataChannelDict = RTCDataChannelInit()
      ..maxRetransmits = 30;
    _dataChannel = await session.pc.createDataChannel(label, dataChannelDict);
    _addDataChannel(session, _dataChannel!);
  }

  Future<void> _createOffer(
      Session session, String peerId, String channel) async {
    try {
      print('builder.addUTF8String(jsonEncode(format64));');

      Map<String, dynamic> _configOffer = {
        'mandatory': {'OfferToReceiveAudio': false, 'OfferToReceiveVideo': true}
      };
      RTCSessionDescription offer = await session.pc.createOffer(_configOffer);
      await session.pc.setLocalDescription(offer);
      String topic = "";
      Iterable<TransportInfosFunctions> functionList = this
          .receivedPeer!
          .transports!
          .transportInfos![0]
          .data!
          .functions!
          .where((element) => element.function == 'send');

      if (functionList.isNotEmpty) {
        topic = functionList.first.path!;
      }
      String nameString = jsonEncode(offer.toMap());
      String encoded = base64Encode(utf8.encode(nameString));
      Map<String, dynamic> format64 = {
        "context": "signal.webrtc",
        "type": 'offer',
        "data": encoded,
        "source_id": _userStore.peer!.peerId,
        "target_id": peerId,
        "data_encode_type": 'base64',
        "auth": null,
        "extend": {"type": "LIVE", "src": channel}
      };
      final builder = MqttClientPayloadBuilder();
      builder.addUTF8String(jsonEncode(format64));
      mqttClientServices.client
          .publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      // _send('offer', {
      //   'to': session.pid,
      //   'from': _selfId,
      //   'description': {'sdp': s.sdp, 'type': s.type},
      //   'session_id': session.sid,
      //   'media': media,
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _createAnswer(Session session, String media) async {
    try {
      RTCSessionDescription s =
          await session.pc.createAnswer(media == 'data' ? _dcConstraints : {});
      await session.pc.setLocalDescription(s);
      // _send('answer', {
      //   'to': session.pid,
      //   'from': _selfId,
      //   'description': {'sdp': s.sdp, 'type': s.type},
      //   'session_id': session.sid,
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _cleanSessions() async {
    _sessions.forEach((key, sess) async {
      await sess.pc.close();
      await sess.dc.close();
    });
    _sessions.clear();
  }

  void closeSessionByPeerId(String peerId) {
    var session;
    _sessions.removeWhere((String key, Session sess) {
      var ids = key.split('-');
      session = sess;
      return peerId == ids[0] || peerId == ids[1];
    });
    if (session != null) {
      _closeSession(session);
      onCallStateChange.call(session, CallState.CallStateBye);
    }
  }

  Future<void> _closeSession(Session session) async {
    // _localStreamgetTracks()forEach((element) async {
    //   await element.dispose();
    // });
    // await _localStreamdispose();
    _localStream = null;

    await session.pc.close();
    await session.dc.close();
  }
}
