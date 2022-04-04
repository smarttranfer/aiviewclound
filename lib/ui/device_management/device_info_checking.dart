import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'internet_connection.dart';

class DeviceInfoChecking extends StatefulWidget {
  @override
  _DeviceInfoCheckingState createState() => _DeviceInfoCheckingState();
}

class _DeviceInfoCheckingState extends State<DeviceInfoChecking> {
  @override
  void initState() {
    super.initState();
  }

  String _message = "";
  String _serial = "";
  bool _isError = false;
  bool _isCheck = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if (arguments != null)
      setState(() {
        _serial = arguments["serial"].toString();
        _isError = arguments["isError"];
        _message = arguments["message"].toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: ScreenWidget(
        widget: _buildBody(),
        headerText: 'Kiểm tra thông tin',
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
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
                Text(
                  _message,
                  style: TextStyle(
                    fontFamily: FontFamily.sfProDisplay,
                    fontSize: 14,
                    color:
                        _isError ? AppColors.mRedColor : AppColors.mGreenColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Visibility(
                  visible: !_isError,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.mGreyColor2,
                    ),
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 28.h, bottom: 16.h),
                    padding: EdgeInsets.only(top: 32.h, bottom: 186.h),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/icons/ic_socket.svg'),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          child: Text(
                            'Tích bên dưới để chắc rằng thiết bị của bạn đã cắm nguồn!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontFamily.sfProDisplay,
                              fontSize: 14,
                              color: AppColors.mWhiteColor,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isCheck = !_isCheck;
                                });
                              },
                              child: SvgPicture.asset(
                                _isCheck ? Assets.checked : Assets.unchecked,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context).translate('turn_on'),
                              style: TextStyle(
                                fontFamily: FontFamily.roboto,
                                fontSize: 14,
                                color: _isCheck
                                    ? AppColors.mOrangeColor
                                    : AppColors.mGreyColor1,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SMEButton(
          onPress: () {
            if (!_isError && _isCheck) {
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
                    Routes.addDeviceProgressing,
                    arguments: {
                      'serial': _serial,
                    },
                  );
                }
              });
            }
          },
          title: AppLocalizations.of(context).translate('Tiếp tục'),
          primaryColor: !_isError && _isCheck ? null : AppColors.mGreyColor1,
        ),
      ],
    );
  }
}
