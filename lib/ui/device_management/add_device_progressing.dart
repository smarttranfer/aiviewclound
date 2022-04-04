import 'dart:async';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'internet_connection.dart';

class AddDeviceProgressing extends StatefulWidget {
  @override
  _AddDeviceProgressingState createState() => _AddDeviceProgressingState();
}

class _AddDeviceProgressingState extends State<AddDeviceProgressing>
    with TickerProviderStateMixin {
  late AnimationController controller;
  int _percent = 0;
  late CameraP2PStore _cameraP2PStore;
  late Timer timer;
  String _message = '';
  bool _isAddDeviceError = false;
  CameraP2P? addedCamResponse;
  bool isAlreadyAddDevice = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {
          if (_percent != 100) {
            _percent = (controller.value * 100).toInt();
          }
        });
      });
    controller.forward();
    super.initState();
  }

  String _serial = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    if (arguments != null) {
      setState(() {
        _serial = arguments["serial"].toString();
      });
      timer = Timer(Duration(seconds: 0), () async {
        if (!isAlreadyAddDevice) {
          await addDevice();
        }
      });
    }
  }

  Future<void> addDevice() async {
    final resp = await _cameraP2PStore.addDevice({"Serial": _serial});
    _isAddDeviceError = resp["isError"];
    isAlreadyAddDevice = true;
    if (!_isAddDeviceError) {
      addedCamResponse = CameraP2P.fromJson(resp["Object"]);
    }
    Future.delayed(Duration(milliseconds: 500), () {
      _percent = 100;
    });
    if (_isAddDeviceError) {
      _message = 'Thêm thiết bị thất bại !';
    } else {
      _message =
          'Thêm thiết bị thành công.\nBấm tiếp tục để chỉnh sửa thông tin thiết bị của bạn!';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: ScreenWidget(
        widget: Stack(
          children: [
            _buildBody(),
            Observer(
              builder: (context) {
                return _cameraP2PStore.success
                    ? SizedBox()
                    : _showErrorMessage(
                        _cameraP2PStore.errorStore.errorMessage);
              },
            ),
          ],
        ),
        headerText: AppLocalizations.of(context).translate('check'),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SvgPicture.asset(Assets.icVideo),
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 28),
          child: Text(
            'Seri: $_serial',
            style: TextStyle(
              fontFamily: FontFamily.roboto,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.mWhiteColor,
            ),
          ),
        ),
        (_percent == 100)
            ? Text(
                _message,
                style: TextStyle(
                  fontFamily: FontFamily.roboto,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _isAddDeviceError
                      ? AppColors.mRedColor
                      : AppColors.mGreenColor,
                ),
                textAlign: TextAlign.center,
              )
            : progressBarWidget(),
        Spacer(),
        Visibility(
          visible: !_isAddDeviceError,
          child: SMEButton(
            onPress: () {
              InternetConnection.instance.connectivity
                  .checkConnectivity()
                  .then((connectivityResult) {
                if (connectivityResult == ConnectivityResult.none) {
                  FlushbarHelper.createError(
                    message: 'Không có mạng',
                    title:
                        AppLocalizations.of(context).translate('home_tv_error'),
                    duration: Duration(seconds: 3),
                  )..show(context);
                } else {
                  Navigator.pushNamed(
                    context,
                    Routes.deviceInformation,
                    arguments: {
                      "ObjectGuid": addedCamResponse?.objectGuid ?? ""
                    },
                  );
                }
              });
            },
            title: AppLocalizations.of(context).translate('Tiếp tục'),
          ),
        ),
      ],
    );
  }

  Widget progressBarWidget() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: FontFamily.roboto,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.mWhiteColor,
            ),
            children: [
              TextSpan(text: 'Loading...  '),
              TextSpan(
                text: '$_percent%',
                style: TextStyle(
                  fontFamily: FontFamily.roboto,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mOrangeColor,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 16.h),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: controller.value,
              backgroundColor: AppColors.mGreyColor1,
              color: AppColors.mOrangeColor,
            ),
          ),
        ),
        Center(
          child: Text(
            'Đang thêm thiết bị vào tài khoản... Vui lòng chờ !',
            style: TextStyle(
              fontFamily: FontFamily.roboto,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.mWhiteColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 500), () {
        _percent = 100;
        _isAddDeviceError = true;
        _message = 'Thêm thiết bị thất bại !';
      });
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
