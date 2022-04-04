import 'dart:async';
import 'dart:convert';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/camera/camera_lan.dart';
import 'package:aiviewcloud/stores/device/device_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:crypto/crypto.dart';
import 'package:enough_convert/windows/windows1252.dart';
import 'package:flutter/services.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class LanPTZControlScreen extends StatefulWidget {
  LanPTZControlScreen({Key? key}) : super(key: key);

  @override
  _LanPTZControlScreenState createState() => _LanPTZControlScreenState();
}

class _LanPTZControlScreenState extends State<LanPTZControlScreen> {
  // late CameraP2PStore _cameraP2PStore;
  late LanCamera camInfo;
  late DeviceStore _store;
  Map<String, String> directionCoor = {
    'down': '{"Pan": "0", "Tilt": "-1"}',
    'up': '{"Pan": "0", "Tilt": "1"}',
    'left': '{"Pan": "-1", "Tilt": "0"}',
    'right': '{"Pan": "1", "Tilt": "0"}',
  };
  late VlcPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
  }

  connect() {
    if (!mounted) return;
  }

  @override
  deactivate() {
    super.deactivate();
  }

  Future<void> initializePlayer() async {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<DeviceStore>(context);
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    camInfo = arguments["lanCamera"] as LanCamera;
    Map<String, dynamic> info = arguments["info"] as Map<String, dynamic>;
    String url =
        'rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4';
    if (camInfo.rtsp_URL!.isNotEmpty) {
      List<String> patterns = camInfo.rtsp_URL!.split('rtsp://');
      if (patterns.length > 1) {
        url = 'rtsp://' +
            info['username'] +
            ':' +
            info['password'] +
            '@' +
            patterns[1];
      }
    }
    _videoPlayerController = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.FULL,
      autoPlay: true,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(2000),
        ]),
        http: VlcHttpOptions([
          VlcHttpOptions.httpReconnect(true),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
  }

  void stopCommand() async {
    Map<String, dynamic> authInfo = getInfo();
    String address = authInfo["address"];
    Map<String, dynamic> info = authInfo["info"];
    String base64none = authInfo["base64none"];
    DateTime now = authInfo["now"];

    String password = authInfo["password"];
    String body = '{"Envelope": {"Header": ' +
        '{"Security": { "UsernameToken": {"Username": "' +
        info['username'] +
        '","Password": "' +
        password +
        '","Nonce": "' +
        base64none +
        '","Created": "' +
        now.toString() +
        '"}}}' +
        ',"Body":' +
        '{"Stop": ' +
        '{"profile_token": "PROFILE_000","PanTilt": "true","Zoom": "false"' +
        '}}} }}';
    await _store.sendCommand(address, body);
  }

  void stopZoom() async {
    Map<String, dynamic> authInfo = getInfo();
    String address = authInfo["address"];
    Map<String, dynamic> info = authInfo["info"];
    String base64none = authInfo["base64none"];
    DateTime now = authInfo["now"];

    String password = authInfo["password"];
    String body = '{"Envelope": {"Header": ' +
        '{"Security": { "UsernameToken": {"Username": "' +
        info['username'] +
        '","Password": "' +
        password +
        '","Nonce": "' +
        base64none +
        '","Created": "' +
        now.toString() +
        '"}}}' +
        ',"Body":' +
        '{"Stop": ' +
        '{"profile_token": "PROFILE_000","PanTilt": "false","Zoom": "true"' +
        '}}} }}';
    await _store.sendCommand(address, body);
  }

  Map<String, dynamic> getInfo() {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    Map<String, dynamic> info = arguments["info"] as Map<String, dynamic>;
    String address = arguments["address"] as String;

    final codec = const Windows1252Codec(allowInvalid: false);
    final none = codec.encode("aiviewcloud");
    String base64none = base64.encode(none);
    DateTime now = DateTime.now();
    codec.encode(now.toString());
    final credentials = [
      ...none,
      ...codec.encode(now.toString()),
      ...codec.encode(info['password'])
    ];
    var digest = sha1.convert(credentials);
    String password = base64.encode(digest.bytes);
    return {
      "info": info,
      "password": password,
      "base64none": base64none,
      "now": now,
      "address": address
    };
  }

  void command(direction) async {
    Map<String, dynamic> authInfo = getInfo();
    String address = authInfo["address"];
    Map<String, dynamic> info = authInfo["info"];
    String base64none = authInfo["base64none"];
    DateTime now = authInfo["now"];

    String password = authInfo["password"];
    String body = '{"Envelope": {"Header": ' +
        '{"Security": { "UsernameToken": {"Username": "' +
        info['username'] +
        '","Password": "' +
        password +
        '","Nonce": "' +
        base64none +
        '","Created": "' +
        now.toString() +
        '"}}}' +
        ',"Body":' +
        '{"ContinuousMove": ' +
        '{"profile_token": "PROFILE_000","Velocity": ' +
        directionCoor[direction]! +
        '}}} }}';
    await _store.sendCommand(address, body);
  }

  void onPlayandPause() async {
    _videoPlayerController.value.isPlaying
        ? await _videoPlayerController.pause()
        : await _videoPlayerController.play();
  }

  void _toggleRecording() async {
    if (!_videoPlayerController.value.isRecording) {
      var saveDirectory = await getTemporaryDirectory();
      await _videoPlayerController.startRecording(saveDirectory.path);
    } else {
      await _videoPlayerController.stopRecording();
    }
  }

  void _toggleScreenshot() async {
    var snapshot = await _videoPlayerController.takeSnapshot();
    await ImageGallerySaver.saveImage(
      snapshot,
    );
  }

  void _toggleVolumes() async {
    int currentVolume = await _videoPlayerController.getVolume();
    if (currentVolume > 0) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(100);
    }
  }

  void startZoom(String zoom) async {
    Map<String, dynamic> authInfo = getInfo();
    String address = authInfo["address"];
    Map<String, dynamic> info = authInfo["info"];
    String base64none = authInfo["base64none"];
    DateTime now = authInfo["now"];

    String password = authInfo["password"];
    String body = '{"Envelope": {"Header": ' +
        '{"Security": { "UsernameToken": {"Username": "' +
        info['username'] +
        '","Password": "' +
        password +
        '","Nonce": "' +
        base64none +
        '","Created": "' +
        now.toString() +
        '"}}}' +
        ',"Body":' +
        '{"ContinuousMove": ' +
        '{"profile_token": "PROFILE_000","Velocity": {"Zoom":"' +
        zoom +
        '"}}} }}';
    await _store.sendCommand(address, body);
  }

  Widget buildBodyLandcapes() {
    return Stack(
      children: [
        Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 70.h,
            child: VlcPlayer(
              controller: _videoPlayerController,
              aspectRatio: 1,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
            decoration: BoxDecoration(color: const Color(0xff2b2f33)),
          ),
        ]),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 80.w,
              height: 80.w,
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
                            onTapDown: (detail) {
                              command('left');
                            },
                            onTapUp: (detail) {
                              stopCommand();
                            },
                            child: Container(
                                width: 30.w,
                                height: 30.w,
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
                            onTapDown: (detail) {
                              command('right');
                            },
                            onTapUp: (detail) {
                              stopCommand();
                            },
                            child: Container(
                                width: 30.w,
                                height: 30.w,
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
                              onTapDown: (detail) {
                                command('up');
                              },
                              onTapUp: (detail) {
                                stopCommand();
                              },
                              child: Container(
                                width: 30.w,
                                height: 30.w,
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
                              onTapDown: (detail) {
                                command('down');
                              },
                              onTapUp: (detail) {
                                stopCommand();
                              },
                              child: Container(
                                  width: 30.w,
                                  height: 30.w,
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
                            width: 30.w,
                            height: 30.w,
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
            margin: EdgeInsets.only(top: 85.w),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 80.w,
                  margin: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTapDown: (detail) {
                          startZoom('-1');
                        },
                        onTapUp: (detail) {
                          stopZoom();
                        },
                        child: SvgPicture.asset(
                          Assets.minus,
                          width: 14.w,
                          height: 14.w,
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (detail) {
                          startZoom('1');
                        },
                        onTapUp: (detail) {
                          stopZoom();
                        },
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
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: const Color(0xff2b2f33).withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: _toggleRecording,
                      child: Container(
                        width: 52,
                        height: 52,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xff404447),
                            borderRadius: BorderRadius.circular(60)),
                        child: SvgPicture.asset(
                          Assets.record,
                        ),
                      )),
                  GestureDetector(
                      onTap: _toggleScreenshot,
                      child: Container(
                        width: 52,
                        height: 52,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xff404447),
                            borderRadius: BorderRadius.circular(30)),
                        child: SvgPicture.asset(Assets.camera),
                      )),
                  GestureDetector(
                    onTap: onPlayandPause,
                    child: Container(
                      width: 52,
                      height: 52,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: const Color(0xff404447),
                          borderRadius: BorderRadius.circular(30)),
                      child: SvgPicture.asset(
                        Assets.play,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: _toggleVolumes,
                      child: Container(
                        width: 52,
                        height: 52,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xff404447),
                            borderRadius: BorderRadius.circular(30)),
                        child: SvgPicture.asset(
                          Assets.volume,
                        ),
                      )),
                ],
              ),
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
          VlcPlayer(
            controller: _videoPlayerController,
            aspectRatio: 16 / 9,
            placeholder: Center(child: CircularProgressIndicator()),
          ),
        ]),
        Container(
          width: 120.w,
          height: 120.w,
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
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTapDown: (detail) {
                          command('left');
                        },
                        onTapUp: (detail) {
                          stopCommand();
                        },
                        child: Container(
                            width: 40.w,
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
                        onTapDown: (detail) {
                          command('right');
                        },
                        onTapUp: (detail) {
                          stopCommand();
                        },
                        child: Container(
                            width: 40.w,
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
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTapDown: (detail) {
                            command('up');
                          },
                          onTapUp: (detail) {
                            stopCommand();
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
                          onTapDown: (detail) {
                            command('down');
                          },
                          onTapUp: (detail) {
                            stopCommand();
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
                        width: 40.w,
                        height: 40.w,
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
        Container(
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTapDown: (detail) {
                          startZoom('-1');
                        },
                        onTapUp: (detail) {
                          stopZoom();
                        },
                        child: SvgPicture.asset(
                          Assets.minus,
                          width: 14.w,
                          height: 14.w,
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (detail) {
                          startZoom('1');
                        },
                        onTapUp: (detail) {
                          stopZoom();
                        },
                        child: SvgPicture.asset(
                          Assets.add,
                          width: 14.w,
                          height: 14.w,
                        ),
                      )
                    ],
                  ),
                ))),
        Column(
          children: [
            Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 130.w),
                decoration: BoxDecoration(color: const Color(0xff404447)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: _toggleVolumes,
                          child: Container(
                            width: 48.h,
                            height: 48.h,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              Assets.volume,
                              fit: BoxFit.none,
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            WidgetsFlutterBinding.ensureInitialized();
                            SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.landscapeRight]);
                          },
                          child: Container(
                            width: 48.h,
                            height: 48.h,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              Assets.fullscreen,
                              fit: BoxFit.none,
                            ),
                          ))
                    ])),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(color: const Color(0xff2b2f33)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: _toggleRecording,
                      child: Container(
                        width: 51.861717224121094.h,
                        height: 51.999996185302734.h,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xff404447),
                            borderRadius: BorderRadius.circular(30)),
                        child: SvgPicture.asset(
                          Assets.record,
                        ),
                      )),
                  GestureDetector(
                      onTap: _toggleScreenshot,
                      child: Container(
                        width: 51.861717224121094.h,
                        height: 51.999996185302734.h,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xff404447),
                            borderRadius: BorderRadius.circular(30)),
                        child: SvgPicture.asset(Assets.camera),
                      )),
                  GestureDetector(
                      child: Container(
                    width: 51.861717224121094.h,
                    height: 51.999996185302734.h,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xff404447),
                        borderRadius: BorderRadius.circular(30)),
                    child: SvgPicture.asset(
                      Assets.control,
                    ),
                  )),
                  GestureDetector(
                      onTap: onPlayandPause,
                      child: Container(
                        width: 51.861717224121094.h,
                        height: 51.999996185302734.h,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xff404447),
                            borderRadius: BorderRadius.circular(30)),
                        child: SvgPicture.asset(
                          Assets.play,
                        ),
                      )),
                ],
              ),
            )
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
          headerText: AppLocalizations.of(context).translate('view_direct'),
          onBackPress: onBack,
        ));
  }
}
