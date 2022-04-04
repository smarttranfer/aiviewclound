import 'dart:io';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/stores/form/form_store.dart';
import 'package:aiviewcloud/stores/language/language_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/device_utils.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/app_logo.widget.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_alert_widget.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'device_management/device_management.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userAccountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  // late ThemeStore _themeStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = FormStore();
  late UserStore _userStore;
  bool isEmpty = true;
  late LanguageStore _languageStore;
  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    setInitPhone();
  }

  setInitPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString(Preferences.username);
    if (phone != null) {
      _userAccountController.text = phone;
    }
    _passwordController.text = '123456@A';
    _userAccountController.text = 'bkav-cuongndc';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);
  }

  toForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.forgotPassword);
  }

  onCheckBox() {
    _store.setShowpassword(!_store.isShowPassword);
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
                      .translate("login_not_success"),
                ));
          });
    }
    return SizedBox.shrink();
  }

  onLogin() async {
    DeviceUtils.hideKeyboard(context);
    if (_userAccountController.text.isEmpty) {
      showModalErr("phone_not_empty");
      return;
    }
    if (_passwordController.text.isEmpty) {
      showModalErr("pwd_not_empty");
      return;
    }
    String identifier = "";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString(Preferences.fcmToken);
    _userStore.login({
      "UserName": _userAccountController.text,
      "Password": _passwordController.text,
      "DeviceID": identifier,
      "ClientID": Endpoints.getClientId,
      "FirebaseID": fcmToken,
      "OS": Platform.isIOS ? 1 : 2
    }).catchError((onError) => {showModalErr(onError["Object"])});
  }

  Widget _buildAccountField() {
    return Container(
      child:
          // Adobe XD layer: 'Group 6392' (group)
          Observer(
        builder: (context) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_user_account'),
            inputType: TextInputType.emailAddress,
            textController: _userAccountController,
            inputAction: TextInputAction.next,
            iconWidget: Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child:
                    // Adobe XD layer: 'coolicon' (shape)
                    SvgPicture.string(
                  _svg_5h7tdp,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                )),
            autoFocus: false,
            onChanged: (value) {
              checkEmpty();
              _store.setUserId(_userAccountController.text);
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: _store.formErrorStore.userAccount,
          );
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      child: Observer(
        builder: (context) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_user_password'),
            textController: _passwordController,
            inputAction: TextInputAction.next,
            autoFocus: false,
            isObscure: _store.isShowPassword,
            onChanged: (value) {
              checkEmpty();
              _store.setPassword(_passwordController.text);
            },
            iconWidget: Container(
              width: 16,
              height: 16,
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: SvgPicture.string(
                password,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.contain,
              ),
            ),
            suffixIcon: _store.password.isNotEmpty
                ? GestureDetector(
                    onTap: onCheckBox,
                    child: Container(
                      width: 39,
                      height: 39,
                      color: Colors.transparent,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: SvgPicture.string(
                        _svg_9k1pq1,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : null,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: _store.formErrorStore.password,
          );
        },
      ),
    );
  }

  Widget buildIcon() {
    return Stack(children: []);
  }

  void switchMode() async {
    Endpoints.mode =
        Endpoints.mode == EnvMode.qa ? EnvMode.production : EnvMode.qa;
    _userStore.setEnvMode();
  }

  Widget buildBottom() {
    return Column(children: [
      // Observer(builder: (context) {
      //   return Container(
      //       width: 130.w,
      //       margin: EdgeInsets.only(bottom: 32.h),
      //       child: SMEButton(
      //         onPress: switchMode,
      //         title:
      //             _userStore.mode == EnvMode.qa ? "QA Mode" : "Production Mode",
      //       ));
      // }),
      // GestureDetector(
      //     onTap: () {
      //       Navigator.of(context).pushNamed(Routes.addUrl);
      //     },
      //     child: Container(
      //       margin: EdgeInsets.only(bottom: 32.h),
      //       child:
      //           // Adobe XD layer: 'Xem trực tiếp qua L…' (text)
      //           Text(
      //         'Cài đặt url api',
      //         style: TextStyle(
      //           fontFamily: 'SFProDisplay-Regular',
      //           fontSize: 14,
      //           color: const Color(0xfffd7b38),
      //           decoration: TextDecoration.underline,
      //         ),
      //         textAlign: TextAlign.left,
      //       ),
      //     )),
      GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.viewLan);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 32.h),
            child:
                // Adobe XD layer: 'Xem trực tiếp qua L…' (text)
                Text(
              AppLocalizations.of(context).translate("view_by_lan"),
              style: TextStyle(
                fontFamily: 'SFProDisplay-Regular',
                fontSize: 14,
                color: const Color(0xfffd7b38),
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          )),
      GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.findCountry);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child:
                // Adobe XD layer: 'Bạn chưa có tài kho…' (text)
                Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'SFProDisplay-Bold',
                  fontSize: 14,
                  color: const Color(0xff818181),
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)
                        .translate('dont_have_account'),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: const Color(0xff4aa541),
                    ),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context).translate('register'),
                    style: TextStyle(
                      color: const Color(0xff4aa541),
                    ),
                  ),
                ],
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ))
    ]);
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.deviceManagement, (Route<dynamic> route) => false);
    });

    return Container();
  }

  checkEmpty() {
    if (_userAccountController.text.length == 0 ||
        _passwordController.text.length == 0) {
      setState(() {
        isEmpty = true;
      });
      return;
    }
    setState(() {
      isEmpty = false;
    });
  }

  onShowLanguageDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 173.w,
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.mGreyColor2,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _languageStore.supportedLanguages
                          .map(
                            (object) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _languageStore.changeLanguage(object.locale!);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Row(children: [
                                    Image.asset(
                                      object.language == 'vi'
                                          ? Assets.vietnamese
                                          : Assets.english,
                                      fit: BoxFit.contain,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate(object.language!),
                                        style: textStyle,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ]),
                                )),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ));
        });
  }

  Widget _buildBody() {
    return SafeArea(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(children: [
                        Observer(
                          builder: (context) {
                            return _userStore.success
                                ? navigate(context)
                                : Container();
                          },
                        ),
                        Observer(builder: (context) {
                          return Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                                onTap: () {
                                  onShowLanguageDialog();
                                },
                                child: Container(
                                    height: 32.h,
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          _languageStore.locale == 'vi'
                                              ? Assets.vietnamese_circle
                                              : Assets.english_circle,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            _languageStore.locale.toUpperCase(),
                                            style: textStyle,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          Assets.down,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        color: const Color(0xff2b2f33)))),
                          );
                        }),
                        AppLogoWidget(),
                        _buildAccountField(),
                        _buildPasswordField(),
                        Observer(
                          builder: (context) {
                            return SMEButton(
                              onPress: isEmpty || _userStore.loginLoading
                                  ? null
                                  : onLogin,
                              title: AppLocalizations.of(context)
                                  .translate("login"),
                              isLoading: _userStore.loginLoading,
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 32.h),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'SFProDisplay-Regular',
                                fontSize: 12,
                                color: const Color(0xff818181),
                              ),
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)
                                      .translate("loginDesc"),
                                  style: TextStyle(
                                    fontFamily: 'SFProDisplay-Bold',
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            toForgotPassword(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 32.h),
                            child:
                                // Adobe XD layer: 'Quên mật khẩu?' (text)
                                SingleChildScrollView(
                                    child: Text(
                              AppLocalizations.of(context)
                                  .translate('forgotpwd'),
                              style: TextStyle(
                                fontFamily: 'SFProDisplay-Regular',
                                fontSize: 14,
                                color: const Color(0xfffd7b38),
                              ),
                              textAlign: TextAlign.left,
                            )),
                          ),
                        )
                      ]),
                      buildBottom(),
                    ]))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff212529),
        body: Observer(builder: (context) {
          return _buildBody();
        }));
  }
}

