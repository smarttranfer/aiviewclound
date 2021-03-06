// import 'package:another_flushbar/flushbar_helper.dart';
// import 'package:aiviewcloud/stores/user/user_store.dart';
// import 'package:aiviewcloud/utils/locale/app_localization.dart';
// import 'package:aiviewcloud/utils/routes/routes.dart';
// import 'package:aiviewcloud/widgets/app_logo.widget.dart';
// import 'package:aiviewcloud/widgets/header_widget.dart';
// import 'package:aiviewcloud/widgets/progress_indicator_widget.dart';
// import 'package:aiviewcloud/widgets/textfield_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:adobe_xd/pinned.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class RegisterByEmailScreen extends StatefulWidget {
//   @override
//   _RegisterByEmailState createState() => _RegisterByEmailState();
// }

// class _RegisterByEmailState extends State<RegisterByEmailScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();

//   late FocusNode _passwordFocusNode;
//   late FocusNode _cfpasswordFocusNode;
//   String error = "";
//   bool loading = false;
//   @override
//   void initState() {
//     super.initState();
//     _passwordFocusNode = FocusNode();
//     _cfpasswordFocusNode = FocusNode();
//   }

//   late UserStore _store;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _store = Provider.of<UserStore>(context);
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the Widget is removed from the Widget tree
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _passwordFocusNode.dispose();
//     _cfpasswordFocusNode.dispose();
//     super.dispose();
//   }

//   void onRegister() {
//     if (_emailController.text == "" || _passwordController.text == "") {
//       _showErrorMessage("Kh??ng ????? tr???ng th??ng tin");
//       return;
//     }
//     _store.emailRegister(_emailController.text, _passwordController.text);
//   }

//   _showErrorMessage(String message) {
//     if (message.isNotEmpty) {
//       Future.delayed(Duration(milliseconds: 0), () {
//         if (message.isNotEmpty) {
//           FlushbarHelper.createError(
//             message: message,
//             title: AppLocalizations.of(context).translate('home_tv_error'),
//             duration: Duration(seconds: 3),
//           )..show(context);
//         }
//       });
//     }

//     return SizedBox.shrink();
//   }

