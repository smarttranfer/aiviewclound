import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_alert_widget.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationCode extends StatefulWidget {
  @override
  _ConfirmationCodeState createState() => _ConfirmationCodeState();
}

class _ConfirmationCodeState extends State<ConfirmationCode> {
  FocusNode currentFocusNode = FocusNode();
  TextEditingController _codeController1 = TextEditingController();
  TextEditingController _codeController2 = TextEditingController();
  TextEditingController _codeController3 = TextEditingController();
  TextEditingController _codeController4 = TextEditingController();
  TextEditingController _codeController5 = TextEditingController();
  TextEditingController _codeController6 = TextEditingController();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  String code = "";
  bool isLastDigit = false;
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  late UserStore _store;
  String objectGuid = "";
  String OTPGuid = "";
  String phone = "";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    setState(() {
      OTPGuid = arguments["OTPGuid"] ?? "";
      objectGuid = arguments["ObjectGuid"] ?? "";
      phone = arguments["Mobile"].toString();
    });

    _store = Provider.of<UserStore>(context);
  }

  @override
  void dispose() {
    _timer.cancel();
    // Clean up the controller when the Widget is removed from the Widget tree
    currentFocusNode.dispose();
    _codeController1.dispose();
    _codeController2.dispose();
    _codeController3.dispose();
    _codeController4.dispose();
    _codeController5.dispose();
    _codeController6.dispose();
    super.dispose();
  }

  onNextFocus(text, node) {
    if (text.length > 0) {
      node.nextFocus();
    } else {
      node.previousFocus();
    }
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

  void reSendConfirmCode() {
    _store.resendOTPRecoverPassword({"objectGuid": objectGuid.toString()}).then(
        (value) => {
              if (value["isOk"])
                {
                  _showErrorMessage(
                      "Mã OTP đã được gửi lại. Vui lòng kiểm tra tin nhắn điện thoại")
                }
              else
                {_showErrorMessage(value["Object"])}
            });
  }

  void onConfirmCode() {
    String code = _codeController1.text +
        _codeController2.text +
        _codeController3.text +
        _codeController4.text +
        _codeController5.text +
        _codeController6.text;
    if (code.length > 0) {
      if (objectGuid.isNotEmpty) {
        _store.confirmOTPRecoverPassword({
          "ObjectGuid": objectGuid.toString(),
          "OTPCode": code,
        }).then((value) => {
              print(value),
              if (value["isOk"])
                {
                  if (value["Object"]['OTPGuid'] != null)
                    {
                      _timer.cancel(),
                      Navigator.of(context).pushNamed(Routes.newPassword,
                          arguments: {'OTPGuid': value["Object"]['OTPGuid']})
                    }
                }
              else
                {_showErrorMessage(value["Object"])}
            });
        return;
      }
      _store.confirmCode({
        "Mobile": phone,
        "OTPCode": code,
        "OTPGuid": OTPGuid.toString(),
      });
    } else {
      _showErrorMessage("Mã OTP không để trống");
    }
  }

  Widget navigate(BuildContext context) {
    _store.reset();
    Future.delayed(Duration(milliseconds: 0), () {
      if (objectGuid.isEmpty) {
        _timer.cancel();
        showSuccessAlert();
      }
    });

    return Container();
  }

  showSuccessAlert() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: 410,
              child: BottomSheetAlertWidget(
                  message: AppLocalizations.of(context)
                      .translate('register_message'),
                  type: AlertType.success,
                  title: AppLocalizations.of(context)
                      .translate('register_success'),
                  onPress: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, (Route<dynamic> route) => false);
                  }));
        });
  }

  Widget buildInputField() {
    final node = FocusScope.of(context);
    // node.focusedChild
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        width: 38.h,
        height: 38.h,
        child:
            // Adobe XD layer: 'Rectangle 1829' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff2b2f33),
              border: Border.all(
                  color: const Color(0xfffd7b38), // set border color
                  width: 1.0)),
          child: Align(
              alignment: Alignment.center,
              child: TextField(
                maxLength: 1,
                autofocus: true,
                textAlign: TextAlign.center,
                controller: _codeController1,
                style: TextStyle(color: Colors.white),
                onChanged: (text) {
                  if (text.isEmpty) {
                    return;
                  }
                  onNextFocus(text, node);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
              )),
        ),
      ),
      Container(
        width: 38.h,
        height: 38.h,
        child:
            // Adobe XD layer: 'Rectangle 1824' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff2b2f33),
              border: Border.all(
                  color: const Color(0xfffd7b38), // set border color
                  width: 1.0)),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            controller: _codeController2,
            onChanged: (text) {
              if (_codeController1.text.isEmpty) {
                _codeController2.text = "";
                return;
              }
              onNextFocus(text, node);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ),
      Container(
        width: 38.h,
        height: 38.h,
        child:
            // Adobe XD layer: 'Rectangle 1825' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff2b2f33),
              border: Border.all(
                  color: const Color(0xfffd7b38), // set border color
                  width: 1.0)),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (text) {
              if (_codeController2.text.isEmpty) {
                _codeController3.text = "";
                return;
              }
              onNextFocus(text, node);
            },
            keyboardType: TextInputType.number,
            controller: _codeController3,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ),
      Container(
        width: 38.h,
        height: 38.h,
        child:
            // Adobe XD layer: 'Rectangle 1826' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff2b2f33),
              border: Border.all(
                  color: const Color(0xfffd7b38), // set border color
                  width: 1.0)),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (text) {
              if (_codeController3.text.isEmpty) {
                _codeController4.text = "";
                return;
              }
              onNextFocus(text, node);
            },
            keyboardType: TextInputType.number,
            controller: _codeController4,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ),
      Container(
        width: 38.h,
        height: 38.h,
        child:

            // Adobe XD layer: 'Rectangle 1827' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff2b2f33),
              border: Border.all(
                  color: const Color(0xfffd7b38), // set border color
                  width: 1.0)),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (text) {
              if (_codeController4.text.isEmpty) {
                _codeController5.text = "";
                return;
              }
              onNextFocus(text, node);
            },
            keyboardType: TextInputType.number,
            controller: _codeController5,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ),
      Container(
        width: 38.h,
        height: 38.h,
        child:
            // Adobe XD layer: 'Rectangle 1828' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff2b2f33),
              border: Border.all(
                  color: const Color(0xfffd7b38), // set border color
                  width: 1.0)),
          child: TextField(
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            controller: _codeController6,
            onChanged: (text) {
              if (_codeController5.text.isEmpty) {
                _codeController6.text = "";
                return;
              }
              if (text.length == 0) {
                node.previousFocus();
              } else {
                setState(() {
                  isLastDigit = true;
                });
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: <Widget>[
            Observer(
              builder: (context) {
                return _store.success
                    ? navigate(context)
                    : _showErrorMessage(_store.errorStore.errorMessage);
              },
            ),
            HeaderWidget(headerText: 'Nhập mã xác thực'),

            // Adobe XD layer: 'Group 6388' (group)

            Container(
                margin: EdgeInsets.only(left: 36.w, right: 36.w, top: 81.h),
                child: buildInputField()),

            Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                child:
                    // Adobe XD layer: '4 phút 59 giây' (text)
                    Text(
                  (_start / 60).floor().toString() +
                      ' phút ' +
                      (_start % 60).toString() +
                      ' giây',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay-Regular',
                    fontSize: 14,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.left,
                )),
            GestureDetector(
              onTap: _start > 0
                  ? null
                  : () {
                      if (_start == 0) {
                        setState(() {
                          _start = 60;
                        });
                        startTimer();
                        reSendConfirmCode();
                        _codeController1.text = "";
                        _codeController2.text = "";
                        _codeController3.text = "";
                        _codeController4.text = "";
                        _codeController5.text = "";
                        _codeController6.text = "";
                      }
                    },
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                child:
                    // Adobe XD layer: 'Gửi lại mã' (text)
                    Text(
                  'Gửi lại mã',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay-Regular',
                    fontSize: 17,
                    color: _start > 0
                        ? const Color(0xff818181)
                        : const Color(0xff4aa541),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              child:
                  // Adobe XD layer: 'Mã sác thực được gử…' (text)
                  Container(
                      child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'SFProDisplay-Regular',
                    fontSize: 14,
                    color: const Color(0xffffffff),
                  ),
                  children: [
                    TextSpan(
                      text: 'Mã sác thực được gửi đến số điện thoại',
                    ),
                    TextSpan(
                      text: '\n',
                    ),
                    TextSpan(
                      text: phone.substring(0, phone.length - 3) + '***',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay-Bold',
                        color: const Color(0xfffd7b38),
                      ),
                    ),
                    TextSpan(
                      text: ' của bạn. Vui lòng kiểm tra lại thông tin',
                    ),
                  ],
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              )),
            )
          ]),
          Container(
              margin: EdgeInsets.all(16.h),
              child: Observer(
                builder: (context) {
                  return SMEButton(
                    onPress: (isLastDigit && _start > 0) ? onConfirmCode : null,
                    title: AppLocalizations.of(context).translate("Tiếp tục"),
                    isLoading: _store.stringResponseloading,
                  );
                },
              )),
        ],
      ),
    );
  }
}

