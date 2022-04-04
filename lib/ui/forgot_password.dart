import 'package:aiviewcloud/constants/strings.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/Validator.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_alert_widget.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/progress_indicator_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _userEmailOrPhoneController = TextEditingController();
  late UserStore _userStore;
  bool isEmpty = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
  }

  String phoneErr = "";
  bool isNotEmpty = false;

  void onCreateRecoverPassword() {
    if (!Validator.isValidPhoneNumber(_userEmailOrPhoneController.text)) {
      setState(() {
        phoneErr = AppLocalizations.of(context).translate('wrong_phone_format');
      });
      return;
    } else {
      setState(() {
        phoneErr = "";
      });
    }

    _userStore
        .createRecoverPassword({
          "Mobile": _userEmailOrPhoneController.text,
          "Email": "",
        })
        .then((value) => {
              print('response $value'),
              if (value["isOk"])
                {
                  Navigator.of(context)
                      .pushNamed(Routes.enterComfirmationCode, arguments: {
                    'ObjectGuid': value["Object"]["ObjectGuid"],
                    'Mobile': _userEmailOrPhoneController.text
                  }),
                }
              else
                {showModalErr(value["Object"])}
            })
        .catchError((onError) => {showModalErr(onError["Object"])});
  }

  showModalErr(String message) {
    if (message.isNotEmpty) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
                height: 410,
                child: BottomSheetAlertWidget(
                  message: message,
                  title: AppLocalizations.of(context)
                      .translate('action_not_success'),
                ));
          });
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              HeaderWidget(
                  headerText:
                      AppLocalizations.of(context).translate('forgot_pwd')),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              Container(
                                margin: EdgeInsets.only(top: 16.h),
                                child:
                                    // Adobe XD layer: 'Đặt đúng thông tin …' (text)
                                    Text(
                                  AppLocalizations.of(context)
                                      .translate('reset_pwd_desc'),
                                  style: TextStyle(
                                    fontFamily: 'SFProDisplay-Regular',
                                    fontSize: 12,
                                    color: const Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 16.h),
                                  child:
                                      // Adobe XD layer: 'Email hoặc số điện …' (text)
                                      TextFieldWidget(
                                    hint: AppLocalizations.of(context)
                                        .translate('email_or_phone'),
                                    inputType: TextInputType.phone,
                                    textController: _userEmailOrPhoneController,
                                    inputAction: TextInputAction.next,
                                    autoFocus: true,
                                    errorText: phoneErr,
                                    onChanged: (text) {
                                      if (text.length == 0) {
                                        setState(() {
                                          isNotEmpty = false;
                                        });
                                        return;
                                      }
                                      if (text.length > 0 && !isNotEmpty) {
                                        setState(() {
                                          isNotEmpty = true;
                                        });
                                      }
                                    },
                                    // onFieldSubmitted: (value) {
                                    //   FocusScope.of(context).requestFocus(
                                    //       _passwordFocusNode);
                                    // },
                                    // errorText:
                                    //     _store.formErrorStore.userAccount,
                                  ))
                            ]),
                            Observer(builder: (context) {
                              return SMEButton(
                                  onPress: isNotEmpty
                                      ? onCreateRecoverPassword
                                      : null,
                                  title: AppLocalizations.of(context)
                                      .translate('Tiếp tục'),
                                  isLoading: _userStore.stringResponseloading);
                            })
                          ])))
            ]))));
  }
}
