import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/bottom_camera_action_widget.dart';
import 'package:aiviewcloud/widgets/bottom_camera_menu_widget.dart';
import 'package:aiviewcloud/widgets/bottom_camera_menu_widget_portrait.dart';
import 'package:aiviewcloud/widgets/cam_item_widget.dart';
import 'package:aiviewcloud/widgets/cam_item_widget_empty.dart';
import 'package:aiviewcloud/widgets/camera_list_bottom_sheet_widget.dart';
import 'package:aiviewcloud/widgets/header_landscape_mode.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum Channel {
  MAIN,
  SUB,
}

class LiveCamScreen extends StatefulWidget {
  @override
  _LiveCamScreenScreenState createState() => _LiveCamScreenScreenState();
}

class _LiveCamScreenScreenState extends State<LiveCamScreen> {
  Offset offset = Offset.zero;
  PanelController _pc = new PanelController();

  late CameraP2PStore _cameraP2PStore;
  late UserStore _userStore;
  int selected = 0;
  int mode = 2;
  int selectedIndex = -1;
  int currentPage = 0;
  int pageSize = 1;
  bool isShowAction = true;
  bool isClose = false;
  bool isRecording = false;
  bool isCapture = false;
  String direction = "";
  String zoom = "0";
  Channel channel = Channel.MAIN;
  late CameraP2P camInfo;
  @override
  void initState() {
    super.initState();
    // postData(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    _userStore = Provider.of<UserStore>(context);
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    camInfo = arguments["cameraInfo"] as CameraP2P;
    _cameraP2PStore.addCameraToView(camInfo);
  }

  void onSelectCamera() {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // _cameraP2PStore.onSelectCameraOnView(index);
    setState(() {
      isShowAction = isportrait ? isShowAction : !isShowAction;
    });
  }

  void onControl() async {
    if (_cameraP2PStore.camOnView[_cameraP2PStore.selectedIndex] != null) {
      CameraP2P? selectedCam =
          _cameraP2PStore.camOnView[_cameraP2PStore.selectedIndex];
      // _cameraP2PStore.saveTempCameraOnView();
      final result = await Navigator.of(context)
          .pushNamed(Routes.ptzControl, arguments: {'cameraInfo': selectedCam});
      if (result == 'back') {
        _cameraP2PStore.clearTempCamera();
      }
    }
  }

  void switchGridMode(modeParam, int index) {
    setState(() {
      mode = modeParam;
      pageSize = modeParam == 1 ? 1 : 4;
    });
    _cameraP2PStore.onSwitchMode(modeParam, index);
  }

  void nextPage() {
    int nextPage = _cameraP2PStore.currentViewPage + 1 <
            (_cameraP2PStore.selectedCamera.length / pageSize).ceil()
        ? _cameraP2PStore.currentViewPage + 1
        : _cameraP2PStore.currentViewPage;

    _cameraP2PStore.onNextPage(nextPage, mode);
  }

  void previousPage() {
    int prevPage = _cameraP2PStore.currentViewPage > 0
        ? _cameraP2PStore.currentViewPage - 1
        : 0;
    _cameraP2PStore.onPreviousPage(prevPage, mode);
  }

  onShowBottomModal(index) async {
    setState(() {
      selectedIndex = index;
    });

    await _pc.open();
  }

  void command(params) {
    setState(() {
      direction = params;
    });
  }

