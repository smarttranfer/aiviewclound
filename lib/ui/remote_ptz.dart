import 'dart:convert';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/models/peer/peer.dart' hide Session;
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:aiviewcloud/websocket/signaling.dart';
import 'package:aiviewcloud/widgets/bottom_camera_action_widget.dart';
import 'package:aiviewcloud/widgets/bottom_camera_menu_widget.dart';
import 'package:aiviewcloud/widgets/bottom_camera_menu_widget_portrait.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PTZControlScreen extends StatefulWidget {
  PTZControlScreen({Key? key}) : super(key: key);

  @override
  _PTZControlScreenState createState() => _PTZControlScreenState();
}

class _PTZControlScreenState extends State<PTZControlScreen> {
  // late CameraP2PStore _cameraP2PStore;
  late UserStore _userStore;
  late CameraP2P camInfo;

  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String topic = "";
  late Signaling? _signaling;
  late MqttClientService mqttClientServices;
  bool isConnected = false;
  @override
  void initState() {
    super.initState();
    initRenderers();
    mqttClientServices = MqttClientService();
    mqttClientServices.client.updates!.listen(initListender);
  }

  void initListender(List<MqttReceivedMessage<MqttMessage?>>? message) {
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
            if (parsedJson['message_id'] == camInfo.peerId) {
              Peer receivedPeer = Peer.fromJson(json.decode(pt)["data"]);

              Iterable<TransportInfosFunctions> functionList = receivedPeer
                  .transports!.transportInfos![0].data!.functions!
                  .where((element) => element.function == 'received');

              if (functionList.isNotEmpty) {
                topic = functionList.first.path!;
                mqttClientServices.client.subscribe(topic, MqttQos.atLeastOnce);
                _signaling = Signaling(_userStore, receivedPeer, {});
                _connectWebRTC(camInfo.peerId);
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
    if (!mounted) return;
    if (mqttClientServices.client.connectionStatus!.state ==
        MqttConnectionState.connected) {
      String topic = "";
      Iterable<TransportInfosFunctions> functionList = _userStore
          .peer!.transports!.transportInfos![0].data!.functions!
          .where((element) => element.function == 'send');

      if (functionList.isNotEmpty) {
        topic = functionList.first.path!;
      }
      if (topic.isNotEmpty) {
        print('creating channel ${topic}');
        String nameString = jsonEncode({
          "context": "signal.connect.channel",
          "type": "new",
          "data": {"target_id": camInfo.peerId},
          "source_id": _userStore.peer?.peerId,
          "target_id": _userStore.peer!.peers!.length == 2
              ? _userStore.peer!.peers![1]
              : '',
          "auth": {"type": "inherit"},
          "message_id": camInfo.peerId
        });
        print("create channel data ${nameString}");
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    camInfo = arguments["cameraInfo"] as CameraP2P;
    _userStore = Provider.of<UserStore>(context);
    connect();
  }

  void _connectWebRTC(peerId) async {
    if (_signaling != null) {
      _signaling!.onAddRemoteStream = ((_, stream) {
        setState(() {
          _remoteRenderer.srcObject = stream;
        });
      });

      _signaling!.onIceStateCallback = ((state) {
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
          setState(() {
            isConnected = true;
          });
        } else if (state == RTCIceConnectionState.RTCIceConnectionStateFailed ||
            state == RTCIceConnectionState.RTCIceConnectionStateDisconnected &&
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

      await _signaling!.invite(peerId, "MAIN");
    }
  }

  @override
  void dispose() async {
    super.dispose();
    try {
      mqttClientServices.client.unsubscribe(topic);
      _remoteRenderer.dispose();
      _remoteRenderer.srcObject = null;
      _signaling!.close();
    } catch (e) {
      print(e.toString());
    }
    await _signaling!.close();
  }

  void command(direction) {
    Map controlJson = {
      "envelope": {
        "header": {"component": "ptz"},
        "body": {
          "put_ptz_continue": {
            "profile_token": "PROFILE_468971848",
            "data": {"pt_mode": direction}
          }
        }
      }
    };
    _signaling!.onSendCommand(controlJson.toString());
  }

  Widget buildBodyLandcapes() {
    return Stack(
      children: [
        Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: !this.isConnected
                ? Center(child: CircularProgressIndicator())
                : RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
            decoration: BoxDecoration(color: const Color(0xff2b2f33)),
          ),
          // Container(
          //   height: 28.h,
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.only(left: 17.w, top: 8.h),
          //   decoration: BoxDecoration(color: const Color(0xff2b2f33)),
          //   child: Text(camInfo.cameraName ?? '',
          //       style: const TextStyle(
          //           color: const Color(0xffffffff),
          //           fontWeight: FontWeight.w400,
          //           fontFamily: "SFProDisplay",
          //           fontStyle: FontStyle.normal,
          //           fontSize: 14.0),
          //       textAlign: TextAlign.left),
          // )
        ]),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(190),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x0d000000),
                        offset: Offset(0, 8),
                        blurRadius: 200.w,
                        spreadRadius: 0)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment(0.5, 0.49999999999999994),
                      end: Alignment(0.5, 0.49999999999999994),
                      colors: [
                        const Color(0xff404447),
                        const Color(0xff555a5e),
                        const Color(0xff404447)
                      ])),
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              command('left');
                            },
                            child: Container(
                                width: 40.w,
                                height: 40.w,
                                color: Colors.transparent,
                                child: Stack(children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset(
                                        Assets.left,
                                        width: 8.w,
                                        height: 12.h,
                                      ))
                                ])),
                          ),
                          GestureDetector(
                            onTap: () {
                              command('right');
                            },
                            child: Container(
                                width: 40.w,
                                height: 40.w,
                                color: Colors.transparent,
                                child: Stack(children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: SvgPicture.asset(
                                        Assets.right,
                                        width: 8.w,
                                        height: 12.h,
                                      ))
                                ])),
                          )
                        ],
                      )),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                command('up');
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                color: Colors.transparent,
                                child: Stack(children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: SvgPicture.asset(
                                        Assets.up,
                                        width: 12.w,
                                        height: 7.4.h,
                                      ))
                                ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                command('down');
                              },
                              child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  color: Colors.transparent,
                                  child: Stack(children: [
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SvgPicture.asset(
                                          Assets.down,
                                          width: 12.w,
                                          height: 7.4.h,
                                        ))
                                  ])),
                            )
                          ],
                        ))),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 12.w,
                                  height: 12.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xfffd7b38),
                                  ),
                                ))))),
              ]),
            )),
        Container(
            margin: EdgeInsets.only(top: 120.w),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                          Assets.minus,
                          width: 14.w,
                          height: 14.w,
                        ),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(
                          Assets.add,
                          width: 14.w,
                          height: 14.w,
                        ),
                      )
                    ],
                  ),
                ))),
        Positioned(
            bottom: 0.0,
            left: 0,
            right: 0,
            child: BottomMenuCameraLandcape(
              onControlPress: onBack,
            ))
      ],
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 211.1.h,
            child: !this.isConnected
                ? Center(child: CircularProgressIndicator())
                : RTCVideoView(_remoteRenderer,
                    objectFit:
                        RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
            decoration: BoxDecoration(color: Colors.black54),
          ),
          Container(
            height: 28.h,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 17.w, top: 8.h),
            decoration: BoxDecoration(color: const Color(0xff2b2f33)),
            child: Text(camInfo.cameraName ?? '',
                style: const TextStyle(
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProDisplay",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
                textAlign: TextAlign.left),
          )
        ]),
        Container(
          width: 180.w,
          height: 180.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(190),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x0d000000),
                    offset: Offset(0, 8),
                    blurRadius: 200,
                    spreadRadius: 0)
              ],
              gradient: LinearGradient(
                  begin: Alignment(0.5, 0.49999999999999994),
                  end: Alignment(0.5, 0.49999999999999994),
                  colors: [
                    const Color(0xff404447),
                    const Color(0xff555a5e),
                    const Color(0xff404447)
                  ])),
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          command('left');
                        },
                        child: Container(
                            width: 60.w,
                            height: 90.h,
                            color: Colors.transparent,
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    Assets.left,
                                    width: 8.w,
                                    height: 12.h,
                                  ))
                            ])),
                      ),
                      GestureDetector(
                        onTap: () {
                          command('right');
                        },
                        child: Container(
                            width: 60.w,
                            height: 90.h,
                            color: Colors.transparent,
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: SvgPicture.asset(
                                    Assets.right,
                                    width: 8.w,
                                    height: 12.h,
                                  ))
                            ])),
                      )
                    ],
                  )),
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            command('up');
                          },
                          child: Container(
                            width: 60.w,
                            height: 60.h,
                            color: Colors.transparent,
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: SvgPicture.asset(
                                    Assets.up,
                                    width: 12.w,
                                    height: 7.4.h,
                                  ))
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            command('down');
                          },
                          child: Container(
                              width: 60.w,
                              height: 60.h,
                              color: Colors.transparent,
                              child: Stack(children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SvgPicture.asset(
                                      Assets.down,
                                      width: 12.w,
                                      height: 7.4.h,
                                    ))
                              ])),
                        )
                      ],
                    ))),
            Align(
                alignment: Alignment.center,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xfffd7b38),
                              ),
                            )))))
          ]),
        ),
        Column(
          children: [
            BottomActionCamera(),
            BottomMenuCamera(),
          ],
        )
      ],
    );
  }

  void onBack() async {
    Navigator.of(context).pop('back');
    // bool isportrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;
    // if (isportrait) {
    //   Navigator.of(context).pop('back');
    // } else {
    //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: const Color(0x212529),
        body: ScreenWidget(
          widget: isportrait ? buildBody() : buildBodyLandcapes(),
          padding: EdgeInsets.zero,
          headerText: 'Xem trực tiếp',
          onBackPress: onBack,
        ));
  }
}
