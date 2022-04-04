import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/ui/device_management/widget_list_filter.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/cam_list_item_widget.dart';
import 'package:aiviewcloud/widgets/drawer_header_widget.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

class DeviceManagement extends StatefulWidget {
  @override
  _DeviceManagementState createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  Offset offset = Offset.zero;
  late ScrollController _deviceListController;
  late CameraP2PStore _cameraP2PStore;
  late UserStore _userStore;
  bool showOptions = false;
  bool showClearText = false;
  bool isStart = false;
  TextEditingController _searchTextController = TextEditingController();
  MqttClientService mqttClientServices = MqttClientService();

  Timer? timer;
  String currentPlayCamId = '';

  @override
  void initState() {
    super.initState();
  }

  void setCurrentCamPlay(id) {
    setState(() {
      currentPlayCamId = id;
    });
  }

  @override
  void didChangeDependencies() {
    _deviceListController = new ScrollController()
      ..addListener(_scrollListener);
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    _userStore = Provider.of<UserStore>(context);
    if (!_cameraP2PStore.loading) {
      _cameraP2PStore.refresh(
        keyName: _searchTextController.text.trim(),
        keyRegionGuid: _cameraP2PStore.keyRegionGuid,
      );
    }
    mqttClientServices.init(_userStore.peer!);

    _cameraP2PStore.getRegionList();
    super.didChangeDependencies();
  }

  Future<void> _pullRefresh() async {
    _cameraP2PStore.refresh(
      keyName: _searchTextController.text.trim(),
      keyRegionGuid: _cameraP2PStore.keyRegionGuid,
    );
  }

  void _scrollListener() {
    if (_deviceListController.offset >=
            _deviceListController.position.maxScrollExtent &&
        !_deviceListController.position.outOfRange) {
      _cameraP2PStore.getCameraList(
        {},
        isLoadMore: true,
        keyName: _searchTextController.text.trim(),
        keyRegionGuid: _cameraP2PStore.keyRegionGuid,
      );
    }
  }