//   Widget navigate(BuildContext context) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       Navigator.of(context).pushNamedAndRemoveUntil(
//           Routes.login, (Route<dynamic> route) => false);
//     });
//     return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xffffffff),
//       body: Stack(
//         children: <Widget>[
//           Observer(
//             builder: (context) {
//               return _store.success
//                   ? navigate(context)
//                   : _showErrorMessage(_store.errorStore.errorMessage);
//             },
//           ),
//           Pinned.fromPins(
//             Pin(start: 0.0, end: 0.0),
//             Pin(start: 0.0, end: 0.0),
//             child: Stack(
//               children: <Widget>[
//                 Pinned.fromPins(
//                   Pin(start: 0.0, end: 0.0),
//                   Pin(start: 0.0, end: 0.0),
//                   child:
//                       // Adobe XD layer: '????ng k?? t??i kho???n b???' (shape)
//                       Container(
//                     color: const Color(0xff212529),
//                   ),
//                 ),
//                 Pinned.fromPins(
//                   Pin(start: 0.0, end: 0.0),
//                   Pin(start: 0.0, end: 0.0),
//                   child: Stack(
//                     children: <Widget>[
//                       HeaderWidget(headerText: "????ng k?? t??i kho???n"),
//                       Pinned.fromPins(
//                         Pin(size: 204.0, middle: 0.5029),
//                         Pin(size: 61.4, middle: 0.1652),
//                         child:
//                             // Adobe XD layer: 'Group 6384' (group)
//                             Stack(
//                           children: <Widget>[AppLogoWidget()],
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(end: 16.0, start: 16.0),
//                         Pin(size: 17.0, middle: 0.6013),
//                         child:
//                             // Adobe XD layer: 'M???t kh???u t??? 8 ~ 30 ???' (text)
//                             Text(
//                           'M???t kh???u t??? 8 ~ 30 k?? t??? g???m c??? ch??? s???',
//                           style: TextStyle(
//                             fontFamily: 'SFProDisplay-Regular',
//                             fontSize: 14,
//                             color: const Color(0xffffffff),
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(size: 38.0, start: 16.0),
//                         Pin(size: 28.0, middle: 0.6518),
//                         child:
//                             // Adobe XD layer: 'Rectangle 1830' (shape)
//                             Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7.0),
//                             color: const Color(0xff2b2f33),
//                           ),
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(size: 90.0, middle: 0.2095),
//                         Pin(size: 28.0, middle: 0.6518),
//                         child:
//                             // Adobe XD layer: 'Rectangle 1831' (shape)
//                             Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7.0),
//                             color: const Color(0xff2b2f33),
//                           ),
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(size: 50.0, middle: 0.4585),
//                         Pin(size: 28.0, middle: 0.6518),
//                         child:
//                             // Adobe XD layer: 'Rectangle 1832' (shape)
//                             Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7.0),
//                             color: const Color(0xff2b2f33),
//                           ),
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(size: 25.0, start: 24.0),
//                         Pin(size: 16.0, middle: 0.6491),
//                         child:
//                             // Adobe XD layer: 'Y???u' (text)
//                             SingleChildScrollView(
//                                 child: Text(
//                           'Y???u',
//                           style: TextStyle(
//                             fontFamily: 'SFProDisplay-Regular',
//                             fontSize: 14,
//                             color: const Color(0xff818181),
//                           ),
//                           textAlign: TextAlign.center,
//                         )),
//                       ),
//                       Pinned.fromPins(
//                         Pin(size: 83.0, middle: 0.2244),
//                         Pin(size: 16.0, middle: 0.6491),
//                         child:
//                             // Adobe XD layer: 'Trung b??nh' (text)
//                             SingleChildScrollView(
//                                 child: Text(
//                           'Trung b??nh',
//                           style: TextStyle(
//                             fontFamily: 'SFProDisplay-Regular',
//                             fontSize: 14,
//                             color: const Color(0xff818181),
//                           ),
//                           textAlign: TextAlign.center,
//                         )),
//                       ),
//                       Pinned.fromPins(Pin(start: 16.0, end: 15.6),
//                           Pin(size: 91.5, middle: 0.5267),
//                           child:
//                               // Adobe XD layer: 'Group 6387' (group)
//                               Stack(
//                             children: <Widget>[
//                               Pinned.fromPins(
//                                 Pin(start: 0.4, end: 0.0),
//                                 Pin(size: 47.5, end: 20.0),
//                                 child:
//                                     // Adobe XD layer: 'Rectangle 1833' (shape)
//                                     SvgPicture.string(
//                                   _svg_kchglu,
//                                   allowDrawingOutsideViewBox: true,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               Pinned.fromPins(
//                                 Pin(size: 183.0, start: 0.0),
//                                 Pin(size: 20.0, start: 0.0),
//                                 child:
//                                     // Adobe XD layer: 'X??c nh???n m???t kh???u *' (text)
//                                     Text.rich(
//                                   TextSpan(
//                                     style: TextStyle(
//                                       fontFamily: 'SFProDisplay-Regular',
//                                       fontSize: 17,
//                                       color: const Color(0xffffffff),
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: 'X??c nh???n m???t kh???u',
//                                       ),
//                                       TextSpan(
//                                         text: ' ',
//                                       ),
//                                       TextSpan(
//                                         text: '*',
//                                         style: TextStyle(
//                                           color: const Color(0xfffd413c),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   textHeightBehavior: TextHeightBehavior(
//                                       applyHeightToFirstAscent: false),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ),
//                               Pinned.fromPins(
//                                 Pin(end: 17.0, start: 17.0),
//                                 Pin(size: 21.0, start: 44),
//                                 child:
//                                     // Adobe XD layer: 'Nh???p l???i m???t kh???u' (text)
//                                     TextFieldWidget(
//                                   hint: AppLocalizations.of(context)
//                                       .translate('re_enter_password'),
//                                   textController: _confirmPasswordController,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       error = _passwordController.text !=
//                                               _confirmPasswordController.text
//                                           ? AppLocalizations.of(context)
//                                               .translate(
//                                                   're_enter_password_error')
//                                           : "";
//                                     });
//                                   },
//                                   inputAction: TextInputAction.next,
//                                   autoFocus: false,
//                                   errorText: error,
//                                   isObscure: true,
//                                   textStyle: TextStyle(
//                                     fontFamily: 'SFProDisplay-Regular',
//                                     fontSize: 17,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Pinned.fromPins(Pin(start: 0.0, end: 15.6),
//                                   Pin(end: 0, size: 15),
//                                   child: Text(
//                                     error,
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: const Color(0xfffd413c),
//                                     ),
//                                   )),
//                               Pinned.fromPins(
//                                 Pin(size: 17.1, end: 17),
//                                 Pin(size: 12.0, middle: 0.54),
//                                 child:
//                                     // Adobe XD layer: 'coolicon' (shape)
//                                     SvgPicture.string(
//                                   _svg_jaw9aw,
//                                   allowDrawingOutsideViewBox: true,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Pinned.fromPins(
//                         Pin(start: 16.0, end: 15.6),
//                         Pin(size: 71.5, middle: 0.4079),
//                         child:
//                             // Adobe XD layer: 'Group 6386' (group)
//                             Stack(
//                           children: <Widget>[
//                             Pinned.fromPins(
//                               Pin(start: 0.4, end: 0.0),
//                               Pin(size: 47.5, end: 0.0),
//                               child:
//                                   // Adobe XD layer: 'Rectangle 242' (shape)
//                                   SvgPicture.string(
//                                 _svg_z8sqxk,
//                                 allowDrawingOutsideViewBox: true,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             Pinned.fromPins(
//                               Pin(size: 183.0, start: 0.0),
//                               Pin(size: 20.0, start: 0.0),
//                               child:
//                                   // Adobe XD layer: 'M???t kh???u *' (text)
//                                   Text.rich(
//                                 TextSpan(
//                                   style: TextStyle(
//                                     fontFamily: 'SFProDisplay-Regular',
//                                     fontSize: 17,
//                                     color: const Color(0xffffffff),
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: 'M???t kh???u ',
//                                     ),
//                                     TextSpan(
//                                       text: '*',
//                                       style: TextStyle(
//                                         color: const Color(0xfffd413c),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 textHeightBehavior: TextHeightBehavior(
//                                     applyHeightToFirstAscent: false),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             Pinned.fromPins(Pin(end: 17.0, start: 17.0),
//                                 Pin(size: 21.0, middle: 0.9),
//                                 child:
//                                     // Adobe XD layer: 'Nh???p m???t kh???u' (text)
//                                     TextFieldWidget(
//                                   hint: AppLocalizations.of(context)
//                                       .translate('enter_password'),
//                                   textController: _passwordController,
//                                   inputAction: TextInputAction.next,
//                                   autoFocus: false,
//                                   isObscure: true,
//                                   textStyle: TextStyle(
//                                     fontFamily: 'SFProDisplay-Regular',
//                                     fontSize: 17,
//                                     color: Colors.white,
//                                   ),
//                                   onFieldSubmitted: (value) {
//                                     FocusScope.of(context)
//                                         .requestFocus(_cfpasswordFocusNode);
//                                   },
//                                 )),
//                             Pinned.fromPins(
//                               Pin(size: 17.1, end: 17.9),
//                               Pin(size: 12.0, middle: 0.73),
//                               child:
//                                   // Adobe XD layer: 'coolicon' (shape)
//                                   SvgPicture.string(
//                                 _svg_o9de20,
//                                 allowDrawingOutsideViewBox: true,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(start: 16.0, end: 15.6),
//                         Pin(size: 71.5, middle: 0.289),
//                         child:
//                             // Adobe XD layer: 'Group 6385' (group)
//                             Stack(
//                           children: <Widget>[
//                             Pinned.fromPins(
//                               Pin(start: 0.4, end: 0.0),
//                               Pin(size: 47.5, end: 0.0),
//                               child:
//                                   // Adobe XD layer: 'Rectangle 241' (shape)
//                                   SvgPicture.string(
//                                 _svg_k9ezcx,
//                                 allowDrawingOutsideViewBox: true,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             Pinned.fromPins(
//                               Pin(size: 111.0, start: 0.0),
//                               Pin(size: 20.0, start: 0.0),
//                               child:
//                                   // Adobe XD layer: 'Email *' (text)
//                                   Text.rich(
//                                 TextSpan(
//                                   style: TextStyle(
//                                     fontFamily: 'SFProDisplay-Regular',
//                                     fontSize: 17,
//                                     color: const Color(0xffffffff),
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: 'Email ',
//                                     ),
//                                     TextSpan(
//                                       text: '*',
//                                       style: TextStyle(
//                                         color: const Color(0xfffd413c),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 textHeightBehavior: TextHeightBehavior(
//                                     applyHeightToFirstAscent: false),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             Pinned.fromPins(Pin(end: 16.0, start: 16.0),
//                                 Pin(size: 20.0, middle: 0.9),
//                                 child: TextFieldWidget(
//                                   hint: AppLocalizations.of(context)
//                                       .translate('email_input'),
//                                   textController: _emailController,
//                                   inputType: TextInputType.emailAddress,
//                                   inputAction: TextInputAction.next,
//                                   autoFocus: true,
//                                   textStyle: TextStyle(
//                                     fontFamily: 'SFProDisplay-Regular',
//                                     fontSize: 17,
//                                     color: Colors.white,
//                                   ),
//                                   onFieldSubmitted: (value) {
//                                     FocusScope.of(context)
//                                         .requestFocus(_passwordFocusNode);
//                                   },
//                                 )),
//                           ],
//                         ),
//                       ),
//                       Pinned.fromPins(
//                         Pin(size: 64.0, middle: 0.4604),
//                         Pin(size: 16.0, middle: 0.6491),
//                         child:
//                             // Adobe XD layer: 'M???nh' (text)
//                             SingleChildScrollView(
//                                 child: Text(
//                           'M???nh',
//                           style: TextStyle(
//                             fontFamily: 'SFProDisplay-Regular',
//                             fontSize: 14,
//                             color: const Color(0xff818181),
//                           ),
//                           textAlign: TextAlign.center,
//                         )),
//                       ),
//                       Observer(builder: (context) {
//                         return GestureDetector(
//                             onTap: onRegister,
//                             child: _store.registerLoading
//                                 ? CustomProgressIndicatorWidget()
//                                 : Pinned.fromPins(
//                                     Pin(start: 16.0, end: 16.0),
//                                     Pin(size: 48.0, end: 34.0),
//                                     child:
//                                         // Adobe XD layer: 'Group 6210' (group)
//                                         Stack(
//                                       children: <Widget>[
//                                         Pinned.fromPins(
//                                           Pin(start: 0.0, end: 0.0),
//                                           Pin(start: 0.0, end: 0.0),
//                                           child:
//                                               // Adobe XD layer: 'Rectangle 1818' (shape)
//                                               Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8.0),
//                                               color: const Color(0xfffd7b38),
//                                             ),
//                                           ),
//                                         ),
//                                         Pinned.fromPins(
//                                             Pin(size: 78.0, middle: 0.4982),
//                                             Pin(size: 20.0, middle: 0.5),
//                                             child: Text(
//                                               'Ti???p t???c',
//                                               style: TextStyle(
//                                                 fontFamily:
//                                                     'SFProDisplay-Regular',
//                                                 fontSize: 17,
//                                                 color: const Color(0xffffffff),
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             )),
//                                       ],
//                                     ),
//                                   ));
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
// const String _svg_l9y9ys =
//     '<svg viewBox="-4743.0 -4463.0 10.0 20.0" ><path transform="translate(-4743.0, -4463.0)" d="M 10 0 L 0 10 L 10 20" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="bevel" /></svg>';
// const String _svg_ct8dl8 =
//     '<svg viewBox="0.0 0.0 43.5 33.2" ><path  d="M 43.32783126831055 32.65023040771484 C 43.41228485107422 32.83208465576172 43.4851188659668 33.01910781860352 43.54591751098633 33.21017456054688 L 34.43826675415039 33.21017456054688 C 34.34746170043945 32.90352630615234 34.2337532043457 32.60415267944336 34.0980110168457 32.31457901000977 L 23.05523681640625 7.455705642700195 C 22.91575050354004 7.202282428741455 22.70564270019531 6.994846820831299 22.4504451751709 6.858632564544678 C 22.20294570922852 6.732467651367188 21.92857551574707 6.668238639831543 21.65079116821289 6.671464443206787 C 21.38343811035156 6.667282581329346 21.11873817443848 6.725000381469727 20.87738418579102 6.840080738067627 C 20.62457084655762 6.981693744659424 20.42144203186035 7.19771671295166 20.29572296142578 7.458797931671143 L 9.350473403930664 32.31766891479492 C 9.185173034667969 32.59933471679688 9.054831504821777 32.90007781982422 8.962259292602539 33.2132682800293 L 0 33.2132682800293 C 0.06216536089777946 33.02268600463867 0.134966641664505 32.83574295043945 0.2180874049663544 32.6533203125 C 0.3084246814250946 32.45988845825195 0.4118019938468933 32.27281188964844 0.5274693965911865 32.09337615966797 L 12.9282398223877 4.76114559173584 C 14.90971088409424 1.990798711776733 16.5462474822998 0.03098537400364876 21.42335891723633 0.03098537400364876 C 23.22607231140137 -0.1160534471273422 25.03280448913574 0.2623746395111084 26.62497901916504 1.12050187587738 C 28.21715354919434 1.978629231452942 29.52654647827148 3.279705286026001 30.39486885070801 4.866342067718506 L 43.01844787597656 32.09028244018555 C 43.13523101806641 32.26905059814453 43.23865509033203 32.45621109008789 43.32783126831055 32.65023040771484 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_3dgrum =
//     '<svg viewBox="0.0 0.0 9.4 9.7" ><path  d="M 0.2978864312171936 3.021029949188232 C 0.5173570513725281 2.436928987503052 0.851800262928009 1.902840375900269 1.281545639038086 1.450446486473083 C 1.711290955543518 0.9980525970458984 2.227591514587402 0.6365667581558228 2.799660682678223 0.3874119818210602 C 3.371729850769043 0.1382571905851364 3.987925052642822 0.006519630551338196 4.611863136291504 0 C 5.878654479980469 0.01496456190943718 7.088942527770996 0.526972770690918 7.981832981109619 1.425711035728455 C 8.874722480773926 2.324449300765991 9.37873363494873 3.537976741790771 9.385428428649902 4.80483865737915 C 9.392122268676758 6.071700096130371 8.900956153869629 7.290475368499756 8.017614364624023 8.198599815368652 C 7.13427209854126 9.106723785400391 5.929501533508301 9.631505012512207 4.662939071655273 9.659855842590332 C 4.038153171539307 9.660609245300293 3.419589519500732 9.535608291625977 2.844127893447876 9.292293548583984 C 2.26866626739502 9.048979759216309 1.748096704483032 8.692320823669434 1.313361763954163 8.243585586547852 C 0.8786269426345825 7.794850826263428 0.5386108160018921 7.263201713562012 0.3136529326438904 6.680319309234619 C 0.08869502693414688 6.097436904907227 -0.01665664091706276 5.475240707397461 0.003893259912729263 4.850792407989502 L 0.003893259912729263 4.850792407989502 C -0.02161328122019768 4.227342128753662 0.07841580361127853 3.605130910873413 0.2978864312171936 3.021029949188232 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_bae7ky =
//     '<svg viewBox="0.0 0.0 7.4 34.1" ><path  d="M 7.386074066162109 30.02985954284668 C 7.450348377227783 30.53642272949219 7.407418727874756 31.05086135864258 7.260130882263184 31.5397834777832 C 7.11284351348877 32.02870559692383 6.864485740661621 32.481201171875 6.5310959815979 32.86796951293945 C 6.19770622253418 33.25473785400391 5.786776542663574 33.56711959838867 5.324911594390869 33.78488159179688 C 4.863047122955322 34.00263977050781 4.360540866851807 34.12091827392578 3.85003662109375 34.13202667236328 C 3.322032451629639 34.14044189453125 2.798141956329346 34.03801727294922 2.312190294265747 33.83135223388672 C 1.826238512992859 33.62469100952148 1.389076948165894 33.31838989257812 1.028873324394226 32.9322395324707 C 0.6686697602272034 32.54608917236328 0.3934231102466583 32.08866882324219 0.2210058271884918 31.58953857421875 C 0.04858853295445442 31.09040641784668 -0.01722186617553234 30.56065368652344 0.02784267999231815 30.03450775146484 C -0.009280894882977009 21.37234115600586 -0.009280894882977009 12.71016788482666 0.02784267999231815 4.047999858856201 C 0.005451055709272623 3.537107229232788 0.08425532281398773 3.026841640472412 0.2597139775753021 2.546501159667969 C 0.4351726174354553 2.066160440444946 0.7038854360580444 1.625219821929932 1.050304412841797 1.249046087265015 C 1.396723389625549 0.8728724718093872 1.814008116722107 0.5688663125038147 2.278296947479248 0.3545100688934326 C 2.742585897445679 0.1401538103818893 3.244716882705688 0.01968767307698727 3.755721092224121 0 C 4.265200614929199 0.009832696057856083 4.767146110534668 0.1244281604886055 5.230407238006592 0.3366901576519012 C 5.693668365478516 0.5489521622657776 6.108267784118652 0.8543270230293274 6.448392868041992 1.23377525806427 C 6.788517475128174 1.613223552703857 7.046934127807617 2.058619976043701 7.207450389862061 2.542252540588379 C 7.367966175079346 3.025885343551636 7.427192211151123 3.537390947341919 7.381448268890381 4.044908046722412 C 7.409290790557861 8.372898101806641 7.386074066162109 12.70553207397461 7.386074066162109 17.0366153717041 C 7.386074066162109 21.36770057678223 7.404635906219482 25.69877433776855 7.386074066162109 30.02985954284668 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_l4kjb7 =
//     '<svg viewBox="0.0 0.0 96.0 61.4" ><path  d="M 20.13930130004883 61.36020278930664 C 14.79960060119629 61.35480117797852 9.680399894714355 59.23080062866211 5.904900074005127 55.45530319213867 C 2.129400014877319 51.67980194091797 0.005400000140070915 46.56060028076172 0 41.22090148925781 L 0 20.13930130004883 C 0.005400000140070915 14.79960060119629 2.129400014877319 9.680399894714355 5.904900074005127 5.904900074005127 C 9.680399894714355 2.129400014877319 14.79960060119629 0.005400000140070915 20.13930130004883 0 L 75.86009979248047 0 C 81.19979858398438 0.005400000140070915 86.31900024414062 2.129400014877319 90.09450531005859 5.904900074005127 C 93.87090301513672 9.680399894714355 95.99400329589844 14.79960060119629 96.00030517578125 20.13930130004883 L 96.00030517578125 41.22090148925781 C 95.99400329589844 46.56060028076172 93.87090301513672 51.67980194091797 90.09450531005859 55.45530319213867 C 86.31900024414062 59.23080062866211 81.19979858398438 61.35480117797852 75.86009979248047 61.36020278930664 L 20.13930130004883 61.36020278930664 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_kchglu =
//     '<svg viewBox="0.4 24.0 343.0 47.5" ><path transform="translate(0.39, 24.0)" d="M 335 0 C 339.4182739257812 0 343 3.546777248382568 343 7.921948909759521 L 343 39.60974502563477 C 343 43.98491668701172 339.4182739257812 47.53169250488281 335 47.53169250488281 L 8 47.53169250488281 C 3.581721782684326 47.53169250488281 0 43.98491668701172 0 39.60974502563477 L 0 7.921948909759521 C 0 3.546777248382568 3.581721782684326 0 8 0 L 335 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_z8sqxk =
//     '<svg viewBox="0.4 24.0 343.0 47.5" ><path transform="translate(0.39, 24.0)" d="M 335 0 C 339.4182739257812 0 343 3.546777009963989 343 7.921948909759521 L 343 39.60974502563477 C 343 43.98491668701172 339.4182739257812 47.53169250488281 335 47.53169250488281 L 8 47.53169250488281 C 3.581721782684326 47.53169250488281 0 43.98491668701172 0 39.60974502563477 L 0 7.921948909759521 C 0 3.546777009963989 3.581721782684326 0 8 0 L 335 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_k9ezcx =
//     '<svg viewBox="0.4 24.0 343.0 47.5" ><path transform="translate(0.39, 24.0)" d="M 335 0 C 339.4182739257812 0 343 3.546780347824097 343 7.921956539154053 L 343 39.60978317260742 C 343 43.98495864868164 339.4182739257812 47.53173828125 335 47.53173828125 L 8 47.53173828125 C 3.581721782684326 47.53173828125 0 43.98495864868164 0 39.60978317260742 L 0 7.921956539154053 C 0 3.546780347824097 3.581721782684326 0 8 0 L 335 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_o9de20 =
//     '<svg viewBox="-4434.0 -4177.0 17.1 12.0" ><path transform="translate(-4434.0, -4177.0)" d="M 8.56980037689209 11.99880027770996 C 7.164900302886963 12.01679992675781 5.773499965667725 11.71260070800781 4.502700328826904 11.11229991912842 C 3.518100023269653 10.63170051574707 2.633399963378906 9.967500686645508 1.896300077438354 9.156599998474121 C 1.116000056266785 8.316900253295898 0.5022000074386597 7.338600158691406 0.08550000190734863 6.270300388336182 L 0 5.99940013885498 L 0.09000000357627869 5.729400157928467 C 0.5067000389099121 4.662000179290771 1.119600057601929 3.683700084686279 1.897199988365173 2.843100070953369 C 2.634299993515015 2.03220009803772 3.518100023269653 1.368000030517578 4.502700328826904 0.8874000310897827 C 5.773499965667725 0.2862000167369843 7.164900302886963 -0.01710000075399876 8.56980037689209 0.0009000000427477062 C 9.975600242614746 -0.01710000075399876 11.36700057983398 0.2862000167369843 12.6378002166748 0.8874000310897827 C 13.62240028381348 1.368000030517578 14.50710010528564 2.03220009803772 15.24330043792725 2.843100070953369 C 16.02540016174316 3.680999994277954 16.64010047912598 4.660200119018555 17.05410003662109 5.729400157928467 L 17.14050102233887 5.99940013885498 L 17.05050086975098 6.270300388336182 C 15.72297096252441 9.72596549987793 12.40483093261719 11.99991512298584 8.712390899658203 11.99992847442627 C 8.664911270141602 11.99992942810059 8.617400169372559 11.99955463409424 8.56980037689209 11.99880027770996 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_jaw9aw =
//     '<svg viewBox="-4434.0 -4089.0 17.1 12.0" ><path transform="translate(-4434.0, -4089.0)" d="M 8.56980037689209 11.99880027770996 C 7.164900302886963 12.01679992675781 5.773499965667725 11.71260070800781 4.502700328826904 11.11229991912842 C 3.518100023269653 10.63170051574707 2.633399963378906 9.967500686645508 1.896300077438354 9.156599998474121 C 1.116000056266785 8.316900253295898 0.5022000074386597 7.338600158691406 0.08550000190734863 6.270300388336182 L 0 5.99940013885498 L 0.09000000357627869 5.729400157928467 C 0.5067000389099121 4.662000179290771 1.119600057601929 3.683700084686279 1.897199988365173 2.843100070953369 C 2.634299993515015 2.03220009803772 3.518100023269653 1.368000030517578 4.502700328826904 0.8874000310897827 C 5.773499965667725 0.2862000167369843 7.164900302886963 -0.01710000075399876 8.56980037689209 0.0009000000427477062 C 9.975600242614746 -0.01710000075399876 11.36700057983398 0.2862000167369843 12.6378002166748 0.8874000310897827 C 13.62240028381348 1.368000030517578 14.50710010528564 2.03220009803772 15.24330043792725 2.843100070953369 C 16.02540016174316 3.680999994277954 16.64010047912598 4.660200119018555 17.05410003662109 5.729400157928467 L 17.14050102233887 5.99940013885498 L 17.05050086975098 6.270300388336182 C 15.72297096252441 9.72596549987793 12.40483093261719 11.99991512298584 8.712390899658203 11.99992847442627 C 8.664911270141602 11.99992942810059 8.617400169372559 11.99955463409424 8.56980037689209 11.99880027770996 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
