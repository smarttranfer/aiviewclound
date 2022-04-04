import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/ui/live_cam.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/websocket/signaling.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:path_provider/path_provider.dart';

class CamItem extends StatefulWidget {
  final CameraP2P camera;
  final String? direction;
  final String? zoom;
  final UserStore userStore;
  final bool? isRecording;
  final bool? isCapture;
  final Channel? channel;
  dynamic Function(bool)? setIsCapture;
  CamItem(
      {Key? key,
      required this.camera,
      this.isRecording,
      this.isCapture,
      this.direction,
      this.zoom,
      this.channel,
      this.setIsCapture,
      required this.userStore})
      : super(key: key);

  @override
  _CamItemState createState() => _CamItemState();
}

class _CamItemState extends State<CamItem> with SingleTickerProviderStateMixin {
  late Signaling? _signaling;
  bool isConnected = false;
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String topic = "";
  MediaRecorder? _mediaRecorder;
  MediaStream? _localStream;
  late MqttClientService mqttClientServices;
  StreamSubscription? streamSubscription;
  String screenShotPath = '';
  late AnimationController controller;
  late Animation heartbeatAnimation;
  @override
  void initState() {
    super.initState();
    try {
      mqttClientServices = MqttClientService();
      streamSubscription =
          mqttClientServices.client.updates!.listen(initListender);
      connect();
    } catch (e) {
      setState(() {
        isConnected = false;
      });
    }
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    heartbeatAnimation =
        Tween<double>(begin: 500.w, end: 150.w).animate(controller);
    initRenderers();
  }