  @override
  void dispose() {
    _deviceListController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  Widget _buildListView() {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Stack(
        children: [
          Column(
            children: [
              buildSearchWidget(),
              Visibility(
                visible: !_cameraP2PStore.loading &&
                    _cameraP2PStore.cameraP2PList.length == 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: Text(
                    'Bạn chưa có thiết bị nào!',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  controller: _deviceListController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.only(top: 0),
                  itemCount: _cameraP2PStore.cameraP2PList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Visibility(
                        visible: _cameraP2PStore.cameraP2PList.length != 0,
                        child: Text(
                          'Danh sách thiết bị',
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: buildItem(
                        context,
                        _cameraP2PStore.cameraP2PList[index - 1],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: _cameraP2PStore.isOpenPU,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.only(bottom: 50),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColors.mGreyColor2,
                  borderRadius: BorderRadius.circular(8)),
              child: _cameraP2PStore.regionList.isNotEmpty
                  ? Observer(
                      builder: (BuildContext context) {
                        return WidgetListFilter(
                          listPrimaryRegion: _cameraP2PStore.regionList,
                          search: _searchTextController,
                        );
                      },
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                        'Không tìm thấy bộ lọc',
                        style: textStyle,
                      )),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearchWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xff2B2F33),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SvgPicture.asset(Assets.search),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchTextController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          _cameraP2PStore.refresh(
                              keyName: value,
                              keyRegionGuid: _cameraP2PStore.keyRegionGuid);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Tìm kiếm',
                          hintStyle: textStyle.copyWith(
                            height: 1.3,
                            color: AppColors.mGreyColor1,
                          ),
                          suffixIcon: Visibility(
                            visible: showClearText,
                            child: GestureDetector(
                              onTap: () {
                                _searchTextController.clear();
                                setState(() {
                                  showClearText = false;
                                });
                                _pullRefresh();
                              },
                              child: Icon(
                                Icons.highlight_remove_sharp,
                                color: AppColors.mWhiteColor,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            if (showClearText) {
                              setState(() {
                                showClearText = false;
                              });
                            }
                          } else {
                            if (!showClearText) {
                              setState(() {
                                showClearText = true;
                              });
                            }
                          }
                          if (timer != null) {
                            timer!.cancel();
                          }
                          timer = Timer(const Duration(milliseconds: 300), () {
                            _pullRefresh();
                          });
                        },
                        style: textStyle.copyWith(
                          height: 1.3,
                          color: AppColors.mWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              color: AppColors.mGreyColor2,
              onPressed: () {
                if (_cameraP2PStore.isFilter) {
                  _cameraP2PStore.cancelFilter();
                  _cameraP2PStore.getCameraList(
                    {},
                    isLoadMore: true,
                    keyName: _searchTextController.text.trim(),
                    keyRegionGuid: _cameraP2PStore.keyRegionGuid,
                  );
                } else if (!_cameraP2PStore.isOpenPU) {
                  _cameraP2PStore.openFilterPU();
                } else {
                  _cameraP2PStore.popFilter();
                }
              },
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.filter),
                    SizedBox(width: 8.w),
                    Text(
                      _cameraP2PStore.isFilter ? 'Huỷ' : 'Lọc',
                      style: textStyle.copyWith(
                        color: _cameraP2PStore.isFilter
                            ? AppColors.mRedColor
                            : AppColors.mWhiteColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void onTap(cameraP2P) async {
    if (cameraP2P != null) {
      await Navigator.of(context)
          .pushNamed(Routes.liveCam, arguments: {'cameraInfo': cameraP2P});
    }
  }

  Widget buildItem(context, CameraP2P cameraP2P) {
    return CamListItem(
      userStore: _userStore,
      camera: cameraP2P,
      setCurrentCamplay: setCurrentCamPlay,
      currentPlayCamId: currentPlayCamId,
    );
  }

  onShowDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(right: 16, top: 36),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 200.w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.mGreyColor2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showOptions = false;
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(Routes.addDeviceByQRCodeScreen);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            children: [
                              SvgPicture.string(
                                qrcode,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  'Quét mã QR',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    color: AppColors.mWhiteColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showOptions = false;
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(Routes.addDevice);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Row(children: [
                            SvgPicture.string(
                              edit,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                'Nhập thủ công',
                                style: textStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              showOptions = false;
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(Routes.viewLan);
                          },
                          child: Row(
                            children: [
                              SvgPicture.string(
                                wifi,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  'Quét trong LAN',
                                  style: textStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      drawer: SMEDrawer(),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          DrawerHeaderWidget(
            headerText:
                AppLocalizations.of(context).translate('device_management'),
            rightWidget: GestureDetector(
              onTap: () {
                onShowDialog();
                // setState(() {
                //   showOptions = !showOptions;
                // });
                // Navigator.of(context).pushNamed(Routes.addDevice);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: SvgPicture.string(
                  _svg_cy5,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: _buildListView(),
                );
              },
            ),
          ),
          Observer(
            builder: (context) {
              return _cameraP2PStore.success
                  ? SizedBox()
                  : _showErrorMessage(_cameraP2PStore.errorStore.errorMessage);
            },
          ),
        ],
      )),
    );
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }
}

const String _svg_cy5 =
    '<svg viewBox="343.0 60.0 16.0 16.0" ><path transform="translate(343.0, 60.0)" d="M 8 16 C 3.581721782684326 16 0 12.41827774047852 0 8 C 0 3.581721782684326 3.581721782684326 0 8 0 C 12.41827774047852 0 16 3.581721782684326 16 8 C 15.99515056610107 12.41626739501953 12.41626739501953 15.99515056610107 8 16 Z M 1.600000023841858 8.137599945068359 C 1.637852907180786 11.65859222412109 4.512886047363281 14.48763465881348 8.034030914306641 14.46879863739014 C 11.55517578125 14.44978141784668 14.39963054656982 11.58999538421631 14.39963054656982 8.068798065185547 C 14.39963054656982 4.547604560852051 11.55517578125 1.687819123268127 8.034030914306641 1.668798089027405 C 4.512886047363281 1.649965763092041 1.637852907180786 4.479008197784424 1.600000023841858 8 L 1.600000023841858 8.137599945068359 Z M 8.800000190734863 12 L 7.199999809265137 12 L 7.199999809265137 8.800000190734863 L 4 8.800000190734863 L 4 7.199999809265137 L 7.199999809265137 7.199999809265137 L 7.199999809265137 4 L 8.800000190734863 4 L 8.800000190734863 7.199999809265137 L 12 7.199999809265137 L 12 8.800000190734863 L 8.800000190734863 8.800000190734863 L 8.800000190734863 12 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String qrcode =
    '<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2.66667 2.66667H4.44444V4.44444H2.66667V2.66667Z" fill="white"/><path d="M0 7.11111V0H7.11111V7.11111H0ZM1.77778 1.77778V5.33333H5.33333V1.77778H1.77778Z" fill="white"/><path d="M8.88889 8.88889H11.5556V10.6667H8.88889V8.88889Z" fill="white"/><path d="M11.5556 10.6667H13.3333V8.88889H16V11.5556H13.3333V12.4444H14.2222V13.3333H16V16H14.2222V14.2222H12.4444V16H8.88889V12.4444H10.6667V14.2222H11.5556V10.6667Z" fill="white"/><path d="M13.3333 2.66667H11.5556V4.44444H13.3333V2.66667Z" fill="white"/><path d="M8.88889 0V7.11111H16V0H8.88889ZM14.2222 1.77778V5.33333H10.6667V1.77778H14.2222Z" fill="white"/><path d="M2.66667 11.5556H4.44444V13.3333H2.66667V11.5556Z" fill="white"/><path d="M0 16V8.88889H7.11111V16H0ZM1.77778 10.6667V14.2222H5.33333V10.6667H1.77778Z" fill="white"/></svg>';
const String edit =
    '<svg width="18" height="17" viewBox="0 0 18 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.88477 16H16.7697" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12.8274 1.54434C13.1759 1.1958 13.6486 1 14.1415 1C14.3856 1 14.6272 1.04807 14.8527 1.14147C15.0782 1.23487 15.2831 1.37176 15.4557 1.54434C15.6282 1.71692 15.7651 1.92179 15.8585 2.14728C15.9519 2.37276 16 2.61443 16 2.85849C16 3.10255 15.9519 3.34422 15.8585 3.5697C15.7651 3.79519 15.6282 4.00006 15.4557 4.17264L4.5044 15.1239L1 16L1.8761 12.4956L12.8274 1.54434Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
const String wifi =
    '<svg width="18" height="14" viewBox="0 0 18 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 12.3403H9.00853" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M6.37622 9.39941C7.14386 8.85404 8.06217 8.56104 9.00382 8.56104C9.94547 8.56104 10.8638 8.85404 11.6314 9.39941" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M3.707 6.70683C5.20157 5.46197 7.08515 4.78027 9.03025 4.78027C10.9754 4.78027 12.8589 5.46197 14.3535 6.70683" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M1 4.02257C3.20977 2.07472 6.05429 1 9 1C11.9457 1 14.7902 2.07472 17 4.02257" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
