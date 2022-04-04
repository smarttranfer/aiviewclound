import 'dart:async';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/ui/device_management/widget_list_filter.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/cam_item_widge_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

class CameraListWidget extends StatefulWidget {
  final int selectedIndex;
  Function? onClose;

  CameraListWidget({Key? key, required this.selectedIndex, this.onClose})
      : super(key: key);

  @override
  _CameraListWidgetState createState() => _CameraListWidgetState();
}

class _CameraListWidgetState extends State<CameraListWidget> {
  late CameraP2PStore _cameraP2PStore;
  late ScrollController controller;

  int cameraSelectedIndex = -1;
  List<CameraP2P> multipleSelect = [];
  bool showOptions = false;
  bool showClearText = false;
  bool isFilter = false;
  Timer? timer;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = new ScrollController()..addListener(_scrollListener);
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    // if (!_cameraP2PStore.loading) {
    //   _cameraP2PStore.refresh();
    // }
    // _cameraP2PStore.getRegionList();
  }

  Future<void> _pullRefresh() async {
    _cameraP2PStore.refresh();
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      _cameraP2PStore.getCameraList({}, isLoadMore: true);
    }
  }

  void onDoneSelected() {
    // if (widget.selectedIndex > -1) {
    // if (cameraSelectedIndex > -1) {
    _cameraP2PStore.addCameraToEmptySlot(
        0, _cameraP2PStore.cameraP2PList[cameraSelectedIndex]);
    //}
    // } else {
    //   _cameraP2PStore.addCamera(multipleSelect);
    // }
    widget.onClose!();
    setState(() {
      cameraSelectedIndex = -1;
      // multipleSelect = [];
    });
  }

  void onSelect(e) {
    if (_cameraP2PStore.selectedCamera.contains(e) || !e.isConnected) return;
    setState(() {
      widget.selectedIndex > -1
          ? cameraSelectedIndex =
              cameraSelectedIndex == _cameraP2PStore.cameraP2PList.indexOf(e)
                  ? -1
                  : _cameraP2PStore.cameraP2PList.indexOf(e)
          : multipleSelect.contains(e)
              ? multipleSelect.remove(e)
              : multipleSelect.add(e);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                          _cameraP2PStore.openFilterPU();
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
                  _pullRefresh();
                } else {
                  _cameraP2PStore.openFilterPU();
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
        // SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Observer(builder: (context) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    width: 90.w,
                    height: 6,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: const Color(0xffffffff))),
                buildSearchWidget(),
                Expanded(
                    child: RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: GridView.count(
                          controller: controller,
                          crossAxisCount: 2,
                          childAspectRatio: 16 / 11,
                          crossAxisSpacing: 4.w,
                          mainAxisSpacing: 4.w,
                          children: _cameraP2PStore.cameraP2PList
                              .map((e) => GestureDetector(
                                  onTap: () {
                                    onSelect(e);
                                  },
                                  child: Opacity(
                                      opacity: _cameraP2PStore.selectedCamera
                                              .contains(e)
                                          ? 0.5
                                          : 1,
                                      child: CamItemModal(
                                        camera: e,
                                        selected: widget.selectedIndex > -1
                                            ? cameraSelectedIndex ==
                                                _cameraP2PStore.cameraP2PList
                                                    .indexOf(e)
                                            : multipleSelect.contains(e),
                                      ))))
                              .toList(),
                        ))),
                SMEButton(
                  title: AppLocalizations.of(context).translate('done'),
                  onPress:
                      (multipleSelect.length != 0 || cameraSelectedIndex > -1)
                          ? onDoneSelected
                          : null,
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x1a000000),
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      spreadRadius: 0)
                ],
                color: const Color(0xff212529)));
      }),
      Observer(builder: (context) {
        return Visibility(
          visible: _cameraP2PStore.isOpenPU,
          child: Container(
            margin: EdgeInsets.only(top: 100.h),
            padding: EdgeInsets.only(bottom: 50.h),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: AppColors.mGreyColor2,
                borderRadius: BorderRadius.circular(8)),
            child: _cameraP2PStore.regionList.isNotEmpty
                ? Observer(
                    builder: (BuildContext context) {
                      print(
                          'filter data: ${_cameraP2PStore.selectedFilterItems}');
                      return WidgetListFilter(
                        listPrimaryRegion: _cameraP2PStore.regionList,
                        search: _searchTextController,
                      );
                    },
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(AppLocalizations.of(context)
                            .translate('filter_not_found'))),
                  ),
          ),
        );
      }),
    ]);
  }
}
