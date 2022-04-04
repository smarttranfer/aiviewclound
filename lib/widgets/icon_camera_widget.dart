import 'package:adobe_xd/pinned.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconCameraWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.liveCamList);
        },
        child: Pinned.fromPins(
          Pin(size: 17.0, end: 16.9),
          Pin(size: 20.2, middle: 0.5),
          child:
              // Adobe XD layer: 'Group 5522' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 9.4, end: 0.0),
                child:
                    // Adobe XD layer: 'Group 5350' (group)
                    Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 4.1),
                      Pin(start: 0.0, end: 0.0),
                      child:
                          // Adobe XD layer: 'Rectangle 34' (group)
                          Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(start: 0.0, end: 0.0),
                            child:
                                // Adobe XD layer: 'Vector' (shape)
                                SvgPicture.string(
                              _svg_b8ehgx,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Pinned.fromPins(
                            Pin(start: 0.7, end: 0.7),
                            Pin(start: 0.8, end: 0.8),
                            child:
                                // Adobe XD layer: 'Vector' (shape)
                                SvgPicture.string(
                              _svg_myedb,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(size: 2.3, end: 0.0),
                      Pin(start: 1.2, end: 1.3),
                      child:
                          // Adobe XD layer: 'Path 893' (shape)
                          SvgPicture.string(
                        _svg_w47c6k,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 9.4, start: 0.0),
                child:
                    // Adobe XD layer: 'Group 5521' (group)
                    Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 4.1),
                      Pin(start: 0.0, end: 0.0),
                      child:
                          // Adobe XD layer: 'Rectangle 34' (group)
                          Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(start: 0.0, end: 0.0),
                            child:
                                // Adobe XD layer: 'Vector' (shape)
                                SvgPicture.string(
                              _svg_rrrnfe,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Pinned.fromPins(
                            Pin(start: 0.7, end: 0.7),
                            Pin(start: 0.8, end: 0.8),
                            child:
                                // Adobe XD layer: 'Vector' (shape)
                                SvgPicture.string(
                              _svg_myedb,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(size: 2.3, end: 0.0),
                      Pin(start: 1.2, end: 1.3),
                      child:
                          // Adobe XD layer: 'Path 893' (shape)
                          SvgPicture.string(
                        _svg_w47c6k,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

const String _svg_myedb =
    '<svg viewBox="341.8 69.5 11.3 7.9" ><path transform="translate(341.84, 69.53)" d="M 2.244013786315918 0 L 9.101719856262207 0 C 10.34105491638184 0 11.34573364257812 1.00735878944397 11.34573364257812 2.249998807907104 L 11.34573364257812 5.672996997833252 C 11.34573364257812 6.915637493133545 10.34105491638184 7.922996520996094 9.101719856262207 7.922996520996094 L 2.244013786315918 7.922996520996094 C 1.004679083824158 7.922996520996094 0 6.915637493133545 0 5.672996997833252 L 0 2.249998807907104 C 0 1.00735878944397 1.004679083824158 0 2.244013786315918 0 Z" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rrrnfe =
    '<svg viewBox="341.1 58.0 12.8 9.4" ><path transform="translate(341.09, 58.0)" d="M 2.992023706436157 0 L 9.849742889404297 0 C 11.5021915435791 0 12.84176635742188 1.343146324157715 12.84176635742188 3.000001192092896 L 12.84176635742188 6.423002243041992 C 12.84176635742188 8.07985782623291 11.5021915435791 9.423004150390625 9.849742889404297 9.423004150390625 L 2.992023706436157 9.423004150390625 C 1.339574694633484 9.423004150390625 0 8.07985782623291 0 6.423002243041992 L 0 3.000001192092896 C 0 1.343146324157715 1.339574694633484 0 2.992023706436157 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_b8ehgx =
    '<svg viewBox="341.1 68.8 12.8 9.4" ><path transform="translate(341.09, 68.78)" d="M 2.992023706436157 0 L 9.849742889404297 0 C 11.5021915435791 0 12.84176635742188 1.343145132064819 12.84176635742188 2.999998807907104 L 12.84176635742188 6.42299747467041 C 12.84176635742188 8.079851150512695 11.5021915435791 9.422996520996094 9.849742889404297 9.422996520996094 L 2.992023706436157 9.422996520996094 C 1.339574694633484 9.422996520996094 0 8.079851150512695 0 6.42299747467041 L 0 2.999998807907104 C 0 1.343145132064819 1.339574694633484 0 2.992023706436157 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w47c6k =
    '<svg viewBox="355.8 70.0 2.3 6.9" ><path transform="translate(355.76, 69.98)" d="M 0 2.8590087890625 L 0 4.6199951171875 L 2.306854248046875 6.9130859375 L 2.306854248046875 0 L 0 2.8590087890625 Z" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
