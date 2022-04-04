import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/models/camera/cam_details.dart';
import 'package:aiviewcloud/models/region/region.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/stores/global/global_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DeviceInformation extends StatefulWidget {
  @override
  _DeviceInformationState createState() => _DeviceInformationState();
}

class _DeviceInformationState extends State<DeviceInformation>
    with TickerProviderStateMixin {
  late CameraP2PStore _cameraP2PStore;
  late GlobalStore _globalStore;
  late TextEditingController _deviceNameController = TextEditingController();
  late Timer timer;
  CameraDetails? cameraDetails = CameraDetails(seriNumber: '');
  String errorUpdateMessage = '';
  String objectGuid = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    _globalStore = Provider.of<GlobalStore>(context);
    if (arguments != null) {
      objectGuid = arguments["ObjectGuid"].toString();
      timer = Timer(Duration(seconds: 0), () async {
        await _cameraP2PStore.getDetailsByCameraGuid(objectGuid).then((resp) {
          cameraDetails = CameraDetails.fromJson(resp["cameraDetails"]);
          setState(() {});
        });
        await _cameraP2PStore.getRegionList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mGreyColor2,
      body: Stack(
        children: [
          Column(
            children: [
              HeaderWidget(
                headerText: 'Hoàn thành',
              ),
              Expanded(
                child: Container(
                  color: const Color(0xff212529),
                  child: _buildBody(),
                ),
              )
            ],
          ),
          Observer(
            builder: (context) {
              return _cameraP2PStore.success
                  ? SizedBox()
                  : _showErrorMessage(_cameraP2PStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return _cameraP2PStore.loading
                  ? Center(child: CustomProgressIndicatorWidget())
                  : _showErrorMessage(_cameraP2PStore.errorStore.errorMessage);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildCamInfo(),
                // buildRecorderInfo(),
                Visibility(
                  visible: !isPortrait,
                  child: listButtons(),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isPortrait,
          child: listButtons(),
        )
      ],
    );
  }

  Widget buildRecorderInfo() {
    return Column(
      children: [
        Container(
          color: AppColors.mGreyColor2,
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              recorderWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildRecordTitle('Tên thiết bị'),
                    buildRecordTitle('Chi nhánh'),
                    buildRecordTitle('MAC'),
                    buildRecordTitle('Seri Number'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildRecorderData('Đầu ghi'),
                    buildRecorderData('Chưa có'),
                    buildRecorderData('AGDGDADKSH'),
                    buildRecorderData('AGDGDADKSH1233'),
                  ],
                ),
              ),
              penWidget()
            ],
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 8),
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return recorderItem();
          },
        ),
      ],
    );
  }

  Widget buildCamInfo() {
    return Column(
      children: [
        Image.asset(
          Assets.imgCamDefault,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCamTitle('Tên thiết bị:'),
                  buildCamTitle('Chi nhánh:'),
                  buildCamTitle('MAC:'),
                  buildCamTitle('Seri Number:'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCamText(
                    cameraDetails!.cameraName != ''
                        ? cameraDetails!.cameraName
                        : 'Chưa có tên',
                    fontWeight: FontWeight.w700,
                  ),
                  buildCamText(
                    cameraDetails!.regionName != ''
                        ? cameraDetails!.regionName
                        : 'Chưa có chi nhánh',
                  ),
                  buildCamText(objectGuid),
                  buildCamText(cameraDetails?.seriNumber ?? 'Chưa có số seri'),
                ],
              ),
            ),
            penWidget(
              paddingRight: 8.0,
              deviceName: cameraDetails?.cameraName,
              branch: cameraDetails?.regionName ?? '',
            )
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget penWidget({double? paddingRight, String? branch, String? deviceName}) {
    return InkWell(
      onTap: () async {
        await showEditDeviceBottomSheet(
                branch: branch ?? '', deviceName: deviceName ?? '')
            .then((value) {
          if (value != null) {
            setState(() {
              cameraDetails!.cameraName = _deviceNameController.text.trim();
              cameraDetails!.regionName = value;
            });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: paddingRight ?? 0),
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          Assets.icPen,
          color: AppColors.mOrangeColor,
        ),
      ),
    );
  }

  Widget recorderItem() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.mGreyColor2,
      ),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.icVideo,
            width: 32,
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRecordTitle('Tên thiết bị'),
                buildRecordTitle('Chi nhánh'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRecorderData('Đầu ghi'),
                buildRecorderData('Hà Nội'),
              ],
            ),
          ),
          penWidget()
        ],
      ),
    );
  }

  Text buildRecordTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: FontFamily.roboto,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.mWhiteColor,
      ),
    );
  }

  Text buildRecorderData(String data) {
    return Text(
      data,
      style: TextStyle(
          fontFamily: FontFamily.roboto,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.mWhiteColor,
          overflow: TextOverflow.ellipsis),
    );
  }

  Text buildCamTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: FontFamily.sfProDisplay,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.mWhiteColor.withOpacity(.7),
      ),
    );
  }

  Text buildCamText(String data, {FontWeight? fontWeight, double? fontSize}) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: FontFamily.sfProDisplay,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: AppColors.mWhiteColor,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Stack recorderWidget() {
    return Stack(
      children: [
        SvgPicture.asset('assets/icons/ic_recoder_bg.svg'),
        Positioned(
          left: 0,
          right: 0,
          top: 22,
          child: SvgPicture.asset('assets/icons/ic_recoder_content.svg'),
        ),
      ],
    );
  }

  Widget listButtons() {
    return Padding(
      padding: EdgeInsets.only(bottom: 32, left: 16, right: 16),
      child: Column(
        children: [
          SMEButton(
            onPress: () {},
            title: AppLocalizations.of(context).translate('view_direct'),
            primaryColor: AppColors.mGreenColor,
          ),
          SizedBox(height: 12),
          SMEButton(
            onPress: () {
              Navigator.of(context).pushNamed(Routes.searchingDevice);
            },
            title: AppLocalizations.of(context).translate('add_more'),
            primaryColor: AppColors.mOrangeColor,
          ),
          SizedBox(height: 12),
          SMEButton(
            onPress: () {
              _globalStore.setRoute(Preferences.drawerDeviceManagement);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.deviceManagement, (Route<dynamic> route) => false);
            },
            title: AppLocalizations.of(context).translate('done'),
            primaryColor: AppColors.mGreyColor1,
          ),
        ],
      ),
    );
  }

  Future showEditDeviceBottomSheet(
      {required String branch, required String deviceName}) {
    _deviceNameController.text = deviceName;
    if (_deviceNameController.text != '') {
      errorUpdateMessage = '';
    }
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        final height = MediaQuery.of(context).size.height;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: isPortrait ? height / 1.5 : height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mGreyColor3,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 6,
                      width: 90,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mWhiteColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCamText(
                          'Đổi tên thiết bị',
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 4),
                          child: buildCamText(
                            'Tên',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.mGreyColor2,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _deviceNameController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Nhập tên',
                              hintStyle: TextStyle(
                                fontFamily: FontFamily.sfProDisplay,
                                fontSize: 17,
                                color: AppColors.mGreyColor1,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: FontFamily.sfProDisplay,
                              fontSize: 17,
                              color: AppColors.mWhiteColor,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _deviceNameController.text == '',
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              errorUpdateMessage,
                              style: TextStyle(
                                color: AppColors.mRedColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProDisplay",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 4),
                          child: buildCamText(
                            'Chi nhánh',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.mGreyColor2,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButton<Region>(
                            items:
                                _cameraP2PStore.regionList.map((Region region) {
                              return DropdownMenuItem<Region>(
                                value: region,
                                child: Text(
                                  region.regionName,
                                ),
                              );
                            }).toList(),
                            value: getBranchIndexByName(branch) != -1
                                ? _cameraP2PStore
                                    .regionList[getBranchIndexByName(branch)]
                                : null,
                            onChanged: (value) {
                              setState(() {
                                branch = value!.regionName;
                              });
                            },
                            underline: SizedBox(),
                            isExpanded: true,
                            icon: SvgPicture.asset(Assets.icDropDown),
                            hint: Text(
                              AppLocalizations.of(context)
                                  .translate('select_apartment'),
                              style: TextStyle(
                                fontFamily: FontFamily.sfProDisplay,
                                fontSize: 14,
                                color: AppColors.mGreyColor1,
                              ),
                            ),
                            dropdownColor: AppColors.mGreyColor2,
                            style: TextStyle(
                              fontFamily: FontFamily.sfProDisplay,
                              fontSize: 14,
                              color: AppColors.mWhiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SMEButton(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    title: AppLocalizations.of(context).translate('cancel'),
                    primaryColor: AppColors.mGreyColor1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 32),
                    child: SMEButton(
                      onPress: () async {
                        if (_deviceNameController.text.trim().isEmpty) {
                          setState(() {
                            errorUpdateMessage = AppLocalizations.of(context)
                                .translate('not_empty');
                          });
                        } else {
                          final resp = await _cameraP2PStore.updateCamera(
                              objectGuid: objectGuid,
                              cameraName: _deviceNameController.text.trim(),
                              objectId: getBranchIndexByName(branch) != -1
                                  ? _cameraP2PStore
                                      .regionList[getBranchIndexByName(branch)]
                                      .regionId
                                  : null);
                          if (!resp["isError"]) {
                            Navigator.pop(
                              context,
                              getBranchIndexByName(branch) != -1
                                  ? _cameraP2PStore
                                      .regionList[getBranchIndexByName(branch)]
                                      .regionName
                                  : '',
                            );
                          }
                        }
                      },
                      title: AppLocalizations.of(context).translate('save'),
                      primaryColor: AppColors.mOrangeColor,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  int getBranchIndexByName(String branch) {
    return _cameraP2PStore.regionList
        .indexWhere((element) => element.regionName == branch);
  }

  @override
  void dispose() {
    _deviceNameController.dispose();
    timer.cancel();
    super.dispose();
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
