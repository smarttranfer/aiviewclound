import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/wifi_icon_notfound_widget.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchDevice extends StatelessWidget {
  SearchDevice({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Không tìm thấy thiế…' (shape)
                      Container(
                    color: const Color(0xff212529),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      HeaderWidget(
                          headerText: AppLocalizations.of(context)
                              .translate('search_device')),
                      Pinned.fromPins(
                        Pin(start: 16.0, end: 16.0),
                        Pin(size: 304.0, start: 108.0),
                        child:
                            // Adobe XD layer: 'Rectangle 1986' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.deviceList);
                          },
                          child: Pinned.fromPins(
                            Pin(start: 16.0, end: 16.0),
                            Pin(size: 48.0, middle: 0.5602),
                            child:
                                // Adobe XD layer: 'Group 6210' (group)
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
                                  Pin(size: 155.0, middle: 0.5),
                                  Pin(size: 20.0, middle: 0.5),
                                  child:
                                      // Adobe XD layer: 'Quét lại' (text)
                                      SingleChildScrollView(
                                          child: Text(
                                    'Quét lại',
                                    style: TextStyle(
                                      fontFamily: 'SFProDisplay-Regular',
                                      fontSize: 17,
                                      color: const Color(0xffffffff),
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              ],
                            ),
                          )),
                      Pinned.fromPins(
                        Pin(size: 17.9, end: 16.1),
                        Pin(size: 20.0, start: 58.0),
                        child:
                            // Adobe XD layer: 'Group 6234' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 4.3, end: 0.0),
                              Pin(size: 5.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Vector 14' (shape)
                                  SvgPicture.string(
                                _svg_ojk12k,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.7),
                              Pin(start: 0.0, end: 2.9),
                              child:
                                  // Adobe XD layer: 'Ellipse 117' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  border: Border.all(
                                      width: 1.5,
                                      color: const Color(0xffffffff)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 17.0, end: 16.0),
                        Pin(size: 191.0, middle: 0.2457),
                        child:
                            // Adobe XD layer: 'Group 6479' (group)
                            Stack(
                          children: <Widget>[
                            WifiIconNotFound(),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(size: 19.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Không tìm thấy thiế…' (text)
                                  Text(
                                'Không tìm thấy thiết bị trong LAN',
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay-Regular',
                                  fontSize: 14,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ojk12k =
    '<svg viewBox="13.6 15.0 4.3 5.0" ><path transform="translate(13.57, 15.0)" d="M 0 0 L 4.285714149475098 5" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