  @override
  void didUpdateWidget(covariant CamItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction!.isNotEmpty) {
      command(widget.direction!);
    }
    if (widget.zoom!.isNotEmpty) {
      onZoom(widget.zoom!);
    }
    if (oldWidget.channel != widget.channel) {
      _connectWebRTC(
          widget.camera.peerId, widget.channel.toString().split('.').last);
    }
    if (widget.isCapture!) {
      _captureFrame();
    }
    if (widget.isRecording!) {
      _startRecording();
    } else {
      _stopRecording();
    }
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
                print('topic to received from channel ${topic}');
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                List<dynamic>? ice = widget.userStore.iceServer;
                if (ice != null) {
                  Map<String, dynamic> fullIce = {'iceServers': ice};
                  mqttClientServices.client
                      .subscribe(topic, MqttQos.atLeastOnce);
                  _signaling =
                      Signaling(widget.userStore, receivedPeer, fullIce);
                  _connectWebRTC(widget.camera.peerId,
                      widget.channel.toString().split('.').last);
                } else {
                  setState(() {
                    isConnected = true;
                  });
                  Future.delayed(Duration(milliseconds: 0), () {
                    if (message.isNotEmpty) {
                      FlushbarHelper.createError(
                        message: "Không lấy được thông tin Ice server",
                        title: "Lỗi",
                        duration: Duration(seconds: 3),
                      )..show(context);
                    }
                  });
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

  void command(String direction) {
    if (direction.isNotEmpty) {
      String controlJson = '{"envelope": {"header": {"component": "ptz"},"body":' +
          '{"put_ptz_continue": {"profile_token": "PROFILE_468971848","data": {"pt_mode":' +
          '"' +
          direction +
          '"' +
          '}}}}}';
      _signaling!.onSendCommand(controlJson);
    }
  }

  void onZoom(String zoomValue) {
    if (zoomValue.isNotEmpty) {
      String controlJson = '{"envelope": {"header": {"component": "ptz"},"body":' +
          '{"put_ptz_continue": {"profile_token": "PROFILE_468971848","data": {"zoom":' +
          '"' +
          zoomValue +
          '"' +
          '}}}}}';
      _signaling!.onSendCommand(controlJson);
    }
  }

  connect() {
    if (!mounted) return;
    if (mqttClientServices.client.connectionStatus!.state ==
        MqttConnectionState.connected) {
      String topic = "";
      try {
        Iterable<TransportInfosFunctions> functionList = widget
            .userStore.peer!.transports!.transportInfos![0].data!.functions!
            .where((element) => element.function == 'send');

        if (functionList.isNotEmpty) {
          topic = functionList.first.path!;
        }
        if (topic.isNotEmpty) {
          print(widget.userStore.peer?.peerId);
          print(widget.camera.peerId);
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
          print("creating channel message");
          mqttClientServices.client
              .publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
        }
      } catch (e) {
        setState(() {
          isConnected = false;
        });
      } finally {
        setState(() {
          isConnected = false;
        });
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
  }

  void _connectWebRTC(peerId, String channel) async {
    print("create offder");
    if (_signaling != null) {
      _signaling!.onAddRemoteStream = ((_, stream) {
        _remoteRenderer.srcObject = stream;
        _localStream = stream;
      });

      _signaling!.onIceStateCallback = ((state) {
        print('state from camera icon ${state}');
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
          setState(() {
            isConnected = true;
          });
        } else if (state == RTCIceConnectionState.RTCIceConnectionStateFailed ||
            state == RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
            state == RTCIceConnectionState.RTCIceConnectionStateClosed) {
          // initListender();
          connect();
          setState(() {
            isConnected = false;
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

  @override
  void dispose() {
    print('dispose ${widget.camera.cameraName}');
    try {
      controller.dispose();
      streamSubscription!.cancel();
      mqttClientServices.client.unsubscribe(topic);
      _remoteRenderer.dispose();
      _remoteRenderer.srcObject = null;
      _signaling!.close();
      if (this.isConnected) {
        _signaling!.close();
      }
    } catch (e) {
      print(e.toString());
    }
    super.dispose();
  }

  Future<Directory?> getStorageDirectory() async {
    final Directory _appDocDir;
    if (Platform.isAndroid) {
      _appDocDir =
          (await getExternalStorageDirectory())!; // OR return "/storage/emulated/0/Download";
    } else {
      _appDocDir = await getApplicationDocumentsDirectory();
    }
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/${widget.userStore.user!.objectGuid}/');
    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder;
    } else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder;
    }
  }

  void _startRecording() async {
    if (_localStream == null) throw Exception('Stream is not initialized');
    final storagePath = await getStorageDirectory();
    if (storagePath == null) throw Exception('Can\'t find storagePath');

    final filePath = storagePath.path + '/test.mp4';
    _mediaRecorder = MediaRecorder();
    final videoTrack = _localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');

    await _mediaRecorder!.start(filePath, videoTrack: videoTrack);
  }

  void _stopRecording() async {
    await _mediaRecorder?.stop();
    setState(() {
      _mediaRecorder = null;
    });
  }

  void _captureFrame() async {
    if (_localStream == null) throw Exception('Stream is not initialized');

    final videoTrack = _localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');
    final frame = await videoTrack.captureFrame();
    File image = await writeToFile(frame.asUint8List());
    setState(() {
      screenShotPath = image.path;
    });
    if (controller.isCompleted) {
      controller.reset();
      controller.forward();
    } else {
      controller.forward();
    }
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        screenShotPath = '';
      });
    });
    widget.setIsCapture!(false);
  }

  Future<File> writeToFile(Uint8List data) async {
    final buffer = data.buffer;
    final storagePath = await getStorageDirectory();

    final filePath = storagePath!.path +
        '/aiview-${DateTime.now().millisecondsSinceEpoch}.png';
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Widget build(BuildContext context) {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
        child: Stack(children: [
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: isportrait
                      ? MediaQuery.of(context).size.width / 16 * 9
                      : MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xff2b2f33),
                    image: widget.camera.snapShotUrl == ''
                        ? new DecorationImage(
                            image: NetworkImage(widget.camera.snapShotUrl!),
                            fit: BoxFit.cover,
                          )
                        : new DecorationImage(
                            image: const AssetImage(Assets.defaultCamera),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: !this.isConnected
                      ? Center(
                          child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              imageUrl: widget.camera.snapShotUrl ?? '',
                              imageBuilder: (context, imageProvider) => Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  ),
                              errorWidget: (context, url, error) =>
                                  Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: const AssetImage(
                                              Assets.defaultCamera),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Center(child: CircularProgressIndicator())
                                  ])))
                      : Stack(children: [
                          RTCVideoView(_remoteRenderer,
                              objectFit: RTCVideoViewObjectFit
                                  .RTCVideoViewObjectFitCover),
                          widget.isRecording!
                              ? Opacity(
                                  opacity: 1,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16.w, top: 16.w),
                                      width: 55.8510627746582.w,
                                      height: 20.w,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 5.984041213989258.w,
                                              height: 6.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color:
                                                      const Color(0xffff0e40)))
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff2c343e))),
                                )
                              : Container()
                        ])),
              isportrait
                  ? SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 6.h),
                        decoration:
                            BoxDecoration(color: const Color(0xff404447)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                              widget.camera.cameraName ?? '',
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "SFProDisplay",
                                  fontStyle: FontStyle.normal,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14.0),
                              textAlign: TextAlign.center,
                            )),
                            SvgPicture.asset(
                              Assets.volume,
                              width: 16.4,
                              height: 16,
                            )
                          ],
                        ),
                      ))
                  : Container()
            ],
          ),
          screenShotPath.isNotEmpty
              ? Positioned(
                  left: 15.0,
                  bottom: 0.0,
                  child: AnimatedBuilder(
                      animation: heartbeatAnimation,
                      builder: (context, widget) {
                        return GestureDetector(
                            onTap: () => {
                                  Navigator.of(context)
                                      .pushNamed(Routes.libraryScreen)
                                },
                            child: Image.file(
                              File(screenShotPath),
                              width: heartbeatAnimation.value,
                              height: heartbeatAnimation.value,
                            ));
                      }))
              : Container(),
        ]),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff121415), width: 1)));
  }
}
