import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/ui/findcountry.dart';
import 'package:aiviewcloud/utils/device/Validator.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/app_logo.widget.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterByPhoneScreen extends StatefulWidget {
  @override
  _RegisterByPhoneState createState() => _RegisterByPhoneState();
}

class _RegisterByPhoneState extends State<RegisterByPhoneScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void onShowCountryList() {
    // Navigator.of(context).pushNamed(Routes.findCountry);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                  height: MediaQuery.of(context).size.height - 70.h,
                  child: FindCountry(
                    isModal: true,
                  )));
        });
  }

  late UserStore _store;
  bool isShowPassword = true;
  String error = "";
  int pwdLength = 0;
  String phoneErr = "";
  String pwdErr = "";
  String cfPwdErr = "";
  bool isEmpty = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<UserStore>(context);
  }

  bool isValidPhoneNumber(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  onCheckBox() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
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

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  void onRegister() {
    if (phoneErr.isNotEmpty || cfPwdErr.isNotEmpty || cfPwdErr.isNotEmpty)
      return;

    try {
      _store.phoneRegister({
        "UserRegisterHistory": {
          "Mobile": _phoneController.text,
          "Password": _passwordController.text,
          "ConfirmPassword": _passwordController.text,
          "CountriesCode": _store.selectedCountry?.code,
        }
      }).then((value) => {
            Navigator.of(context).pushNamed(Routes.enterComfirmationCode,
                arguments: {
                  'OTPGuid': value["OTPGuid"],
                  'Mobile': _phoneController.text
                })
          });
    } catch (error) {
      _showErrorMessage(
          AppLocalizations.of(context).translate("not_choose_country"));
    }
  }

  Widget navigate(BuildContext context) {
    _store.reset();
    Future.delayed(Duration(milliseconds: 0), () {});
    return Container();
  }

  checkEmpty() {
    if (_confirmPasswordController.text.length == 0 ||
        _passwordController.text.length == 0 ||
        _phoneController.text.length == 0) {
      setState(() {
        isEmpty = true;
      });
      return;
    }
    setState(() {
      isEmpty = false;
    });
  }

  Widget buildBody() {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Column(
            children: [
              Observer(
                builder: (context) {
                  return _store.success
                      ? navigate(context)
                      : _showErrorMessage(_store.errorStore.errorMessage);
                },
              ),
              AppLogoWidget(),
              Container(
                margin: EdgeInsets.only(bottom: 4.w),
                child:
                    // Adobe XD layer: 'Quốc gia' (text)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).translate('country'),
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Regular',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
              ),
              GestureDetector(
                  onTap: onShowCountryList,
                  child: Container(
                    height: 47.53173828125.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    margin: EdgeInsets.only(bottom: 24.w),
                    decoration: BoxDecoration(
                      color: const Color(0xff2b2f33),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            child:
                                // Adobe XD layer: 'Path 1671' (shape)
                                SvgPicture.string(
                              _svg_t33wzu,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Observer(builder: (context) {
                            return Container(
                              child:
                                  // Adobe XD layer: 'Việt Nam' (text)
                                  Text(
                                _store.selectedCountry?.name ?? '',
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay-Regular',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            );
                          })
                        ]),
                        Container(
                            child:
                                // Adobe XD layer: 'Vector' (shape)
                                SvgPicture.string(
                          _svg_yt80qh,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                      ],
                    ),
                  )),
              TextFieldWidget(
                hint: AppLocalizations.of(context).translate('enter_phone'),
                textController: _phoneController,
                onChanged: (text) {
                  setState(() {
                    phoneErr = !Validator.isValidPhoneNumber(text)
                        ? AppLocalizations.of(context)
                            .translate('wrong_phone_format')
                        : "";
                  });
                  checkEmpty();
                },
                iconWidget: Container(
                  width: 60.w,
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 10.h),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: const Color(0xff818181), width: 1))),
                  alignment: Alignment.center,
                  child: Text(
                      '+${_store.selectedCountry?.areaCode?.toString() ?? ''}',
                      style: const TextStyle(
                          color: const Color(0xff818181),
                          fontWeight: FontWeight.w400,
                          fontFamily: "SFProDisplay",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.center),
                ),
                headerText: Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    child: Text(
                      AppLocalizations.of(context).translate('enter_phone'),
                      style: TextStyle(
                        fontFamily: 'SFProDisplay-Regular',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    )),
                inputAction: TextInputAction.next,
                inputType: TextInputType.phone,
                errorText: phoneErr,
                autoFocus: false,
              ),
              TextFieldWidget(
                hint: AppLocalizations.of(context).translate('enter_password'),
                textController: _passwordController,
                isObscure: isShowPassword,
                inputAction: TextInputAction.next,
                autoFocus: false,
                errorText: pwdErr,
                onChanged: (text) {
                  checkEmpty();
                  setState(() {
                    pwdLength = _passwordController.text.length;
                    pwdErr = !Validator.validatePassword(text)
                        ? AppLocalizations.of(context)
                            .translate('wrong_password_desc')
                        : "";
                  });
                },
                headerText: Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'SFProDisplay-Regular',
                          fontSize: 17,
                          color: const Color(0xffffffff),
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('login_user_password'),
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
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    )),
                suffixIcon: GestureDetector(
                    onTap: onCheckBox,
                    child: Container(
                      width: 19,
                      height: 19,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child:
                          // Adobe XD layer: 'coolicon' (shape)
                          SvgPicture.string(
                        _svg_9k1pq1,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              TextFieldWidget(
                hint:
                    AppLocalizations.of(context).translate('re_enter_password'),
                textController: _confirmPasswordController,
                inputAction: TextInputAction.next,
                isObscure: true,
                errorText: cfPwdErr,
                headerText: Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    child: Text.rich(TextSpan(
                        style: TextStyle(
                          fontFamily: 'SFProDisplay-Regular',
                          fontSize: 17,
                          color: const Color(0xffffffff),
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('pwd_confirm'),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xfffd413c),
                            ),
                          )
                        ]))),
                onChanged: (text) {
                  checkEmpty();
                  setState(() {
                    cfPwdErr = _passwordController.text !=
                            _confirmPasswordController.text
                        ? AppLocalizations.of(context)
                            .translate("pwd_not_match")
                        : "";
                  });
                },
                autoFocus: false,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('require_pwd_desc'),
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
            ],
          ),
          Container(
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 6).h),
              child: Observer(builder: (context) {
                return SMEButton(
                    onPress: isEmpty ? null : onRegister,
                    title: AppLocalizations.of(context).translate('continue'),
                    isLoading: _store.registerLoading);
              }))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        resizeToAvoidBottomInset: true,
        body: ScreenWidget(
          widget: buildBody(),
          headerText:
              AppLocalizations.of(context).translate('register_account'),
        ));
  }
}

