import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_alert_widget.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isShowPassword = true;
  String error = "";
  int pwdLength = 0;
  int oldPwdLength = 0;
  String pwdErr = "";
  String cfPwdErr = "";
  String oldPwdErr = "";
  late UserStore _store;

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  bool allInputIsValid() {
    return oldPwdErr.isEmpty &&
        pwdErr.isEmpty &&
        cfPwdErr.isEmpty &&
        pwdLength > 0 &&
        oldPwdLength > 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<UserStore>(context);
  }

  void onCHangePassword() {
    try {
      _store.changePassword({
        "oldPassword": _oldPasswordController.text,
        "newPassword": _passwordController.text
      }).then((value) => {
            if (value["isOk"])
              {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Container(
                          height: 410,
                          child: BottomSheetAlertWidget(
                              message: '',
                              type: AlertType.success,
                              title: "Đổi mật khẩu thành công",
                              onPress: () {
                                Navigator.pop(context);
                              }));
                    })
              }
            else
              {showModalErr(value["Object"])}
          });
    } catch (error) {
      print(error);
    }
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

  Widget buildBody() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
        Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFieldWidget(
          hint: AppLocalizations.of(context).translate('re_enter_old_password'),
          textController: _oldPasswordController,
          inputAction: TextInputAction.next,
          isObscure: true,
          errorText: oldPwdErr,
          headerText: Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                color: const Color(0xffffffff),
              ),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)
                      .translate('enter_old_password'),
                ),
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: const Color(0xfffd413c),
                  ),
                ),
              ],
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
          onChanged: (text) {
            setState(() {
              oldPwdLength = _oldPasswordController.text.length;
              oldPwdErr = "";
            });
          },
          autoFocus: false,
        ),
        TextFieldWidget(
          hint: AppLocalizations.of(context).translate('enter_new_password'),
          inputType: TextInputType.emailAddress,
          textController: _passwordController,
          inputAction: TextInputAction.next,
          headerText: Text.rich(TextSpan(
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              color: const Color(0xffffffff),
            ),
            children: [
              TextSpan(
                text: AppLocalizations.of(context)
                    .translate('enter_new_password'),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: const Color(0xfffd413c),
                ),
              ),
            ],
          )),
          isObscure: true,
          onChanged: (text) {
            setState(() {
              pwdLength = _passwordController.text.length;
              pwdErr = "";
            });
          },
          errorText: pwdErr,
        ),
        TextFieldWidget(
          hint: AppLocalizations.of(context).translate('re_enter_new_password'),
          textController: _confirmPasswordController,
          inputAction: TextInputAction.next,
          isObscure: true,
          headerText: Text.rich(TextSpan(
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              color: const Color(0xffffffff),
            ),
            children: [
              TextSpan(
                text: AppLocalizations.of(context)
                    .translate('re_enter_new_password'),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: const Color(0xfffd413c),
                ),
              ),
            ],
          )),
          errorText: cfPwdErr,
          onChanged: (text) {
            if (cfPwdErr.length > 0) {
              setState(() {
                pwdErr = "";
              });
            }
          },
          autoFocus: false,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).translate('require_pwd_desc'),
                style: TextStyle(
                  fontFamily: 'SFProDisplay-Regular',
                  fontSize: 14,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              )),
        ),
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: pwdLength < 8
                      ? const Color(0xfffd7b38)
                      : const Color(0xff2b2f33),
                ),
                child:
                    // Adobe XD layer: 'Rectangle 1830' (shape)
                    Text(
                  AppLocalizations.of(context).translate('weak'),
                  style: TextStyle(
                    fontFamily: 'SFProDisplay-Regular',
                    fontSize: 14,
                    color: pwdLength < 8
                        ? const Color(0xffffffff)
                        : const Color(0xff818181),
                  ),
                  textAlign: TextAlign.center,
                )),
            Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: pwdLength >= 8 && pwdLength < 15
                      ? const Color(0xfffd7b38)
                      : const Color(0xff2b2f33),
                ),
                child:
                    // Adobe XD layer: 'Rectangle 1830' (shape)
                    Text(
                  AppLocalizations.of(context).translate('medium'),
                  style: TextStyle(
                    fontFamily: 'SFProDisplay-Regular',
                    fontSize: 14,
                    color: pwdLength >= 8 && pwdLength < 15
                        ? const Color(0xffffffff)
                        : const Color(0xff818181),
                  ),
                  textAlign: TextAlign.center,
                )),
            Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: pwdLength >= 15
                      ? const Color(0xfffd7b38)
                      : const Color(0xff2b2f33),
                ),
                child:
                    // Adobe XD layer: 'Rectangle 1830' (shape)
                    Text(
                  AppLocalizations.of(context).translate('strong'),
                  style: TextStyle(
                    fontFamily: 'SFProDisplay-Regular',
                    fontSize: 14,
                    color: pwdLength >= 15
                        ? const Color(0xffffffff)
                        : const Color(0xff818181),
                  ),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ]),
      SMEButton(
          onPress: allInputIsValid() ? onCHangePassword : null,
          title: AppLocalizations.of(context).translate('done'))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        body: ScreenWidget(
          widget: buildBody(),
          headerText: AppLocalizations.of(context).translate('change_pwd'),
        ));
  }
}