// const String _svg_41gr65 =
//     '<svg viewBox="0.0 0.0 22.0 11.3" ><path  d="M 19.33300018310547 0 C 20.80594444274902 0 22 1.194056630134583 22 2.66700005531311 L 22 8.666000366210938 C 22 10.13894367218018 20.80594444274902 11.33300018310547 19.33300018310547 11.33300018310547 L 2.66700005531311 11.33300018310547 C 1.194056630134583 11.33300018310547 0 10.13894367218018 0 8.666000366210938 L 0 2.66700005531311 C 0 1.194056630134583 1.194056630134583 0 2.66700005531311 0 L 19.33300018310547 0 Z" fill="#ffffff" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_mu6eai =
//     '<svg viewBox="23.0 3.7 1.3 4.0" ><path transform="translate(23.0, 3.67)" d="M 0 2.220446049250313e-16 L 0 4 C 0.3935926258563995 3.834296226501465 0.7295427322387695 3.55614161491394 0.9657710194587708 3.200376033782959 C 1.201999306678772 2.844610452651978 1.32800304889679 2.427051544189453 1.327999949455261 2 C 1.32800304889679 1.572948575019836 1.201999306678772 1.155389547348022 0.9657710194587708 0.7996240258216858 C 0.7295427322387695 0.4438585042953491 0.3935926258563995 0.1657038182020187 2.220446049250313e-16 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_n8yw48 =
//     '<svg viewBox="2.0 2.0 18.0 7.3" ><path transform="translate(2.0, 2.0)" d="M 16.66699981689453 0 C 17.40319442749023 0 18 0.5968043804168701 18 1.33299994468689 L 18 6 C 18 6.73619556427002 17.40319442749023 7.333000183105469 16.66699981689453 7.333000183105469 L 1.33299994468689 7.333000183105469 C 0.5968043804168701 7.333000183105469 0 6.73619556427002 0 6 L 0 1.33299994468689 C 0 0.5968043804168701 0.5968043804168701 0 1.33299994468689 0 L 16.66699981689453 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_lxntdx =
//     '<svg viewBox="22.0 0.0 15.3 13.0" ><path transform="translate(22.0, 0.0)" d="M 7.544700145721436 12.96990013122559 C 7.50600004196167 12.95100021362305 7.472700119018555 12.92310047149658 7.445700168609619 12.88980007171631 L 5.439599990844727 10.50030040740967 C 5.377500057220459 10.42290019989014 5.344200134277344 10.32660007476807 5.346000194549561 10.22760009765625 C 5.347800254821777 10.12860012054443 5.384700298309326 10.03320026397705 5.44950008392334 9.959400177001953 C 5.737500190734863 9.660600662231445 6.082200050354004 9.422100067138672 6.462900161743164 9.257400512695312 C 6.843600273132324 9.093600273132324 7.253100395202637 9.005400657653809 7.668000221252441 9 C 8.082900047302246 9.005400657653809 8.492400169372559 9.093600273132324 8.873100280761719 9.258299827575684 C 9.253800392150879 9.423000335693359 9.59850025177002 9.661499977111816 9.886500358581543 9.960300445556641 C 9.952199935913086 10.03499984741211 9.988200187683105 10.12950038909912 9.989999771118164 10.22850036621094 C 9.991800308227539 10.32750034332275 9.958499908447266 10.42380046844482 9.895500183105469 10.50120067596436 L 7.889400005340576 12.88980007171631 C 7.863300323486328 12.92310047149658 7.829100131988525 12.95100021362305 7.791300296783447 12.96990013122559 C 7.752600193023682 12.98880004882812 7.710299968719482 12.99870014190674 7.668000221252441 12.99960041046143 C 7.624800205230713 12.99870014190674 7.582499980926514 12.98880004882812 7.544700145721436 12.96990013122559 Z M 11.07270050048828 8.779500007629395 C 11.03579998016357 8.761500358581543 11.00250053405762 8.737199783325195 10.97550010681152 8.705699920654297 C 10.55790042877197 8.240400314331055 10.04850006103516 7.866000175476074 9.479700088500977 7.606800079345703 C 8.909999847412109 7.347599983215332 8.293499946594238 7.209000110626221 7.668000221252441 7.200000286102295 C 7.043400287628174 7.209000110626221 6.426900386810303 7.346700191497803 5.858099937438965 7.604100227355957 C 5.289299964904785 7.862400054931641 4.780800342559814 8.235899925231934 4.363200187683105 8.700300216674805 C 4.33620023727417 8.732700347900391 4.303800106048584 8.758800506591797 4.266000270843506 8.776800155639648 C 4.22819995880127 8.793900489807129 4.187700271606445 8.803800582885742 4.145400047302246 8.803800582885742 C 4.104000091552734 8.803800582885742 4.063499927520752 8.793900489807129 4.025700092315674 8.776800155639648 C 3.987900018692017 8.758800506591797 3.954600095748901 8.732700347900391 3.928500175476074 8.700300216674805 L 2.768399953842163 7.315200328826904 C 2.706300020217896 7.237800121307373 2.672100067138672 7.14240026473999 2.672100067138672 7.043400287628174 C 2.672100067138672 6.94350004196167 2.706300020217896 6.848100185394287 2.768399953842163 6.770699977874756 C 3.379500150680542 6.068700313568115 4.131900310516357 5.503499984741211 4.976099967956543 5.111999988555908 C 5.820300102233887 4.720499992370605 6.738300323486328 4.512599945068359 7.668900012969971 4.5 C 8.59950065612793 4.512599945068359 9.517499923706055 4.721400260925293 10.3617000579834 5.112900257110596 C 11.20590019226074 5.505300045013428 11.95830059051514 6.070500373840332 12.56850051879883 6.77340030670166 C 12.63150024414062 6.849900245666504 12.66569995880127 6.946200370788574 12.66569995880127 7.045200347900391 C 12.66569995880127 7.144200325012207 12.63150024414062 7.240499973297119 12.56850051879883 7.317000389099121 L 11.41020011901855 8.700300216674805 C 11.38320064544678 8.732700347900391 11.3499002456665 8.758800506591797 11.31210041046143 8.777700424194336 C 11.27430057525635 8.795700073242188 11.23290061950684 8.805600166320801 11.19060039520264 8.805600166320801 C 11.15010070800781 8.805600166320801 11.10960006713867 8.796600341796875 11.07270050048828 8.779500007629395 Z M 1.350900053977966 5.598900318145752 C 1.313099980354309 5.579999923706055 1.280700087547302 5.552999973297119 1.254600048065186 5.519700050354004 L 0.09450000524520874 4.131900310516357 C 0.0333000011742115 4.055399894714355 0 3.960000038146973 0 3.861900091171265 C 0 3.763800144195557 0.0333000011742115 3.668400049209595 0.09450000524520874 3.591900110244751 C 1.025099992752075 2.484899997711182 2.18340015411377 1.591199994087219 3.490200042724609 0.9720000028610229 C 4.796999931335449 0.3519000113010406 6.221700191497803 0.02070000022649765 7.668000221252441 0 C 9.113400459289551 0.02070000022649765 10.53719997406006 0.3519000113010406 11.8439998626709 0.9720000028610229 C 13.14990043640137 1.592100024223328 14.30730056762695 2.484899997711182 15.23790073394775 3.591900110244751 C 15.29909992218018 3.668400049209595 15.33240032196045 3.763800144195557 15.33240032196045 3.861900091171265 C 15.33240032196045 3.960000038146973 15.29909992218018 4.055399894714355 15.23790073394775 4.131900310516357 L 14.07960033416748 5.515200138092041 C 14.05350017547607 5.548500061035156 14.02020072937012 5.575500011444092 13.98239994049072 5.593500137329102 C 13.94370079040527 5.612400054931641 13.90229988098145 5.622300148010254 13.86000061035156 5.623199939727783 L 13.86000061035156 5.624100208282471 C 13.81860065460205 5.624100208282471 13.77810001373291 5.615099906921387 13.74120044708252 5.598000049591064 C 13.70429992675781 5.579999923706055 13.67100048065186 5.554800033569336 13.64490032196045 5.524199962615967 C 12.90780067443848 4.653900146484375 11.99340057373047 3.951900005340576 10.96199989318848 3.465000152587891 C 9.931500434875488 2.977200031280518 8.808300018310547 2.717100143432617 7.668000221252441 2.700000047683716 C 6.527699947357178 2.716200113296509 5.404500007629395 2.976300001144409 4.373100280761719 3.462300062179565 C 3.342600107192993 3.94920015335083 2.427299976348877 4.650300025939941 1.690200090408325 5.519700050354004 C 1.664100050926208 5.552999973297119 1.630800008773804 5.579999923706055 1.593000054359436 5.598900318145752 C 1.556100010871887 5.616899967193604 1.514700055122375 5.626800060272217 1.472400069236755 5.626800060272217 C 1.430100083351135 5.626800060272217 1.388700008392334 5.616899967193604 1.350900053977966 5.598900318145752 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_ymifyt =
//     '<svg viewBox="0.0 0.3 17.0 12.7" ><path transform="translate(0.0, 0.34)" d="M 15.00300025939941 12.66660022735596 C 14.7140998840332 12.63960075378418 14.44770050048828 12.50010013580322 14.26049995422363 12.27780055999756 C 14.0733003616333 12.05640029907227 13.98060035705566 11.76930046081543 14.00310039520264 11.48040008544922 L 14.00310039520264 1.187100052833557 C 13.98060035705566 0.8973000049591064 14.0733003616333 0.6111000180244446 14.26049995422363 0.3887999951839447 C 14.44770050048828 0.1665000021457672 14.7140998840332 0.02700000070035458 15.00300025939941 0 L 16.00290107727051 0 C 16.29269981384277 0.02700000070035458 16.55910110473633 0.1665000021457672 16.74629974365234 0.3887999951839447 C 16.93350028991699 0.6111000180244446 17.02530097961426 0.8973000049591064 17.00370025634766 1.187100052833557 L 17.00370025634766 11.47860050201416 C 17.02620124816895 11.76840019226074 16.93350028991699 12.05550003051758 16.74629974365234 12.27780055999756 C 16.55910110473633 12.50010013580322 16.29269981384277 12.63960075378418 16.00290107727051 12.66660022735596 L 15.00300025939941 12.66660022735596 Z M 11.33640003204346 12.66660022735596 L 10.33650016784668 12.66660022735596 C 10.04759979248047 12.63960075378418 9.780300140380859 12.50010013580322 9.593100547790527 12.27780055999756 C 9.405900001525879 12.05640029907227 9.31410026550293 11.76930046081543 9.336600303649902 11.48040008544922 L 9.336600303649902 3.959100008010864 C 9.31410026550293 3.669300079345703 9.405900001525879 3.383100032806396 9.593100547790527 3.160799980163574 C 9.780300140380859 2.938500165939331 10.04759979248047 2.799000024795532 10.33650016784668 2.772000074386597 L 11.33640003204346 2.772000074386597 C 11.62530040740967 2.799000024795532 11.89170074462891 2.938500165939331 12.07890033721924 3.160799980163574 C 12.26609992980957 3.383100032806396 12.35879993438721 3.669300079345703 12.33629989624023 3.959100008010864 L 12.33629989624023 11.48040008544922 C 12.35879993438721 11.76930046081543 12.26609992980957 12.05550003051758 12.07980060577393 12.27780055999756 C 11.89260005950928 12.50010013580322 11.62620067596436 12.63960075378418 11.33730030059814 12.66660022735596 Z M 5.669100284576416 12.66660022735596 C 5.380199909210205 12.63960075378418 5.113800048828125 12.50010013580322 4.926599979400635 12.27780055999756 C 4.739399909973145 12.05640029907227 4.646699905395508 11.76930046081543 4.66919994354248 11.48040008544922 L 4.66919994354248 6.729300022125244 C 4.646699905395508 6.439500331878662 4.739399909973145 6.153300285339355 4.926599979400635 5.931000232696533 C 5.113800048828125 5.708700180053711 5.380199909210205 5.569200038909912 5.669100284576416 5.542200088500977 L 6.669000148773193 5.542200088500977 C 6.957900047302246 5.569200038909912 7.225200176239014 5.708700180053711 7.412400245666504 5.931000232696533 C 7.599600315093994 6.153300285339355 7.691400051116943 6.439500331878662 7.668900012969971 6.729300022125244 L 7.668900012969971 11.48040008544922 C 7.691400051116943 11.76930046081543 7.599600315093994 12.05640029907227 7.412400245666504 12.27780055999756 C 7.225200176239014 12.50010013580322 6.957900047302246 12.63960075378418 6.669000148773193 12.66660022735596 L 5.669100284576416 12.66660022735596 Z M 1.003499984741211 12.66660022735596 C 0.7146000266075134 12.63960075378418 0.4473000168800354 12.50010013580322 0.2601000070571899 12.27780055999756 C 0.07290000468492508 12.05640029907227 -0.01889999955892563 11.76930046081543 0.003600000170990825 11.48040008544922 L 0.003600000170990825 9.099900245666504 C -0.01800000108778477 8.810999870300293 0.0747000053524971 8.525700569152832 0.261900007724762 8.304300308227539 C 0.4491000175476074 8.082900047302246 0.7146000266075134 7.943400382995605 1.003499984741211 7.916399955749512 L 2.003400087356567 7.916399955749512 C 2.291399955749512 7.943400382995605 2.557800054550171 8.082900047302246 2.745000123977661 8.304300308227539 C 2.931300163269043 8.525700569152832 3.02400016784668 8.810999870300293 3.003300189971924 9.099900245666504 L 3.003300189971924 11.47500038146973 C 3.026700019836426 11.765700340271 2.934900045394897 12.05280017852783 2.747699975967407 12.27600002288818 C 2.560500144958496 12.49919986724854 2.293200016021729 12.63960075378418 2.003400087356567 12.66660022735596 L 1.003499984741211 12.66660022735596 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_82ykdu =
//     '<svg viewBox="0.0 0.0 375.0 44.0" ><path  d="M 375 0 L 375 44 L 0 44 L 0 0 L 375 0 Z" fill="#212529" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_1xp9fi =
//     '<svg viewBox="-2875.0 -3447.0 10.0 20.0" ><path transform="translate(-2875.0, -3447.0)" d="M 10 0 L 0 10 L 10 20" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="bevel" /></svg>';
