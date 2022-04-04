import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDeviceFinal extends StatefulWidget {
  @override
  _AddDeviceFinalState createState() => _AddDeviceFinalState();
}

class _AddDeviceFinalState extends State<AddDeviceFinal> {
  String serial = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if (arguments != null)
      setState(() {
        serial = arguments["serial"].toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 200.0, start: 0.0),
            child:
                // Adobe XD layer: 'Rectangle 1891' (shape)
                Container(
              decoration: BoxDecoration(
                color: const Color(0xff2b2f33),
              ),
            ),
          ),
          HeaderWidget(
              headerText: AppLocalizations.of(context).translate('complete')),
          // Pinned.fromPins(
          //   Pin(size: 16.0, end: 16.0),
          //   Pin(size: 16.0, start: 108.0),
          //   child:
          //       // Adobe XD layer: 'coolicon' (shape)
          //       SvgPicture.string(
          //     _svg_clvt5t,
          //     allowDrawingOutsideViewBox: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Pinned.fromPins(
            Pin(size: 81.0, middle: 0.3339),
            Pin(size: 16.0, start: 108.0),
            child:
                // Adobe XD layer: 'Tên thiết bị' (text)
                SingleChildScrollView(
                    child: Text(
              'Tên thiết bị',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 75.0, middle: 0.3339),
            Pin(size: 16.0, start: 128.0),
            child:
                // Adobe XD layer: 'Chi nhánh' (text)
                SingleChildScrollView(
                    child: Text(
              'Chi nhánh',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 75.0, middle: 0.3339),
            Pin(size: 16.0, start: 148.0),
            child:
                // Adobe XD layer: 'MAC' (text)
                SingleChildScrollView(
                    child: Text(
              'MAC',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, middle: 0.3439),
            Pin(size: 16.0, start: 168.0),
            child:
                // Adobe XD layer: 'Seri Number' (text)
                SingleChildScrollView(
                    child: Text(
              'Seri Number',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 75.0, middle: 0.6567),
            Pin(size: 16.0, start: 108.0),
            child:
                // Adobe XD layer: 'Đầu ghi' (text)
                SingleChildScrollView(
                    child: Text(
              'Đầu ghi',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 75.0, middle: 0.6567),
            Pin(size: 16.0, start: 128.0),
            child:
                // Adobe XD layer: 'Chưa có' (text)
                SingleChildScrollView(
                    child: Text(
              'Chưa có',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 93.0, middle: 0.6886),
            Pin(size: 16.0, start: 148.0),
            child:
                // Adobe XD layer: 'AGDGDADKSH' (text)
                SingleChildScrollView(
                    child: Text(
              'AGDGDADKSH',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 124.0, middle: 0.7586),
            Pin(size: 16.0, start: 168.0),
            child:
                // Adobe XD layer: 'AGDGDADKSH1233' (text)
                SingleChildScrollView(
                    child: Text(
              serial,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            )),
          ),
          Pinned.fromPins(
            Pin(size: 73.0, start: 17.0),
            Pin(size: 73.0, start: 108.0),
            child:
                // Adobe XD layer: 'Group 6409' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Rectangle 1845' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: const Color(0x1a4ba541),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 30.4, start: 38.3),
            Pin(size: 28.0, start: 132.0),
            child:
                // Adobe XD layer: 'Group 7454' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Group 7436' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 12.2, end: 0.0),
                        child:
                            // Adobe XD layer: 'Vector' (shape)
                            SvgPicture.string(
                          _svg_5wgtiu,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 1.0, middle: 0.2068),
                        Pin(size: 1.0, end: 2.7),
                        child:
                            // Adobe XD layer: 'Vector' (shape)
                            SvgPicture.string(
                          _svg_mabpwd,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 12.2, start: 0.0),
                        child:
                            // Adobe XD layer: 'Vector' (shape)
                            SvgPicture.string(
                          _svg_70a8si,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 1.0, middle: 0.2068),
                        Pin(size: 1.0, middle: 0.2251),
                        child:
                            // Adobe XD layer: 'Vector' (shape)
                            SvgPicture.string(
                          _svg_jd1l9d,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 2.5, middle: 0.1909),
                        Pin(size: 2.5, middle: 0.199),
                        child:
                            // Adobe XD layer: 'Ellipse 266' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            color: const Color(0xff3a6539),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 2.5, middle: 0.1909),
                        Pin(size: 2.5, middle: 0.8209),
                        child:
                            // Adobe XD layer: 'Ellipse 267' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            color: const Color(0xff3a6539),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Pinned.fromPins(
          //   Pin(start: 16.0, end: 16.0),
          //   Pin(size: 68.0, middle: 0.2903),
          //   child:
          //       // Adobe XD layer: 'Group 7515' (group)
          //       Stack(
          //     children: <Widget>[
          //       Pinned.fromPins(
          //         Pin(start: 0.0, end: 0.0),
          //         Pin(start: 0.0, end: 0.0),
          //         child:
          //             // Adobe XD layer: 'Rectangle 1892' (shape)
          //             Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8.0),
          //             color: const Color(0xff2b2f33),
          //           ),
          //         ),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 16.0, end: 16.5),
          //         Pin(size: 16.0, middle: 0.5),
          //         child:
          //             // Adobe XD layer: 'coolicon' (shape)
          //             SvgPicture.string(
          //           _svg_chss76,
          //           allowDrawingOutsideViewBox: true,
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 71.0, middle: 0.2062),
          //         Pin(size: 16.0, middle: 0.3077),
          //         child:
          //             // Adobe XD layer: 'Tên thiết bị' (text)
          //             SingleChildScrollView(
          //                 child: Text(
          //           'Tên thiết bị',
          //           style: TextStyle(
          //             fontFamily: 'Roboto',
          //             fontSize: 14,
          //             color: const Color(0xffffffff),
          //             fontWeight: FontWeight.w700,
          //           ),
          //           textAlign: TextAlign.left,
          //         )),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 64.0, middle: 0.2011),
          //         Pin(size: 16.0, middle: 0.6923),
          //         child:
          //             // Adobe XD layer: 'Chi nhánh' (text)
          //             SingleChildScrollView(
          //                 child: Text(
          //           'Chi nhánh',
          //           style: TextStyle(
          //             fontFamily: 'Roboto',
          //             fontSize: 14,
          //             color: const Color(0xffffffff),
          //             fontWeight: FontWeight.w700,
          //           ),
          //           textAlign: TextAlign.left,
          //         )),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 75.0, middle: 0.532),
          //         Pin(size: 16.0, middle: 0.3077),
          //         child:
          //             // Adobe XD layer: 'Đầu ghi' (text)
          //             SingleChildScrollView(
          //                 child: Text(
          //           'Đầu ghi',
          //           style: TextStyle(
          //             fontFamily: 'Roboto',
          //             fontSize: 14,
          //             color: const Color(0xffffffff),
          //           ),
          //           textAlign: TextAlign.left,
          //         )),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 75.0, middle: 0.5354),
          //         Pin(size: 16.0, middle: 0.6923),
          //         child:
          //             // Adobe XD layer: 'Hà Nội' (text)
          //             SingleChildScrollView(
          //                 child: Text(
          //           'Hà Nội',
          //           style: TextStyle(
          //             fontFamily: 'Roboto',
          //             fontSize: 14,
          //             color: const Color(0xffffffff),
          //           ),
          //           textAlign: TextAlign.left,
          //         )),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 32.2, start: 16.0),
          //         Pin(size: 24.0, middle: 0.5),
          //         child:
          //             // Adobe XD layer: 'Group 6628' (group)
          //             Stack(
          //           children: <Widget>[
          //             Pinned.fromPins(
          //               Pin(start: 0.0, end: 0.0),
          //               Pin(start: 0.0, end: 0.0),
          //               child:
          //                   // Adobe XD layer: 'Group 6539' (group)
          //                   Stack(
          //                 children: <Widget>[
          //                   Pinned.fromPins(
          //                     Pin(start: 0.0, end: 0.0),
          //                     Pin(start: 0.0, end: 0.0),
          //                     child:
          //                         // Adobe XD layer: 'Video' (group)
          //                         Stack(
          //                       children: <Widget>[
          //                         Pinned.fromPins(
          //                           Pin(size: 7.1, end: 0.0),
          //                           Pin(start: 3.6, end: 3.6),
          //                           child:
          //                               // Adobe XD layer: 'Fill 1' (shape)
          //                               SvgPicture.string(
          //                             _svg_7trq1c,
          //                             allowDrawingOutsideViewBox: true,
          //                             fit: BoxFit.fill,
          //                           ),
          //                         ),
          //                         Pinned.fromPins(
          //                           Pin(start: 0.0, end: 9.7),
          //                           Pin(start: 0.0, end: 0.0),
          //                           child:
          //                               // Adobe XD layer: 'Fill 3' (shape)
          //                               SvgPicture.string(
          //                             _svg_fczvms,
          //                             allowDrawingOutsideViewBox: true,
          //                             fit: BoxFit.fill,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Pinned.fromPins(
            Pin(start: 16.0, end: 16.0),
            Pin(size: 48.0, end: 34.0),
            child:
                // Adobe XD layer: 'Group 6198' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Rectangle 1818' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xff818181),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 151.0, middle: 0.5),
                  Pin(size: 20, middle: 0.5),
                  child:
                      // Adobe XD layer: 'Xong' (text)
                      Text(
                    AppLocalizations.of(context).translate('done'),
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 17,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.deviceManagement, (Route<dynamic> route) => false);
              },
              child: Pinned.fromPins(
                Pin(start: 16.0, end: 16.0),
                Pin(size: 48.0, end: 94.0),
                child:
                    // Adobe XD layer: 'Group 6626' (group)
                    Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(start: 0.0, end: 0.0),
                      child:
                          // Adobe XD layer: 'Rectangle 1818' (shape)
                          Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xfffd7b38),
                        ),
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(size: 151.0, middle: 0.5),
                      Pin(size: 20, middle: 0.5),
                      child:
                          // Adobe XD layer: 'Tiếp tục thêm' (text)
                          Text(
                        'Tiếp tục thêm',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 17,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.deviceManagement, (Route<dynamic> route) => false);
              },
              child: Pinned.fromPins(
                Pin(start: 16.0, end: 16.0),
                Pin(size: 48.0, middle: 0.7984),
                child:
                    // Adobe XD layer: 'Group 6627' (group)
                    Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(start: 0.0, end: 0.0),
                      child:
                          // Adobe XD layer: 'Rectangle 1818' (shape)
                          Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xff4aa541),
                        ),
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(size: 151.0, middle: 0.5),
                      Pin(size: 20, middle: 0.5),
                      child:
                          // Adobe XD layer: 'Xem trực tiếp' (text)
                          Text(
                        'Xem trực tiếp',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 17,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

const String _svg_q8lvy6 =
    '<svg viewBox="327.4 622.0 16.0 16.0" ><path transform="translate(327.45, 622.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a2q4ys =
    '<svg viewBox="58.1 621.6 7.1 16.9" ><path transform="translate(58.1, 621.56)" d="M 5.988861083984375 0.34589883685112 C 5.318454265594482 -0.07643613219261169 4.49444580078125 -0.113796554505825 3.792038679122925 0.2435638159513474 L 1.420814514160156 1.440721035003662 C 0.5440055727958679 1.882548451423645 0 2.775949478149414 0 3.770061016082764 L 0 13.10366344451904 C 0 14.09777545928955 0.5440055727958679 14.98955154418945 1.420814514160156 15.4346284866333 L 3.790438890457153 16.63016128540039 C 4.11204195022583 16.79584693908691 4.456045627593994 16.87544059753418 4.800048828125 16.87544059753418 C 5.212852954864502 16.87544059753418 5.622457504272461 16.75848579406738 5.988861083984375 16.52945137023926 C 6.659267902374268 16.10873985290527 7.059271812438965 15.3794002532959 7.059271812438965 14.58021259307861 L 7.059271812438965 2.296761751174927 C 7.059271812438965 1.497573971748352 6.659267902374268 0.7682337760925293 5.988861083984375 0.34589883685112 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_31yoy =
    '<svg viewBox="33.0 618.0 22.4 24.0" ><path transform="translate(33.0, 618.0)" d="M 15.8481559753418 24 L 6.580864429473877 24 C 2.705626249313354 24 0 21.32791900634766 0 17.50253677368164 L 0 6.497461795806885 C 0 2.670456647872925 2.705626249313354 0 6.580864429473877 0 L 15.8481559753418 0 C 19.7233943939209 0 22.42901992797852 2.670456647872925 22.42901992797852 6.497461795806885 L 22.42901992797852 17.50253677368164 C 22.42901992797852 21.32791900634766 19.7233943939209 24 15.8481559753418 24 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o2muup =
    '<svg viewBox="331.4 19.0 22.0 11.3" ><path transform="translate(331.45, 19.0)" d="M 2.66700005531311 0 L 19.33300018310547 0 C 20.80594444274902 0 22 1.194056630134583 22 2.66700005531311 L 22 8.666000366210938 C 22 10.13894367218018 20.80594444274902 11.33300018310547 19.33300018310547 11.33300018310547 L 2.66700005531311 11.33300018310547 C 1.194056630134583 11.33300018310547 0 10.13894367218018 0 8.666000366210938 L 0 2.66700005531311 C 0 1.194056630134583 1.194056630134583 0 2.66700005531311 0 Z" fill="#ffffff" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7zzpga =
    '<svg viewBox="354.4 22.7 1.3 4.0" ><path transform="translate(354.45, 22.67)" d="M 0 2.220446049250313e-16 L 0 4 C 0.3935926258563995 3.834296226501465 0.7295427322387695 3.55614161491394 0.9657710194587708 3.200376033782959 C 1.201999306678772 2.844610452651978 1.32800304889679 2.427051544189453 1.327999949455261 2 C 1.32800304889679 1.572948575019836 1.201999306678772 1.155389547348022 0.9657710194587708 0.7996240258216858 C 0.7295427322387695 0.4438585042953491 0.3935926258563995 0.1657038182020187 2.220446049250313e-16 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_8unnsq =
    '<svg viewBox="333.4 21.0 18.0 7.3" ><path transform="translate(333.45, 21.0)" d="M 1.33299994468689 0 L 16.66699981689453 0 C 17.40319442749023 0 18 0.5968043804168701 18 1.33299994468689 L 18 6 C 18 6.73619556427002 17.40319442749023 7.333000183105469 16.66699981689453 7.333000183105469 L 1.33299994468689 7.333000183105469 C 0.5968043804168701 7.333000183105469 0 6.73619556427002 0 6 L 0 1.33299994468689 C 0 0.5968043804168701 0.5968043804168701 0 1.33299994468689 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_6tpr3i =
    '<svg viewBox="311.1 18.0 15.3 13.0" ><path transform="translate(311.12, 18.0)" d="M 7.667769908905029 13 C 7.624964714050293 12.99906158447266 7.582889556884766 12.98872184753418 7.544525146484375 12.96971225738525 C 7.506160736083984 12.95070266723633 7.472446441650391 12.92348957061768 7.445770263671875 12.89000034332275 L 5.439770221710205 10.5 C 5.3775954246521 10.4230260848999 5.34451961517334 10.32661247253418 5.346348285675049 10.22768115997314 C 5.348176956176758 10.12874984741211 5.384793281555176 10.03362369537354 5.449769973754883 9.958999633789062 C 5.737918853759766 9.66071891784668 6.082252025604248 9.422415733337402 6.462923526763916 9.257823944091797 C 6.843595027923584 9.093232154846191 7.253077507019043 9.005607604980469 7.667769908905029 9 C 8.082701683044434 9.005606651306152 8.492417335510254 9.093323707580566 8.873273849487305 9.258092880249023 C 9.254130363464355 9.42286205291748 9.598587036132812 9.661418914794922 9.886770248413086 9.960000038146973 C 9.951788902282715 10.03465270996094 9.988348007202148 10.12987422943115 9.989995002746582 10.22885799407959 C 9.991641998291016 10.32784175872803 9.958271026611328 10.42422580718994 9.895771026611328 10.50100040435791 L 7.889770030975342 12.89000034332275 C 7.863093852996826 12.92348957061768 7.829379558563232 12.95070266723633 7.791015148162842 12.96971225738525 C 7.752650737762451 12.98872184753418 7.710575103759766 12.99906158447266 7.667769908905029 13 Z M 11.19077014923096 8.805999755859375 C 11.14989948272705 8.805482864379883 11.10960388183594 8.796302795410156 11.07254219055176 8.779065132141113 C 11.03548049926758 8.76182746887207 11.00249862670898 8.73692512512207 10.97577095031738 8.706000328063965 C 10.55832386016846 8.240079879760742 10.04886054992676 7.865714073181152 9.479512214660645 7.606512546539307 C 8.910163879394531 7.347311019897461 8.293281555175781 7.208896636962891 7.667769908905029 7.199999809265137 C 7.043233394622803 7.208670139312744 6.427237987518311 7.346399784088135 5.858478546142578 7.604535579681396 C 5.289719104766846 7.862671375274658 4.780486583709717 8.235635757446289 4.362770080566406 8.699999809265137 C 4.336616992950439 8.732362747192383 4.303556442260742 8.758466720581055 4.266009330749512 8.776398658752441 C 4.228462219238281 8.794330596923828 4.187379360198975 8.803637504577637 4.145770072937012 8.803637504577637 C 4.104160785675049 8.803637504577637 4.063077926635742 8.794330596923828 4.025530815124512 8.776398658752441 C 3.987983703613281 8.758466720581055 3.954923152923584 8.732362747192383 3.928770065307617 8.699999809265137 L 2.768769979476929 7.315000057220459 C 2.706062793731689 7.238220691680908 2.671810626983643 7.142132759094238 2.671810626983643 7.043000221252441 C 2.671810626983643 6.943867683410645 2.706062793731689 6.847779273986816 2.768769979476929 6.770999908447266 C 3.379574060440063 6.068788051605225 4.131803035736084 5.503499984741211 4.976210117340088 5.112143039703369 C 5.820617198944092 4.720786094665527 6.738160610198975 4.512186050415039 7.668770313262939 4.5 C 8.599499702453613 4.512624740600586 9.517075538635254 4.721620559692383 10.36146450042725 5.113313674926758 C 11.20585346221924 5.505006790161133 11.95802688598633 6.07056999206543 12.56877040863037 6.77299976348877 C 12.63147735595703 6.84977912902832 12.66573047637939 6.945867538452148 12.66573047637939 7.045000076293945 C 12.66573047637939 7.144132614135742 12.63147735595703 7.240220546722412 12.56877040863037 7.316999912261963 L 11.40977096557617 8.699999809265137 C 11.38325977325439 8.732630729675293 11.34990310668945 8.759037971496582 11.31205940246582 8.777355194091797 C 11.27421569824219 8.795672416687012 11.23281002044678 8.805450439453125 11.19077014923096 8.805999755859375 L 11.19077014923096 8.805999755859375 Z M 13.85977077484131 5.624000072479248 C 13.81883335113525 5.623874187469482 13.77841091156006 5.614867687225342 13.74129199981689 5.597603321075439 C 13.70417308807373 5.580338954925537 13.67124271392822 5.555226802825928 13.64477062225342 5.52400016784668 C 12.90781497955322 4.653919219970703 11.99310398101807 3.951717376708984 10.9621467590332 3.464612722396851 C 9.93118953704834 2.977508068084717 8.80788516998291 2.716793537139893 7.667769908905029 2.700000047683716 C 6.527806282043457 2.716221570968628 5.404520988464355 2.976274013519287 4.373409748077393 3.462679862976074 C 3.34229850769043 3.949085712432861 2.427252292633057 4.650574207305908 1.689770102500916 5.519999980926514 C 1.664071559906006 5.553214550018311 1.631107211112976 5.580102443695068 1.593405365943909 5.598601341247559 C 1.555703520774841 5.617100238800049 1.514265775680542 5.626718044281006 1.472270131111145 5.626718044281006 C 1.430274486541748 5.626718044281006 1.388836622238159 5.617100238800049 1.351134777069092 5.598601341247559 C 1.313432931900024 5.580102443695068 1.280468583106995 5.553214550018311 1.254770040512085 5.519999980926514 L 0.09477010369300842 4.131999969482422 C 0.03342462703585625 4.055379390716553 -9.367506770274758e-17 3.960152864456177 0 3.861999988555908 C -1.457167719820518e-16 3.76384711265564 0.03342462703585625 3.668620586395264 0.09477010369300842 3.592000007629395 C 1.025538802146912 2.485098838806152 2.18357515335083 1.591421365737915 3.490261554718018 0.9716381430625916 C 4.796947956085205 0.3518549799919128 6.221692085266113 0.0204766783863306 7.667769908905029 0 C 9.113386154174805 0.02064345590770245 10.53763484954834 0.3521116375923157 11.84381103515625 0.9718981981277466 C 13.14998722076416 1.591684818267822 14.30750560760498 2.485276699066162 15.23777103424072 3.592000007629395 C 15.29911613464355 3.668620586395264 15.33254051208496 3.76384711265564 15.33254051208496 3.861999988555908 C 15.33254051208496 3.960152864456177 15.29911613464355 4.055379390716553 15.23777103424072 4.131999969482422 L 14.07977104187012 5.514999866485596 C 14.05344295501709 5.548232078552246 14.02003192901611 5.575171947479248 13.98197269439697 5.593855381011963 C 13.94391345977783 5.612538814544678 13.90216541290283 5.622495651245117 13.85977077484131 5.623000144958496 L 13.85977077484131 5.624000072479248 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eydtws =
    '<svg viewBox="289.1 18.3 17.0 12.7" ><path transform="translate(289.11, 18.34)" d="M 16.00326156616211 12.66699981689453 L 15.00326061248779 12.66699981689453 C 14.71422386169434 12.63979339599609 14.44744110107422 12.50013160705566 14.2603931427002 12.27810573577881 C 14.07334518432617 12.05607986450195 13.98100280761719 11.76945972442627 14.00326061248779 11.47999954223633 L 14.00326061248779 1.187000036239624 C 13.98100280761719 0.8975398540496826 14.07334518432617 0.6109204292297363 14.2603931427002 0.3888942897319794 C 14.44744110107422 0.1668681800365448 14.71422386169434 0.02720663137733936 15.00326061248779 1.665334536937735e-16 L 16.00326156616211 0 C 16.29229927062988 0.02720663137733936 16.55908012390137 0.1668681800365448 16.74612808227539 0.3888942897319794 C 16.93317604064941 0.6109204292297363 17.02552032470703 0.8975398540496826 17.00326156616211 1.187000036239624 L 17.00326156616211 11.47900009155273 C 17.02579498291016 11.76862525939941 16.9335765838623 12.05550098419189 16.74650192260742 12.27774715423584 C 16.55942726135254 12.49999332427979 16.2924861907959 12.63979625701904 16.00326156616211 12.66699981689453 L 16.00326156616211 12.66699981689453 Z M 11.33626079559326 12.66699981689453 L 10.33626079559326 12.66699981689453 C 10.0472240447998 12.63979339599609 9.780441284179688 12.50013160705566 9.593393325805664 12.27810573577881 C 9.406345367431641 12.05607986450195 9.314002990722656 11.76945972442627 9.336260795593262 11.47999954223633 L 9.336260795593262 3.959000110626221 C 9.314002990722656 3.669539928436279 9.406345367431641 3.382920503616333 9.593393325805664 3.160894393920898 C 9.780441284179688 2.938868284225464 10.0472240447998 2.799206733703613 10.33626079559326 2.772000074386597 L 11.33626079559326 2.772000074386597 C 11.62529754638672 2.799206733703613 11.89207935333252 2.938868284225464 12.07912731170654 3.160894393920898 C 12.26617527008057 3.382920503616333 12.35851860046387 3.669539928436279 12.33626079559326 3.959000110626221 L 12.33626079559326 11.47999954223633 C 12.35853099822998 11.76930236816406 12.26632404327393 12.05578422546387 12.07948589324951 12.27778244018555 C 11.8926477432251 12.49978065490723 11.62611675262451 12.63954734802246 11.33726024627686 12.66699981689453 L 11.33626079559326 12.66699981689453 Z M 6.669260501861572 12.66699981689453 L 5.669260501861572 12.66699981689453 C 5.380223274230957 12.63979339599609 5.113441467285156 12.50013160705566 4.926393508911133 12.27810573577881 C 4.739345550537109 12.05607986450195 4.647002696990967 11.76945972442627 4.669260501861572 11.47999954223633 L 4.669260501861572 6.729000091552734 C 4.647002696990967 6.439539909362793 4.739345550537109 6.152920722961426 4.926393508911133 5.930894374847412 C 5.113441467285156 5.708868026733398 5.380223274230957 5.569206237792969 5.669260501861572 5.541999816894531 L 6.669260501861572 5.541999816894531 C 6.958297729492188 5.569206237792969 7.225079536437988 5.708868026733398 7.412127494812012 5.930894374847412 C 7.599175453186035 6.152920722961426 7.691518306732178 6.439539909362793 7.669260501861572 6.729000091552734 L 7.669260501861572 11.47999954223633 C 7.691518306732178 11.76945972442627 7.599175453186035 12.05607986450195 7.412127494812012 12.27810573577881 C 7.225079536437988 12.50013160705566 6.958297729492188 12.63979339599609 6.669260501861572 12.66699981689453 L 6.669260501861572 12.66699981689453 Z M 2.003260612487793 12.66699981689453 L 1.003260731697083 12.66699981689453 C 0.7142237424850464 12.63979339599609 0.4474418163299561 12.50013160705566 0.2603936791419983 12.27810573577881 C 0.07334555685520172 12.05607986450195 -0.01899724081158638 11.76945972442627 0.003260678611695766 11.47999954223633 L 0.003260678611695766 9.100000381469727 C -0.01791370287537575 8.811094284057617 0.07489818334579468 8.525383949279785 0.2618142068386078 8.304075241088867 C 0.4487302303314209 8.082766532897949 0.7148842811584473 7.943460941314697 1.003260731697083 7.915999889373779 L 2.003260612487793 7.915999889373779 C 2.291636943817139 7.943460941314697 2.557790994644165 8.082766532897949 2.744707107543945 8.304075241088867 C 2.931623220443726 8.525383949279785 3.024435043334961 8.811094284057617 3.003260612487793 9.100000381469727 L 3.003260612487793 11.47500038146973 C 3.026895523071289 11.76528453826904 2.935181379318237 12.05318927764893 2.747995376586914 12.2763147354126 C 2.560809373855591 12.49944019317627 2.293233633041382 12.63980960845947 2.003260612487793 12.66699981689453 L 2.003260612487793 12.66699981689453 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_e9upx7 =
    '<svg viewBox="0.0 0.0 375.0 44.0" ><path  d="M 0 0 L 375 0 L 375 44 L 0 44 L 0 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_q8wv2x =
    '<svg viewBox="17.0 58.0 10.0 20.0" ><path transform="translate(17.0, 58.0)" d="M 10 0 L 0 10 L 10 20" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="butt" stroke-linejoin="bevel" /></svg>';
const String _svg_clvt5t =
    '<svg viewBox="343.0 108.0 16.0 16.0" ><path transform="translate(343.0, 108.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_5wgtiu =
    '<svg viewBox="38.3 147.8 30.4 12.2" ><path transform="translate(38.3, 147.84)" d="M 3.040860176086426 0 L 27.36774253845215 0 C 29.04716300964355 0 30.40860366821289 1.361439228057861 30.40860366821289 3.040859937667847 L 30.40860366821289 9.122580528259277 C 30.40860366821289 10.80200099945068 29.04716300964355 12.16343975067139 27.36774253845215 12.16343975067139 L 3.040860176086426 12.16343975067139 C 1.361439347267151 12.16343975067139 0 10.80200099945068 0 9.122580528259277 L 0 3.040859937667847 C 0 1.361439228057861 1.361439347267151 0 3.040860176086426 0 Z" fill="#4ba541" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mabpwd =
    '<svg viewBox="44.4 156.3 1.0 1.0" ><path transform="translate(44.38, 156.33)" d="M 0 0 L 0.01266953907907009 0" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_70a8si =
    '<svg viewBox="38.3 132.0 30.4 12.2" ><path transform="translate(38.3, 132.0)" d="M 3.040860414505005 0 L 27.36774253845215 0 C 29.04716491699219 0 30.40860366821289 1.361439228057861 30.40860366821289 3.040859937667847 L 30.40860366821289 9.122579574584961 C 30.40860366821289 10.80200004577637 29.04716491699219 12.16343975067139 27.36774253845215 12.16343975067139 L 3.040860414505005 12.16343975067139 C 1.36143946647644 12.16343975067139 0 10.80200004577637 0 9.122579574584961 L 0 3.040859937667847 C 0 1.361439228057861 1.36143946647644 0 3.040860414505005 0 Z" fill="#4ba541" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jd1l9d =
    '<svg viewBox="44.4 138.1 1.0 1.0" ><path transform="translate(44.38, 138.08)" d="M 0 0 L 0.01266953907907009 0" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_chss76 =
    '<svg viewBox="326.4 242.0 16.0 16.0" ><path transform="translate(326.45, 242.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7trq1c =
    '<svg viewBox="57.1 241.6 7.1 16.9" ><path transform="translate(57.1, 241.56)" d="M 5.988861083984375 0.34589883685112 C 5.318454265594482 -0.07643613219261169 4.49444580078125 -0.113796554505825 3.792038679122925 0.2435638159513474 L 1.420814514160156 1.440721035003662 C 0.5440055727958679 1.882548451423645 0 2.775949478149414 0 3.770061016082764 L 0 13.10366344451904 C 0 14.09777545928955 0.5440055727958679 14.98955154418945 1.420814514160156 15.4346284866333 L 3.790438890457153 16.63016128540039 C 4.11204195022583 16.79584693908691 4.456045627593994 16.87544059753418 4.800048828125 16.87544059753418 C 5.212852954864502 16.87544059753418 5.622457504272461 16.75848579406738 5.988861083984375 16.52945137023926 C 6.659267902374268 16.10873985290527 7.059271812438965 15.3794002532959 7.059271812438965 14.58021259307861 L 7.059271812438965 2.296761751174927 C 7.059271812438965 1.497573971748352 6.659267902374268 0.7682337760925293 5.988861083984375 0.34589883685112 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fczvms =
    '<svg viewBox="32.0 238.0 22.4 24.0" ><path transform="translate(32.0, 238.0)" d="M 15.8481559753418 24 L 6.580864429473877 24 C 2.705626249313354 24 0 21.32791900634766 0 17.50253677368164 L 0 6.497461795806885 C 0 2.670456647872925 2.705626249313354 0 6.580864429473877 0 L 15.8481559753418 0 C 19.7233943939209 0 22.42901992797852 2.670456647872925 22.42901992797852 6.497461795806885 L 22.42901992797852 17.50253677368164 C 22.42901992797852 21.32791900634766 19.7233943939209 24 15.8481559753418 24 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jtt9tu =
    '<svg viewBox="327.4 318.0 16.0 16.0" ><path transform="translate(327.45, 318.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rso07w =
    '<svg viewBox="58.1 317.6 7.1 16.9" ><path transform="translate(58.1, 317.56)" d="M 5.988861083984375 0.34589883685112 C 5.318454265594482 -0.07643613219261169 4.49444580078125 -0.113796554505825 3.792038679122925 0.2435638159513474 L 1.420814514160156 1.440721035003662 C 0.5440055727958679 1.882548451423645 0 2.775949478149414 0 3.770061016082764 L 0 13.10366344451904 C 0 14.09777545928955 0.5440055727958679 14.98955154418945 1.420814514160156 15.4346284866333 L 3.790438890457153 16.63016128540039 C 4.11204195022583 16.79584693908691 4.456045627593994 16.87544059753418 4.800048828125 16.87544059753418 C 5.212852954864502 16.87544059753418 5.622457504272461 16.75848579406738 5.988861083984375 16.52945137023926 C 6.659267902374268 16.10873985290527 7.059271812438965 15.3794002532959 7.059271812438965 14.58021259307861 L 7.059271812438965 2.296761751174927 C 7.059271812438965 1.497573971748352 6.659267902374268 0.7682337760925293 5.988861083984375 0.34589883685112 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_b8s8ym =
    '<svg viewBox="33.0 314.0 22.4 24.0" ><path transform="translate(33.0, 314.0)" d="M 15.8481559753418 24 L 6.580864429473877 24 C 2.705626249313354 24 0 21.32791900634766 0 17.50253677368164 L 0 6.497461795806885 C 0 2.670456647872925 2.705626249313354 0 6.580864429473877 0 L 15.8481559753418 0 C 19.7233943939209 0 22.42901992797852 2.670456647872925 22.42901992797852 6.497461795806885 L 22.42901992797852 17.50253677368164 C 22.42901992797852 21.32791900634766 19.7233943939209 24 15.8481559753418 24 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_336tvi =
    '<svg viewBox="326.4 394.0 16.0 16.0" ><path transform="translate(326.45, 394.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ciszkc =
    '<svg viewBox="57.1 393.6 7.1 16.9" ><path transform="translate(57.1, 393.56)" d="M 5.988861083984375 0.34589883685112 C 5.318454265594482 -0.07643613219261169 4.49444580078125 -0.113796554505825 3.792038679122925 0.2435638159513474 L 1.420814514160156 1.440721035003662 C 0.5440055727958679 1.882548451423645 0 2.775949478149414 0 3.770061016082764 L 0 13.10366344451904 C 0 14.09777545928955 0.5440055727958679 14.98955154418945 1.420814514160156 15.4346284866333 L 3.790438890457153 16.63016128540039 C 4.11204195022583 16.79584693908691 4.456045627593994 16.87544059753418 4.800048828125 16.87544059753418 C 5.212852954864502 16.87544059753418 5.622457504272461 16.75848579406738 5.988861083984375 16.52945137023926 C 6.659267902374268 16.10873985290527 7.059271812438965 15.3794002532959 7.059271812438965 14.58021259307861 L 7.059271812438965 2.296761751174927 C 7.059271812438965 1.497573971748352 6.659267902374268 0.7682337760925293 5.988861083984375 0.34589883685112 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_itxyos =
    '<svg viewBox="32.0 390.0 22.4 24.0" ><path transform="translate(32.0, 390.0)" d="M 15.8481559753418 24 L 6.580864429473877 24 C 2.705626249313354 24 0 21.32791900634766 0 17.50253677368164 L 0 6.497461795806885 C 0 2.670456647872925 2.705626249313354 0 6.580864429473877 0 L 15.8481559753418 0 C 19.7233943939209 0 22.42901992797852 2.670456647872925 22.42901992797852 6.497461795806885 L 22.42901992797852 17.50253677368164 C 22.42901992797852 21.32791900634766 19.7233943939209 24 15.8481559753418 24 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7abpku =
    '<svg viewBox="327.4 470.0 16.0 16.0" ><path transform="translate(327.45, 470.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_n3mqow =
    '<svg viewBox="58.1 469.6 7.1 16.9" ><path transform="translate(58.1, 469.56)" d="M 5.988861083984375 0.34589883685112 C 5.318454265594482 -0.07643613219261169 4.49444580078125 -0.113796554505825 3.792038679122925 0.2435638159513474 L 1.420814514160156 1.440721035003662 C 0.5440055727958679 1.882548451423645 0 2.775949478149414 0 3.770061016082764 L 0 13.10366344451904 C 0 14.09777545928955 0.5440055727958679 14.98955154418945 1.420814514160156 15.4346284866333 L 3.790438890457153 16.63016128540039 C 4.11204195022583 16.79584693908691 4.456045627593994 16.87544059753418 4.800048828125 16.87544059753418 C 5.212852954864502 16.87544059753418 5.622457504272461 16.75848579406738 5.988861083984375 16.52945137023926 C 6.659267902374268 16.10873985290527 7.059271812438965 15.3794002532959 7.059271812438965 14.58021259307861 L 7.059271812438965 2.296761751174927 C 7.059271812438965 1.497573971748352 6.659267902374268 0.7682337760925293 5.988861083984375 0.34589883685112 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v5h61q =
    '<svg viewBox="33.0 466.0 22.4 24.0" ><path transform="translate(33.0, 466.0)" d="M 15.8481559753418 24 L 6.580864429473877 24 C 2.705626249313354 24 0 21.32791900634766 0 17.50253677368164 L 0 6.497461795806885 C 0 2.670456647872925 2.705626249313354 0 6.580864429473877 0 L 15.8481559753418 0 C 19.7233943939209 0 22.42901992797852 2.670456647872925 22.42901992797852 6.497461795806885 L 22.42901992797852 17.50253677368164 C 22.42901992797852 21.32791900634766 19.7233943939209 24 15.8481559753418 24 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_oinww2 =
    '<svg viewBox="327.4 546.0 16.0 16.0" ><path transform="translate(327.45, 546.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ixdl5q =
    '<svg viewBox="58.1 545.6 7.1 16.9" ><path transform="translate(58.1, 545.56)" d="M 5.988861083984375 0.34589883685112 C 5.318454265594482 -0.07643613219261169 4.49444580078125 -0.113796554505825 3.792038679122925 0.2435638159513474 L 1.420814514160156 1.440721035003662 C 0.5440055727958679 1.882548451423645 0 2.775949478149414 0 3.770061016082764 L 0 13.10366344451904 C 0 14.09777545928955 0.5440055727958679 14.98955154418945 1.420814514160156 15.4346284866333 L 3.790438890457153 16.63016128540039 C 4.11204195022583 16.79584693908691 4.456045627593994 16.87544059753418 4.800048828125 16.87544059753418 C 5.212852954864502 16.87544059753418 5.622457504272461 16.75848579406738 5.988861083984375 16.52945137023926 C 6.659267902374268 16.10873985290527 7.059271812438965 15.3794002532959 7.059271812438965 14.58021259307861 L 7.059271812438965 2.296761751174927 C 7.059271812438965 1.497573971748352 6.659267902374268 0.7682337760925293 5.988861083984375 0.34589883685112 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cu7yoy =
    '<svg viewBox="33.0 542.0 22.4 24.0" ><path transform="translate(33.0, 542.0)" d="M 15.8481559753418 24 L 6.580864429473877 24 C 2.705626249313354 24 0 21.32791900634766 0 17.50253677368164 L 0 6.497461795806885 C 0 2.670456647872925 2.705626249313354 0 6.580864429473877 0 L 15.8481559753418 0 C 19.7233943939209 0 22.42901992797852 2.670456647872925 22.42901992797852 6.497461795806885 L 22.42901992797852 17.50253677368164 C 22.42901992797852 21.32791900634766 19.7233943939209 24 15.8481559753418 24 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
