import 'dart:async';
import 'dart:convert';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/ui/live_cam.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:aiviewcloud/websocket/signaling.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

class CamListItem extends StatefulWidget {
  final CameraP2P camera;
  final UserStore userStore;
  final bool? isStart;
  final Function? setCurrentCamplay;
  final String? currentPlayCamId;
  CamListItem(
      {Key? key,
      required this.camera,
      required this.userStore,
      this.isStart,
      this.currentPlayCamId,
      this.setCurrentCamplay})
      : super(key: key);

  @override
  _CamListItemState createState() => _CamListItemState();
}

class _CamListItemState extends State<CamListItem> {
  late Signaling? _signaling;
  bool isConnected = false;
  bool isLoading = false;
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String topic = "";
  MediaStream? _localStream;
  late MqttClientService mqttClientServices;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  @override
  void didUpdateWidget(covariant CamListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void initListender(List<MqttReceivedMessage<MqttMessage?>>? message) async {
    if (!mounted) return;

    try {
      final recMess = message![0].payload as MqttPublishMessage;
      final topicName = message[0].topic;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      Map<String, dynamic> parsedJson = json.decode(pt);
      print('parsedJson ${parsedJson}');
      if (parsedJson['type'] != null) {
        switch (parsedJson['type']) {
          case 'new.response':
            if (parsedJson['message_id'] == widget.camera.peerId) {
              Peer receivedPeer = Peer.fromJson(json.decode(pt)["data"]);

              Iterable<TransportInfosFunctions> functionList = receivedPeer
                  .transports!.transportInfos![0].data!.functions!
                  .where((element) => element.function == 'received');

              if (functionList.isNotEmpty) {
                topic = functionList.first.path!;
                mqttClientServices.client.subscribe(topic, MqttQos.atLeastOnce);
                List<dynamic>? ice = widget.userStore.iceServer;
                if (ice != null) {
                  Map<String, dynamic> fullIce = {'iceServers': ice};
                  mqttClientServices.client
                      .subscribe(topic, MqttQos.atLeastOnce);
                  _signaling =
                      Signaling(widget.userStore, receivedPeer, fullIce);
                  print('topic to received from channel ${topic}');
                  _connectWebRTC(widget.camera.peerId,
                      Channel.MAIN.toString().split('.').last);
                }
              }
            }
            break;
          case 'answer':
          case 'icecandidate':
            print('topic ${topic}');
            print('topicName ${topicName}');
            if (_signaling != null && topic == topicName) {
              _signaling!.onMessage(parsedJson);
            }
            break;
          default:
        }
      }
    } catch (e) {
      print(e);
    }
  }

  connect() {
    mqttClientServices = MqttClientService();
    streamSubscription =
        mqttClientServices.client.updates!.listen(initListender);
    setState(() {
      isLoading = true;
    });
    if (!mounted) return;
    if (mqttClientServices.client.connectionStatus!.state ==
        MqttConnectionState.connected) {
      String topic = "";
      Iterable<TransportInfosFunctions> functionList = widget
          .userStore.peer!.transports!.transportInfos![0].data!.functions!
          .where((element) => element.function == 'send');

      if (functionList.isNotEmpty) {
        topic = functionList.first.path!;
      }
      if (topic.isNotEmpty) {
        String nameString = jsonEncode({
          "context": "signal.connect.channel",
          "type": "new",
          "data": {"target_id": widget.camera.peerId},
          "source_id": widget.userStore.peer?.peerId,
          "target_id": widget.userStore.peer!.peers!.length == 2
              ? widget.userStore.peer!.peers![1]
              : '',
          "auth": {"type": "inherit"},
          "message_id": widget.camera.peerId
        });
        final builder = MqttClientPayloadBuilder();
        builder.addString(nameString);
        mqttClientServices.client
            .publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
        // _cameraP2PStore.createChannel(topic, {
        //   "context": "signal.connect.channel",
        //   "type": "new",
        //   "data": {"target_id": widget.camera.peerId},
        //   "source_id": widget.userStore.peer?.peerId,
        //   "target_id": widget.userStore.peer!.peers!.length == 2
        //       ? widget.userStore.peer!.peers![1]
        //       : '',
        //   "auth": {"type": "inherit"},
        //   "message_id": widget.camera.peerId
        // });
      }
    }
  }

  initRenderers() async {
    await _remoteRenderer.initialize();
  }

  @override
  deactivate() {
    super.deactivate();
    _remoteRenderer.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (widget.currentPlayCamId != widget.camera.objectGuid) {
    //   close();
    // }
    // if (widget.currentPlayCamId == widget.camera.objectGuid) {
    //   connect();
    // }
  }

  void _connectWebRTC(peerId, String channel) async {
    print("list create offder");
    if (_signaling != null) {
      _signaling!.onAddRemoteStream = ((_, stream) {
        _remoteRenderer.srcObject = stream;
        _localStream = stream;
      });

      _signaling!.onIceStateCallback = ((state) {
        print('state from camera icon ${state}');
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
          widget.setCurrentCamplay!(widget.camera.objectGuid);
          setState(() {
            isConnected = true;
            isLoading = false;
          });
        } else if (state == RTCIceConnectionState.RTCIceConnectionStateFailed ||
            state == RTCIceConnectionState.RTCIceConnectionStateDisconnected &&
                state == RTCIceConnectionState.RTCIceConnectionStateClosed) {
          // initListender();
          connect();
          setState(() {
            isConnected = false;
            isLoading = false;
          });
        }
      });

      _signaling!.onRemoveRemoteStream = ((_, stream) {
        setState(() {
          _remoteRenderer.srcObject = null;
        });
      });

      await _signaling!.invite(peerId, channel);
    }
  }

  void close() {
    try {
      mqttClientServices.client.unsubscribe(topic);
      streamSubscription!.cancel();
      _remoteRenderer.dispose();
      _remoteRenderer.srcObject = null;
      if (this.isConnected) {
        _signaling!.close();
      }
      setState(() {
        isLoading = false;
        isConnected = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  void onTap(cameraP2P) async {
    if (cameraP2P != null) {
      close();
      Navigator.of(context)
          .pushNamed(Routes.liveCam, arguments: {'cameraInfo': cameraP2P});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.mGreyColor2,
            ),
            child: Column(children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.r),
                        topLeft: Radius.circular(8.r),
                      ),
                      child: Container(
                          foregroundDecoration: !widget.camera.isConnected
                              ? BoxDecoration(
                                  color: Colors.grey,
                                  backgroundBlendMode: BlendMode.saturation,
                                )
                              : null,
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: isportrait ? 16 / 11 : 1 / 1,
                            child: Opacity(
                              opacity: widget.camera.isConnected ? 1 : 0.4,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2b2f33),
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                          widget.camera.snapShotUrl ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: !this.isConnected
                                      ? Center(
                                          child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              imageUrl:
                                                  widget.camera.snapShotUrl ??
                                                      '',
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      isLoading
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : widget.camera
                                                                  .isConnected
                                                              ? GestureDetector(
                                                                  onTap:
                                                                      connect,
                                                                  child: Center(
                                                                      child: SvgPicture
                                                                          .asset(
                                                                    Assets
                                                                        .pause,
                                                                    width: 50.w,
                                                                    height:
                                                                        50.w,
                                                                  )))
                                                              : Center(
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                  Assets
                                                                      .disconnected,
                                                                  width: 30.w,
                                                                  height: 30.w,
                                                                )),
                                                    ],
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: const AssetImage(
                                                                Assets
                                                                    .defaultCamera),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            isLoading
                                                                ? Center(
                                                                    child:
                                                                        CircularProgressIndicator())
                                                                : widget.camera
                                                                        .isConnected
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            connect,
                                                                        child: Center(
                                                                            child: SvgPicture.asset(
                                                                          Assets
                                                                              .pause,
                                                                          width:
                                                                              50.w,
                                                                          height:
                                                                              50.w,
                                                                        )))
                                                                    : Center(
                                                                        child: SvgPicture.asset(
                                                                        Assets
                                                                            .disconnected,
                                                                        width:
                                                                            30.w,
                                                                        height:
                                                                            30.w,
                                                                      )),
                                                          ],
                                                        ),
                                                      )))
                                      : Stack(children: [
                                          RTCVideoView(_remoteRenderer,
                                              objectFit: RTCVideoViewObjectFit
                                                  .RTCVideoViewObjectFitCover),
                                        ])),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff121415), width: 1))))),
              Opacity(
                  opacity: widget.camera.isConnected ? 1 : 0.4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            widget.camera.cameraName ?? "Không có tên",
                            style: textStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: widget.camera.isConnected
                                ? () {
                                    onTap(widget.camera);
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 9, 12),
                              child: SvgPicture.asset(
                                Assets.eye,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 18, 9),
                              child: SvgPicture.asset(
                                Assets.setting,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ])));
  }
}
