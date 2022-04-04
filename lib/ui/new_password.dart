import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_alert_widget.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isShowPassword = true;
  String error = "";
  int pwdLength = 0;
  String pwdErr = "";
  String cfPwdErr = "";
  String objectGuid = "";
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    setState(() {
      objectGuid = arguments["OTPGuid"].toString();
    });
    _store = Provider.of<UserStore>(context);
  }

  void onCHangePassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        cfPwdErr = "Mật khẩu xác nhận không khớp";
      });
      return;
    }
    if (!validatePassword(_passwordController.text)) {
      print(
          "Mật khẩu phải có Chữ, số , chữ hoa , chữ thường , ký tự đặc biệt và ít nhất 8 kí tự");
      setState(() {
        pwdErr =
            "Mật khẩu phải có Chữ, số , chữ hoa , chữ thường , ký tự đặc biệt và ít nhất 8 kí tự";
      });

      return;
    }
    try {
      _store.recoverChangePass({
        "OTPGuid": objectGuid,
        "Password": _passwordController.text,
        "ConfirmPassword": _confirmPasswordController.text
      }).then((value) => {
            if (value["isOk"])
              {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.login, (Route<dynamic> route) => false)
              }
            else
              {(value["Object"])}
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
                  title: AppLocalizations.of(context).translate("Thao tác không thành công"),
                ));
          });
    }

    return SizedBox.shrink();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Column(
                children: [
                  HeaderWidget(headerText: 'Nhập mật khẩu mới'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child:
                            // Adobe XD layer: 'Mật khẩu *' (text)
                            Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'SFProDisplay-Regular',
                              fontSize: 17,
                              color: const Color(0xffffffff),
                            ),
                            children: [
                              TextSpan(
                                text: 'Mật khẩu',
                              ),
                              TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: const Color(0xfffd413c),
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: TextFieldWidget(
                          hint: AppLocalizations.of(context)
                              .translate('enter_password'),
                          inputType: TextInputType.emailAddress,
                          textController: _passwordController,
                          inputAction: TextInputAction.next,
                          autoFocus: true,
                          isObscure: true,
                          onChanged: (text) {
                            setState(() {
                              pwdLength = _passwordController.text.length;
                              pwdErr = "";
                            });
                          },
                          errorText: pwdErr,
                          textStyle: TextStyle(
                            fontFamily: 'SFProDisplay-Regular',
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                  // Adobe XD layer: 'Group 6388' (group)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child:
                              // Adobe XD layer: 'Xác nhận mật khẩu *' (text)
                              Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'SFProDisplay-Regular',
                                fontSize: 17,
                                color: const Color(0xffffffff),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Xác nhận mật khẩu',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: const Color(0xfffd413c),
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child:
                              // Adobe XD layer: 'Nhập lại mật khẩu' (text)
                              TextFieldWidget(
                            hint: AppLocalizations.of(context)
                                .translate('re_enter_password'),
                            inputType: TextInputType.emailAddress,
                            textController: _confirmPasswordController,
                            inputAction: TextInputAction.next,
                            autoFocus: true,
                            isObscure: true,
                            errorText: cfPwdErr,
                            onChanged: (text) {
                              if (cfPwdErr.length > 0) {
                                setState(() {
                                  pwdErr = "";
                                });
                              }
                            },
                            textStyle: TextStyle(
                              fontFamily: 'SFProDisplay-Regular',
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            // onFieldSubmitted: (value) {
                            //   FocusScope.of(context).requestFocus(
                            //       _passwordFocusNode);
                            // },
                            // errorText:
                            //     _store.formErrorStore.userAccount,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child:
                              // Adobe XD layer: 'Mật khẩu từ 8 ~ 30 …' (text)
                              SingleChildScrollView(
                                  child: Text(
                            'Mật khẩu từ 8 ~ 30 ký tự gồm cả chữ số',
                            style: TextStyle(
                              fontFamily: 'SFProDisplay-Regular',
                              fontSize: 14,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          )),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 8.h),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
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
                                      'Yếu',
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: pwdLength >= 8 && pwdLength < 15
                                          ? const Color(0xfffd7b38)
                                          : const Color(0xff2b2f33),
                                    ),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1830' (shape)
                                        Text(
                                      'Trung bình',
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
                                      'Mạnh',
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
                            )),
                      ]),
                ],
              ),

              // Adobe XD layer: 'Group 6389' (group)
              Container(
                  margin: EdgeInsets.all(8.w),
                  child: Observer(builder: (context) {
                    return SMEButton(
                        onPress: _passwordController.text.length > 0
                            ? onCHangePassword
                            : null,
                        title:
                            AppLocalizations.of(context).translate('Tiếp tục'),
                        isLoading: _store.stringResponseloading);
                  }))
            ])),
      ),
    );
  }
}

const String _svg_a34mty =
    '<svg viewBox="311.0 42.0 17.1 12.0" ><path transform="translate(311.0, 42.0)" d="M 8.56980037689209 11.99880027770996 C 7.164900302886963 12.01679992675781 5.773499965667725 11.71260070800781 4.502700328826904 11.11229991912842 C 3.518100023269653 10.63170051574707 2.633399963378906 9.967500686645508 1.896300077438354 9.156599998474121 C 1.116000056266785 8.316900253295898 0.5022000074386597 7.338600158691406 0.08550000190734863 6.270300388336182 L 0 5.99940013885498 L 0.09000000357627869 5.729400157928467 C 0.5067000389099121 4.662000179290771 1.119600057601929 3.683700084686279 1.897199988365173 2.843100070953369 C 2.634299993515015 2.03220009803772 3.518100023269653 1.368000030517578 4.502700328826904 0.8874000310897827 C 5.773499965667725 0.2862000167369843 7.164900302886963 -0.01710000075399876 8.56980037689209 0.0009000000427477062 C 9.975600242614746 -0.01710000075399876 11.36700057983398 0.2862000167369843 12.6378002166748 0.8874000310897827 C 13.62240028381348 1.368000030517578 14.50710010528564 2.03220009803772 15.24330043792725 2.843100070953369 C 16.02540016174316 3.680999994277954 16.64010047912598 4.660200119018555 17.05410003662109 5.729400157928467 L 17.14050102233887 5.99940013885498 L 17.05050086975098 6.270300388336182 C 15.72297096252441 9.72596549987793 12.40483093261719 11.99991512298584 8.712390899658203 11.99992847442627 C 8.664911270141602 11.99992942810059 8.617400169372559 11.99955463409424 8.56980037689209 11.99880027770996 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