  Widget buildControl() {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: isportrait ? 170.w : 80.w,
      height: isportrait ? 170.w : 80.w,
      margin: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
          color: Colors.blue,
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
              padding:
                  EdgeInsets.symmetric(horizontal: isportrait ? 16.w : 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTapDown: (detail) {
                      command('left');
                    },
                    onTapUp: (detail) {
                      command('stop');
                    },
                    child: Container(
                        width: isportrait ? 50.w : 30.w,
                        height: isportrait ? 50.w : 30.w,
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
                      command('stop');
                    },
                    child: Container(
                        width: isportrait ? 50.w : 30.w,
                        height: isportrait ? 50.w : 30.w,
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
                      onTapDown: (detail) {
                        command('up');
                      },
                      onTapUp: (detail) {
                        command('stop');
                      },
                      child: Container(
                        width: isportrait ? 50.w : 30.w,
                        height: isportrait ? 50.w : 30.w,
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
                        command('stop');
                      },
                      child: Container(
                          width: isportrait ? 50.w : 30.w,
                          height: isportrait ? 50.w : 30.w,
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
                    width: isportrait ? 60.w : 35.w,
                    height: isportrait ? 60.w : 35.w,
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
    );
  }

  onTrashPress() {
    _cameraP2PStore.removeAllCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraP2PStore.removeAllCamera();
  }

  onCloseModal() async {
    isClose = true;
    await _pc.close();
  }

  setIsCapture(bool captureFrame) {
    setState(() {
      isCapture = captureFrame;
    });
  }

  Widget buildBodyLandcapes() {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Stack(
      children: [
        Column(children: [
          GestureDetector(
              onTap: onSelectCamera,
              child: Observer(builder: (context) {
                return Container(
                    margin: EdgeInsets.only(top: isportrait ? 48.h : 0),
                    child: _cameraP2PStore.camOnView[0] == null
                        ? CamItemEmpty()
                        : CamItem(
                            isRecording: isRecording,
                            isCapture: isCapture,
                            channel: channel,
                            direction: direction,
                            zoom: direction,
                            setIsCapture: setIsCapture,
                            camera: _cameraP2PStore.camOnView[0]!,
                            userStore: _userStore));
              })),
        ]),
        isportrait
            ? HeaderWidget(
                headerText:
                    AppLocalizations.of(context).translate('view_direct'),
                actionWidget: GestureDetector(
                    onTap: () {
                      onShowBottomModal(0);
                    },
                    child: Container(
                      width: 48.h,
                      height: 48.h,
                      color: Colors.transparent,
                      child:
                          // Adobe XD layer: 'Vector' (shape)
                          SvgPicture.asset(
                        Assets.group_camera,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.none,
                      ),
                    )),
              )
            : isShowAction
                ? HeaderLandscapeWidget(
                    onBackPress: () {
                      SystemChrome.setPreferredOrientations(
                          [DeviceOrientation.portraitUp]);
                    },
                    headerText:
                        AppLocalizations.of(context).translate('view_direct'),
                  )
                : Container(),
        Positioned(
            bottom: 0.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                isportrait
                    ? BottomActionCamera(
                        onTrashPress: onTrashPress,
                        onFullScreenPress: () {
                          WidgetsFlutterBinding.ensureInitialized();
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeRight]);
                        },
                        channel: channel,
                        onHdModePress: () {
                          setState(() {
                            channel = channel == Channel.MAIN
                                ? Channel.SUB
                                : Channel.MAIN;
                          });
                        },
                      )
                    : Container(
                        color: Colors.transparent,
                      ),
                isportrait
                    ? BottomMenuCamera(
                        onControlPress: (_cameraP2PStore.camOnView[0] != null &&
                                _cameraP2PStore.camOnView[0]!.isPTZ)
                            ? onControl
                            : null,
                        onSnapshotPress: () {
                          setState(() {
                            isCapture = !isCapture;
                          });
                        },
                      )
                    : isShowAction
                        ? BottomMenuCameraLandcape(
                            onSnapshotPress: () {
                              setState(() {
                                isCapture = !isCapture;
                              });
                            },
                            onTrashPress: onTrashPress,
                            onFullScreenPress: () {
                              WidgetsFlutterBinding.ensureInitialized();
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.landscapeRight]);
                            },
                            channel: channel,
                            onHdModePress: () {
                              setState(() {
                                channel = channel == Channel.MAIN
                                    ? Channel.SUB
                                    : Channel.MAIN;
                              });
                            },
                            onControlPress:
                                (_cameraP2PStore.camOnView[0] != null &&
                                        _cameraP2PStore.camOnView[0]!.isPTZ)
                                    ? onControl
                                    : null,
                          )
                        : Container(),
              ],
            )),
        (_cameraP2PStore.camOnView[0] != null &&
                _cameraP2PStore.camOnView[0]!.isPTZ)
            ? Positioned(
                left: 0,
                right: 0,
                top: isportrait ? 330 : MediaQuery.of(context).size.height / 7,
                child: Align(
                  alignment:
                      isportrait ? Alignment.topCenter : Alignment.centerLeft,
                  child: Column(children: [
                    Container(
                        margin: EdgeInsets.only(bottom: isportrait ? 0.h : 0),
                        child: buildControl()),
                    Container(
                      width: isportrait ? 120.w : 70.w,
                      margin: EdgeInsets.only(left: 16.w, top: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTapDown: (detail) {
                              setState(() {
                                zoom = "-1";
                              });
                            },
                            onTapUp: (detail) {
                              setState(() {
                                zoom = "0";
                              });
                            },
                            child: SvgPicture.asset(
                              Assets.minus,
                              width: 15.w,
                              height: 15.w,
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (detail) {
                              setState(() {
                                zoom = "1";
                              });
                            },
                            onTapUp: (detail) {
                              setState(() {
                                zoom = "0";
                              });
                            },
                            child: SvgPicture.asset(
                              Assets.add,
                              width: 15.w,
                              height: 15.w,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ))
            : Container(),
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
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: SlidingUpPanel(
          controller: _pc,
          color: Colors.transparent,
          maxHeight: MediaQuery.of(context).size.height - 70.h,
          minHeight: 0,
          // onPanelSlide: (position) {
          //   if (!isClose) {
          //     if (position > 0.7) {
          //       _pc.animatePanelToPosition(1);
          //       return;
          //     }
          //     if (position < 0.7 && position > 0.3) {
          //       _pc.animatePanelToPosition(0.5);
          //       return;
          //     }
          //   }
          // },
          onPanelClosed: () {
            isClose = false;
            // _cameraP2PStore.refresh();
          },
          panel: CameraListWidget(
              selectedIndex: selectedIndex, onClose: onCloseModal),
          body: SafeArea(child: buildBodyLandcapes()
              // Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //   isportrait
              //       ? HeaderWidget(
              //           headerText: 'Xem trực tiếp',
              //           actionWidget: GestureDetector(
              //               onTap: () {
              //                 onShowBottomModal(0);
              //               },
              //               child: Container(
              //                 width: 48.h,
              //                 height: 48.h,
              //                 color: Colors.transparent,
              //                 child:
              //                     // Adobe XD layer: 'Vector' (shape)
              //                     SvgPicture.asset(
              //                   Assets.group_camera,
              //                   allowDrawingOutsideViewBox: true,
              //                   fit: BoxFit.none,
              //                 ),
              //               )),
              //         )
              //       : isShowAction
              //           ? HeaderLandscapeWidget(
              //               onBackPress: () {
              //                 SystemChrome.setPreferredOrientations(
              //                     [DeviceOrientation.portraitUp]);
              //               },
              //               headerText: 'Xem trực tiếp',
              //             )
              //           : Container(),
              //   GestureDetector(
              //       onTap: onSelectCamera,
              //       child: Observer(builder: (context) {
              //         return AspectRatio(
              //             aspectRatio: 16 / 9,
              //             child: Container(
              //                 child: _cameraP2PStore.camOnView[0] == null
              //                     ? CamItemEmpty()
              //                     : CamItem(
              //                         isRecording: isRecording,
              //                         isCapture: isCapture,
              //                         channel: channel,
              //                         setIsCapture: setIsCapture,
              //                         camera: _cameraP2PStore.camOnView[0]!,
              //                         userStore: _userStore)));
              //       })),
              //   buildControl(),
              //   Column(
              //     children: [
              //       isportrait
              //           ? BottomActionCamera(
              //               onTrashPress: onTrashPress,
              //               onFullScreenPress: () {
              //                 WidgetsFlutterBinding.ensureInitialized();
              //                 SystemChrome.setPreferredOrientations(
              //                     [DeviceOrientation.landscapeRight]);
              //               },
              //               onHdModePress: () {
              //                 setState(() {
              //                   channel = channel == Channel.MAIN
              //                       ? Channel.SUB
              //                       : Channel.MAIN;
              //                 });
              //               },
              //             )
              //           : Container(
              //               color: Colors.transparent,
              //             ),
              //       isportrait
              //           ? BottomMenuCamera(
              //               onControlPress: onControl,
              //               // onRecordPress: () {
              //               //   setState(() {
              //               //     isRecording = !isRecording;
              //               //   });
              //               // },
              //               onSnapshotPress: () {
              //                 setState(() {
              //                   isCapture = !isCapture;
              //                 });
              //               },
              //             )
              //           : isShowAction
              //               ? BottomMenuCameraLandcape(
              //                   onControlPress: onControl)
              //               : Container(),
              //     ],
              //   )
              // ])
              )),
    );
  }
}
