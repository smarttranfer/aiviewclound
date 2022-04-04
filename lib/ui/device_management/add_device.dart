import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/utils/device/Validator.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDeviceScreen> {
  TextEditingController _serialController = TextEditingController();
  late CameraP2PStore _cameraP2PStore;

  @override
  void initState() {
    super.initState();
    _serialController.text = "";
  }

  String isCorrectSerial = '';
  bool isValidSerial = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map;
      setState(() {
        _serialController.text = arguments["serial"].toString();
      });
    }
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
  }

  onSubmit() async {
    if (Validator.isValidSerialNumber(_serialController.text)) {
      final resp = await _cameraP2PStore
          .checkDeviceStatus({"serial": _serialController.text.trim()});
      Navigator.pushNamed(
        context,
        Routes.deviceInfoChecking,
        arguments: {
          'serial': _serialController.text,
          'isError': resp["isError"],
          'message': resp["isError"] ? resp["Object"] : ''
        },
      );
      return;
    }
    setState(() {
      setState(() {
        isValidSerial = false;
      });
    });
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'Trên mỗi thiết bị của bạn sẽ có Mã seri, hãy nhập đầy đủ vào ô dưới đây để thực hiện thêm thiết bị của bạn !',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            TextFieldWidget(
              hint: "Nhập số seri thiết bị",
              inputType: TextInputType.text,
              textController: _serialController,
              inputAction: TextInputAction.next,
              onChanged: (text) {
                if (!Validator.isValidSerialNumber(_serialController.text)) {
                  setState(() {
                    isCorrectSerial = 'Mã Seri không hợp lệ!';
                  });
                } else {
                  setState(() {
                    isCorrectSerial = '';
                  });
                }

                return;
              },
              errorText: isCorrectSerial,
              headerText: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  "Số seri",
                  style: const TextStyle(
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProDisplay",
                    fontStyle: FontStyle.normal,
                    fontSize: 17.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              autoFocus: false,
            ),
            // Visibility(
            //   visible: !isValidSerial,
            //   child: Center(
            //     child: Text(
            //       'Mã Seri không hợp lệ!',
            //       style: TextStyle(
            //         color: AppColors.mRedColor,
            //         fontWeight: FontWeight.w400,
            //         fontFamily: "SFProDisplay",
            //         fontStyle: FontStyle.normal,
            //         fontSize: 14.0,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
        Observer(builder: (context) {
          return SMEButton(
            onPress:
                (isCorrectSerial.isEmpty && _serialController.text.length > 0)
                    ? onSubmit
                    : null,
            title: AppLocalizations.of(context).translate('Tiếp tục'),
            isLoading: _cameraP2PStore.loading,
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mGreyColor3,
      body: Column(
        children: [
          HeaderWidget(
            headerText: 'Thêm thiết bị',
            onBackPress: () {
              Navigator.of(context)
                  .pop(ModalRoute.withName(Routes.deviceManagement));
            },
            actionWidget: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.addDeviceByQRCodeScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(
                    Assets.icQRCode,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildBody(),
                ),
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
          ),
          SizedBox(height: 32)
        ],
      ),
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