const String _svg_9k1pq1 =
    '<svg viewBox="315.0 226.0 17.1 12.0" ><path transform="translate(315.0, 226.0)" d="M 8.570110321044922 11.99886989593506 C 7.164505004882812 12.01637363433838 5.773427486419678 11.71300983428955 4.50273609161377 11.1118631362915 C 3.517767190933228 10.631272315979 2.633297681808472 9.967555999755859 1.896565437316895 9.156163215637207 C 1.116198182106018 8.317251205444336 0.5017520189285278 7.338150501251221 0.0857011079788208 6.270607471466064 L 0 5.999792098999023 L 0.08998615294694901 5.728976726531982 C 0.5063351392745972 4.662368297576904 1.119458436965942 3.68352198600769 1.897422432899475 2.843419790267944 C 2.633887529373169 2.03209924697876 3.518062591552734 1.368386507034302 4.50273609161377 0.8877207040786743 C 5.773437023162842 0.2866032123565674 7.164507865905762 -0.01675935089588165 8.570110321044922 0.0007142079994082451 C 9.975709915161133 -0.01672918722033501 11.366774559021 0.2866319119930267 12.63748455047607 0.8877207040786743 C 13.62247562408447 1.368276238441467 14.50695133209229 2.031996488571167 15.24365615844727 2.843419790267944 C 16.0255012512207 3.681195735931396 16.64013481140137 4.660595893859863 17.05451965332031 5.728976726531982 L 17.14022064208984 5.999792098999023 L 17.05023574829102 6.270607471466064 C 15.70576858520508 9.770459175109863 12.31884574890137 12.05830001831055 8.570110321044922 11.99886989593506 Z M 8.570110321044922 1.714736342430115 C 5.652733325958252 1.623318552970886 2.975044012069702 3.321713924407959 1.814292430877686 5.999792098999023 C 2.974854230880737 8.678031921386719 5.65266752243042 10.37650585174561 8.570110321044922 10.28484725952148 C 11.4874210357666 10.37602424621582 14.1649866104126 8.677707672119141 15.325927734375 5.999792098999023 C 14.16669654846191 3.320414781570435 11.48801422119141 1.621389746665955 8.570110321044922 1.714736342430115 Z M 8.570110321044922 8.570825576782227 C 7.333722114562988 8.579010009765625 6.264208316802979 7.711551666259766 6.017045021057129 6.500092506408691 C 5.769881725311279 5.288633346557617 6.414102077484131 4.071537017822266 7.55488109588623 3.594728946685791 C 8.695660591125488 3.117920875549316 10.01437568664551 3.514575242996216 10.70282077789307 4.541593074798584 C 11.39126682281494 5.568610668182373 11.25715923309326 6.93914270401001 10.38268852233887 7.813227653503418 C 9.903894424438477 8.297658920288086 9.251225471496582 8.570452690124512 8.570110321044922 8.570825576782227 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_5h7tdp =
    '<svg viewBox="43.0 160.0 16.0 16.0" ><path transform="translate(43.0, 160.0)" d="M 8.000049591064453 15.99996948242188 C 6.790500164031982 16.00336074829102 5.596234798431396 15.72969722747803 4.508862495422363 15.1999397277832 C 4.110902309417725 15.00637531280518 3.729607582092285 14.78027439117432 3.368866682052612 14.5239429473877 L 3.259267091751099 14.44394302368164 C 2.267126083374023 13.71163749694824 1.455973148345947 12.76173496246338 0.8880764245986938 11.66715335845947 C 0.3006675243377686 10.53425884246826 -0.003994156140834093 9.276088714599609 3.953818304580636e-05 7.999968528747559 C 3.953818304580636e-05 3.581707954406738 3.581788539886475 0 8.000049591064453 0 C 12.41831016540527 0 16.00005722045898 3.581707954406738 16.00005722045898 7.999968528747559 C 16.00404930114746 9.275478363037109 15.69967269897461 10.53305816650391 15.11282157897949 11.66555404663086 C 14.54571723937988 12.75949382781982 13.73569488525391 13.70908164978027 12.74483108520508 14.44154357910156 C 12.3710412979126 14.71514320373535 11.9743766784668 14.95603179931641 11.55923557281494 15.16154003143311 L 11.49523639678955 15.19354057312012 C 10.40717792510986 15.72610664367676 9.211451530456543 16.00197982788086 8.000049591064453 15.99996948242188 Z M 8.000049591064453 11.99993801116943 C 6.801235198974609 11.99760818481445 5.702187061309814 12.66717147827148 5.154459476470947 13.73354625701904 C 6.947568416595459 14.62169075012207 9.052529335021973 14.62169075012207 10.84563827514648 13.73354625701904 L 10.84563827514648 13.72954654693604 C 10.29723072052002 12.66433238983154 9.198139190673828 11.99628734588623 8.000049591064453 11.99993801116943 Z M 8.000049591064453 10.39995956420898 C 9.732933044433594 10.40222072601318 11.33076477050781 11.33604526519775 12.1832332611084 12.84474945068359 L 12.19523334503174 12.83434867858887 L 12.20643329620361 12.82474994659424 L 12.19283294677734 12.83674907684326 L 12.18483257293701 12.84315013885498 C 14.20802307128906 11.09524250030518 14.93145561218262 8.273837089538574 13.99894523620605 5.768063068389893 C 13.06643486022949 3.262288570404053 10.67451477050781 1.600245833396912 8.000849723815918 1.600245833396912 C 5.327185153961182 1.600245833396912 2.935263156890869 3.262288570404053 2.002753019332886 5.768063068389893 C 1.070243000984192 8.273837089538574 1.79367470741272 11.09524250030518 3.816864967346191 12.84315013885498 C 4.669869422912598 11.33518505096436 6.267545223236084 10.40206146240234 8.000049591064453 10.39995956420898 Z M 8.000049591064453 9.59996223449707 C 6.232745170593262 9.59996223449707 4.800061225891113 8.167279243469238 4.800061225891113 6.399974822998047 C 4.800061225891113 4.632670402526855 6.232745170593262 3.199987411499023 8.000049591064453 3.199987411499023 C 9.767354011535645 3.199987411499023 11.20003700256348 4.632670402526855 11.20003700256348 6.399974822998047 C 11.20003700256348 7.248664379119873 10.86289596557617 8.062593460083008 10.26278209686279 8.662707328796387 C 9.662668228149414 9.262821197509766 8.848738670349121 9.59996223449707 8.000049591064453 9.59996223449707 Z M 8.000049591064453 4.799981117248535 C 7.116397380828857 4.799981117248535 6.400055408477783 5.516322612762451 6.400055408477783 6.399974822998047 C 6.400055408477783 7.283627033233643 7.116397380828857 7.999968528747559 8.000049591064453 7.999968528747559 C 8.883701324462891 7.999968528747559 9.600043296813965 7.283627033233643 9.600043296813965 6.399974822998047 C 9.600043296813965 5.516322612762451 8.883701324462891 4.799981117248535 8.000049591064453 4.799981117248535 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String password =
    '<svg width="17" height="18" viewBox="0 0 17 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M13.8 8.19995H2.6C1.71634 8.19995 1 8.9163 1 9.79995V15.4C1 16.2836 1.71634 17 2.6 17H13.8C14.6837 17 15.4 16.2836 15.4 15.4V9.79995C15.4 8.9163 14.6837 8.19995 13.8 8.19995Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M4.2 8.2V5C4.2 3.93913 4.62142 2.92172 5.37157 2.17157C6.12172 1.42143 7.13913 1 8.2 1C9.26086 1 10.2783 1.42143 11.0284 2.17157C11.7786 2.92172 12.2 3.93913 12.2 5V8.2" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