const String _svg_yt80qh =
    '<svg viewBox="0.0 0.0 11.0 15.8" ><path  d="M 4.664700031280518 15.36390018463135 C 4.662899971008301 15.3612003326416 4.661099910736084 15.35760021209717 4.659300327301025 15.35490036010742 L 0.6912000179290771 8.163000106811523 C -0.2556000053882599 6.446700096130371 -0.2286000102758408 4.40910005569458 0.7641000151634216 2.713500022888184 C 1.735200047492981 1.053900003433228 3.45959997177124 0.03959999978542328 5.377500057220459 0.0009000000427477062 C 5.459400177001953 0 5.542200088500977 0 5.624100208282471 0.0009000000427477062 C 7.542000293731689 0.03959999978542328 9.266400337219238 1.053900003433228 10.23750019073486 2.713500022888184 C 11.23019981384277 4.40910005569458 11.25720024108887 6.446700096130371 10.31040000915527 8.163000106811523 L 6.343200206756592 15.35490036010742 C 6.341400146484375 15.35760021209717 6.339600086212158 15.3612003326416 6.337800025939941 15.36390018463135 C 6.163200378417969 15.66450023651123 5.849999904632568 15.84360027313232 5.500800132751465 15.84360027313232 C 5.151600360870361 15.84360027313232 4.839300155639648 15.66450023651123 4.664700031280518 15.36390018463135 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_k9ezcx =
    '<svg viewBox="0.4 24.0 343.0 47.5" ><path transform="translate(0.39, 24.0)" d="M 335 0 C 339.4182739257812 0 343 3.546780347824097 343 7.921956539154053 L 343 39.60978317260742 C 343 43.98495864868164 339.4182739257812 47.53173828125 335 47.53173828125 L 8 47.53173828125 C 3.581721782684326 47.53173828125 0 43.98495864868164 0 39.60978317260742 L 0 7.921956539154053 C 0 3.546780347824097 3.581721782684326 0 8 0 L 335 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t33wzu =
    '<svg viewBox="311.0 44.0 16.0 8.0" ><path transform="translate(311.0, 44.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_9k1pq1 =
    '<svg viewBox="315.0 226.0 17.1 12.0" ><path transform="translate(315.0, 226.0)" d="M 8.570110321044922 11.99886989593506 C 7.164505004882812 12.01637363433838 5.773427486419678 11.71300983428955 4.50273609161377 11.1118631362915 C 3.517767190933228 10.631272315979 2.633297681808472 9.967555999755859 1.896565437316895 9.156163215637207 C 1.116198182106018 8.317251205444336 0.5017520189285278 7.338150501251221 0.0857011079788208 6.270607471466064 L 0 5.999792098999023 L 0.08998615294694901 5.728976726531982 C 0.5063351392745972 4.662368297576904 1.119458436965942 3.68352198600769 1.897422432899475 2.843419790267944 C 2.633887529373169 2.03209924697876 3.518062591552734 1.368386507034302 4.50273609161377 0.8877207040786743 C 5.773437023162842 0.2866032123565674 7.164507865905762 -0.01675935089588165 8.570110321044922 0.0007142079994082451 C 9.975709915161133 -0.01672918722033501 11.366774559021 0.2866319119930267 12.63748455047607 0.8877207040786743 C 13.62247562408447 1.368276238441467 14.50695133209229 2.031996488571167 15.24365615844727 2.843419790267944 C 16.0255012512207 3.681195735931396 16.64013481140137 4.660595893859863 17.05451965332031 5.728976726531982 L 17.14022064208984 5.999792098999023 L 17.05023574829102 6.270607471466064 C 15.70576858520508 9.770459175109863 12.31884574890137 12.05830001831055 8.570110321044922 11.99886989593506 Z M 8.570110321044922 1.714736342430115 C 5.652733325958252 1.623318552970886 2.975044012069702 3.321713924407959 1.814292430877686 5.999792098999023 C 2.974854230880737 8.678031921386719 5.65266752243042 10.37650585174561 8.570110321044922 10.28484725952148 C 11.4874210357666 10.37602424621582 14.1649866104126 8.677707672119141 15.325927734375 5.999792098999023 C 14.16669654846191 3.320414781570435 11.48801422119141 1.621389746665955 8.570110321044922 1.714736342430115 Z M 8.570110321044922 8.570825576782227 C 7.333722114562988 8.579010009765625 6.264208316802979 7.711551666259766 6.017045021057129 6.500092506408691 C 5.769881725311279 5.288633346557617 6.414102077484131 4.071537017822266 7.55488109588623 3.594728946685791 C 8.695660591125488 3.117920875549316 10.01437568664551 3.514575242996216 10.70282077789307 4.541593074798584 C 11.39126682281494 5.568610668182373 11.25715923309326 6.93914270401001 10.38268852233887 7.813227653503418 C 9.903894424438477 8.297658920288086 9.251225471496582 8.570452690124512 8.570110321044922 8.570825576782227 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
