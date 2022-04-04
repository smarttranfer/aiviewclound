import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveCamList extends StatelessWidget {
  LiveCamList({
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
                      // Adobe XD layer: 'Xem trực tiếp  danh…' (shape)
                      Container(
                    color: const Color(0xff212529),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 16.0, end: 16.0),
                        Pin(size: 64.0, middle: 0.2193),
                        child:
                            // Adobe XD layer: 'Rectangle 1863' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 48.0, start: 44.0),
                        child:
                            // Adobe XD layer: 'Rectangle 1821' (shape)
                            Container(
                          color: const Color(0xff212529),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 172.0, middle: 0.5074),
                        Pin(size: 24.0, start: 56.0),
                        child:
                            // Adobe XD layer: 'Danh sách Camera' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Danh sách Camera',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Bold',
                            fontSize: 20,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 44.0, start: 0.0),
                        child:
                            // Adobe XD layer: 'Group 6193 1' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Group 6193 1 (Backg…' (shape)
                                  Container(),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Group 6193 1' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Group 6193' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Rectangle 1814' (shape)
                                              SvgPicture.string(
                                            _svg_82ykdu,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 33.3, end: 19.2),
                                          Pin(size: 18.0, middle: 0.5),
                                          child:
                                              // Adobe XD layer: 'Group 6194' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(size: 40.0, start: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: '13:02' (text)
                                                    Text(
                                                  '13:02',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'SFProText-Regular',
                                                    fontSize: 15,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(size: 66.7, end: 0.0),
                                                Pin(size: 13.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Group 6192' (group)
                                                    Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(size: 24.3, end: 0.0),
                                                      Pin(start: 1.0, end: 0.7),
                                                      child:
                                                          // Adobe XD layer: 'Battery' (group)
                                                          Stack(
                                                        children: <Widget>[
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 0.0,
                                                                end: 2.3),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child:
                                                                // Adobe XD layer: 'Border' (shape)
                                                                SvgPicture
                                                                    .string(
                                                              _svg_41gr65,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                size: 1.3,
                                                                end: 0.0),
                                                            Pin(
                                                                size: 4.0,
                                                                middle: 0.5001),
                                                            child:
                                                                // Adobe XD layer: 'Cap' (shape)
                                                                SvgPicture
                                                                    .string(
                                                              _svg_mu6eai,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                size: 18.0,
                                                                start: 2.0),
                                                            Pin(
                                                                start: 2.0,
                                                                end: 2.0),
                                                            child:
                                                                // Adobe XD layer: 'Capacity' (shape)
                                                                SvgPicture
                                                                    .string(
                                                              _svg_n8yw48,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 15.3,
                                                          middle: 0.4286),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child:
                                                          // Adobe XD layer: 'Wifi' (shape)
                                                          SvgPicture.string(
                                                        _svg_lxntdx,
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 17.0,
                                                          start: 0.0),
                                                      Pin(start: 0.3, end: 0.0),
                                                      child:
                                                          // Adobe XD layer: 'Cellular Connection' (shape)
                                                          SvgPicture.string(
                                                        _svg_ymifyt,
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                        fit: BoxFit.fill,
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
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(size: 48.0, end: -48.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1820' (shape)
                                        Container(
                                      color: const Color(0xff958383),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Group 6193 1 (Backg…' (shape)
                                        Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: -1.0),
                        Pin(size: 34.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'Group 6208' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Group 1' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1' (shape)
                                        Container(
                                      color: const Color(0xff212529),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 135.4, middle: 0.5),
                              Pin(size: 6.0, middle: 0.5),
                              child:
                                  // Adobe XD layer: 'Rectangle 2' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 10.0, start: 17.0),
                        Pin(size: 20.0, start: 58.0),
                        child:
                            // Adobe XD layer: 'Vector 1' (shape)
                            SvgPicture.string(
                          _svg_8sg4sd,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 16.0, end: 16.0),
                        Pin(size: 48.0, start: 100.0),
                        child:
                            // Adobe XD layer: 'Rectangle 1861' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 17.0, end: 15.0),
                        Pin(size: 64.0, middle: 0.4118),
                        child:
                            // Adobe XD layer: 'Rectangle 1868' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 15.0, end: 17.0),
                        Pin(size: 64.0, middle: 0.3168),
                        child:
                            // Adobe XD layer: 'Rectangle 1865' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 17.0, end: 15.0),
                        Pin(size: 64.0, middle: 0.508),
                        child:
                            // Adobe XD layer: 'Rectangle 1869' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 17.0, end: 15.0),
                        Pin(size: 64.0, middle: 0.6043),
                        child:
                            // Adobe XD layer: 'Rectangle 1874' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xff2b2f33),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 191.0, start: 55.0),
                        Pin(size: 17.0, start: 116.0),
                        child:
                            // Adobe XD layer: 'Tìm kiếm theo tên t…' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Tìm kiếm theo tên thiết bị, số seri',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Regular',
                            fontSize: 14,
                            color: const Color(0xff818181),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(size: 14.3, start: 32.0),
                        Pin(size: 16.0, start: 116.0),
                        child:
                            // Adobe XD layer: 'Group 6234' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 3.4, end: 0.0),
                              Pin(size: 4.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Vector 14' (shape)
                                  SvgPicture.string(
                                _svg_ybt8li,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.6),
                              Pin(start: 0.0, end: 2.3),
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
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.3194),
                        child:
                            // Adobe XD layer: 'Rectangle 1866' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0xff393939),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.5079),
                        child:
                            // Adobe XD layer: 'Rectangle 1871' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0xff393939),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, end: 32.0),
                        Pin(size: 16.0, middle: 0.2362),
                        child:
                            // Adobe XD layer: 'Rectangle 1864' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                width: 1.5, color: const Color(0xff818181)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, end: 31.0),
                        Pin(size: 16.0, middle: 0.4171),
                        child:
                            // Adobe XD layer: 'Rectangle 1872' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                width: 1.5, color: const Color(0xff818181)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, end: 31.0),
                        Pin(size: 16.0, middle: 0.5075),
                        child:
                            // Adobe XD layer: 'Rectangle 1873' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                width: 1.5, color: const Color(0xffb2b2b2)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, end: 31.0),
                        Pin(size: 16.0, middle: 0.598),
                        child:
                            // Adobe XD layer: 'Rectangle 1876' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                width: 1.5, color: const Color(0xff818181)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 84.0, middle: 0.3436),
                        Pin(size: 20.0, middle: 0.2348),
                        child:
                            // Adobe XD layer: 'Camera 01' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Camera 01',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Bold',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(size: 84.0, middle: 0.3471),
                        Pin(size: 20.0, middle: 0.4167),
                        child:
                            // Adobe XD layer: 'Camera 01' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Camera 01',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Bold',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(size: 84.0, middle: 0.3471),
                        Pin(size: 20.0, middle: 0.3258),
                        child:
                            // Adobe XD layer: 'Camera 01' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Camera 01',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Bold',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(size: 84.0, middle: 0.3471),
                        Pin(size: 20.0, middle: 0.5076),
                        child:
                            // Adobe XD layer: 'Camera 01' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Camera 01',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Bold',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(size: 84.0, middle: 0.3471),
                        Pin(size: 20.0, middle: 0.5985),
                        child:
                            // Adobe XD layer: 'Camera 01' (text)
                            SingleChildScrollView(
                                child: Text(
                          'Camera 01',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay-Bold',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, start: 49.0),
                        Pin(size: 16.0, middle: 0.5075),
                        child:
                            // Adobe XD layer: 'padlock (1) 4' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 4 (Back…' (shape)
                                  Container(),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 4' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 1.3, end: 1.3),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_lseiy1,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.5),
                                    Pin(size: 5.7, middle: 0.7419),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_nldm84,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'padlock (1) 4 (Back…' (shape)
                                        Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, end: 31.0),
                        Pin(size: 16.0, middle: 0.3266),
                        child:
                            // Adobe XD layer: 'Group 6256' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1867' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xfffd7b38),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 6.0, middle: 0.5),
                              Pin(size: 4.0, middle: 0.5),
                              child:
                                  // Adobe XD layer: 'Vector 16' (shape)
                                  SvgPicture.string(
                                _svg_okr2xv,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, end: 31.0),
                        Pin(size: 16.0, middle: 0.5075),
                        child:
                            // Adobe XD layer: 'Group 6257' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1867' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xfffd7b38),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 6.0, middle: 0.5),
                              Pin(size: 4.0, middle: 0.5),
                              child:
                                  // Adobe XD layer: 'Vector 16' (shape)
                                  SvgPicture.string(
                                _svg_okr2xv,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.3194),
                        child:
                            // Adobe XD layer: 'Mask Group' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1862' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xff393939),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Mask Group' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: -2.0, end: -1.0),
                                    Pin(start: -3.0, end: -3.0),
                                    child:
                                        // Adobe XD layer: 'Image 4' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                              Container(
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1862' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xff393939),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 24.0),
                        Pin(size: 48.0, middle: 0.2251),
                        child:
                            // Adobe XD layer: 'Mask Group' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1862' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xff393939),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Mask Group' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: -2.0, end: -1.0),
                                    Pin(start: -3.0, end: -3.0),
                                    child:
                                        // Adobe XD layer: 'Image 4' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                              Container(
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1862' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xff393939),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.4136),
                        child:
                            // Adobe XD layer: 'Mask Group' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1862' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xff393939),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Mask Group' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: -2.0, end: -1.0),
                                    Pin(start: -3.0, end: -3.0),
                                    child:
                                        // Adobe XD layer: 'Image 4' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                              Container(
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1862' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xff393939),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.5079),
                        child:
                            // Adobe XD layer: 'Mask Group' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1862' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xff393939),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Mask Group' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: -2.0, end: -1.0),
                                    Pin(start: -3.0, end: -3.0),
                                    child:
                                        // Adobe XD layer: 'Image 4' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                              Container(
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1862' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xff393939),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.6021),
                        child:
                            // Adobe XD layer: 'Mask Group' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1862' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xff393939),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Mask Group' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: -2.0, end: -1.0),
                                    Pin(start: -3.0, end: -3.0),
                                    child:
                                        // Adobe XD layer: 'Image 4' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                              Container(
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Image 4' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Image 4 (Mask)' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Rectangle 1862' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xff393939),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                  color: const Color(0xfffd7b38),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 151.0, middle: 0.5),
                              Pin(size: 20.0, middle: 0.5),
                              child:
                                  // Adobe XD layer: 'Bắt đầu xem trực ti…' (text)
                                  SingleChildScrollView(
                                      child: Text(
                                'Bắt đầu xem trực tiếp',
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay-Regular',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              )),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.4136),
                        child:
                            // Adobe XD layer: 'Rectangle 1870' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0xcc393939),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, start: 49.0),
                        Pin(size: 16.0, middle: 0.4171),
                        child:
                            // Adobe XD layer: 'padlock (1) 3' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 3 (Back…' (shape)
                                  Container(),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 3' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 1.3, end: 1.3),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_pyzwg7,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.5),
                                    Pin(size: 5.7, middle: 0.7419),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_bnzn8,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'padlock (1) 3 (Back…' (shape)
                                        Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 25.0),
                        Pin(size: 48.0, middle: 0.6021),
                        child:
                            // Adobe XD layer: 'Rectangle 1875' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0xcc393939),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, start: 49.0),
                        Pin(size: 16.0, middle: 0.598),
                        child:
                            // Adobe XD layer: 'padlock (1) 5' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 5 (Back…' (shape)
                                  Container(),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 5' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 1.3, end: 1.3),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_pyzwg7,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.5),
                                    Pin(size: 5.7, middle: 0.7419),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_bnzn8,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'padlock (1) 5 (Back…' (shape)
                                        Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 64.0, start: 24.0),
                        Pin(size: 48.0, middle: 0.2251),
                        child:
                            // Adobe XD layer: 'Rectangle 1877' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0xcc393939),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 16.0, start: 48.0),
                        Pin(size: 16.0, middle: 0.2362),
                        child:
                            // Adobe XD layer: 'padlock (1) 1' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 1 (Back…' (shape)
                                  Container(),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'padlock (1) 1' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 1.3, end: 1.3),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_pyzwg7,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.5),
                                    Pin(size: 5.7, middle: 0.7419),
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child:
                                                    // Adobe XD layer: 'Vector' (shape)
                                                    SvgPicture.string(
                                                  _svg_bnzn8,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'padlock (1) 1 (Back…' (shape)
                                        Container(),
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
          ),
        ],
      ),
    );
  }
}

const String _svg_41gr65 =
    '<svg viewBox="0.0 0.0 22.0 11.3" ><path  d="M 19.33300018310547 0 C 20.80594444274902 0 22 1.194056630134583 22 2.66700005531311 L 22 8.666000366210938 C 22 10.13894367218018 20.80594444274902 11.33300018310547 19.33300018310547 11.33300018310547 L 2.66700005531311 11.33300018310547 C 1.194056630134583 11.33300018310547 0 10.13894367218018 0 8.666000366210938 L 0 2.66700005531311 C 0 1.194056630134583 1.194056630134583 0 2.66700005531311 0 L 19.33300018310547 0 Z" fill="#ffffff" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_mu6eai =
    '<svg viewBox="23.0 3.7 1.3 4.0" ><path transform="translate(23.0, 3.67)" d="M 0 2.220446049250313e-16 L 0 4 C 0.3935926258563995 3.834296226501465 0.7295427322387695 3.55614161491394 0.9657710194587708 3.200376033782959 C 1.201999306678772 2.844610452651978 1.32800304889679 2.427051544189453 1.327999949455261 2 C 1.32800304889679 1.572948575019836 1.201999306678772 1.155389547348022 0.9657710194587708 0.7996240258216858 C 0.7295427322387695 0.4438585042953491 0.3935926258563995 0.1657038182020187 2.220446049250313e-16 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_n8yw48 =
    '<svg viewBox="2.0 2.0 18.0 7.3" ><path transform="translate(2.0, 2.0)" d="M 16.66699981689453 0 C 17.40319442749023 0 18 0.5968043804168701 18 1.33299994468689 L 18 6 C 18 6.73619556427002 17.40319442749023 7.333000183105469 16.66699981689453 7.333000183105469 L 1.33299994468689 7.333000183105469 C 0.5968043804168701 7.333000183105469 0 6.73619556427002 0 6 L 0 1.33299994468689 C 0 0.5968043804168701 0.5968043804168701 0 1.33299994468689 0 L 16.66699981689453 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_lxntdx =
    '<svg viewBox="22.0 0.0 15.3 13.0" ><path transform="translate(22.0, 0.0)" d="M 7.544700145721436 12.96990013122559 C 7.50600004196167 12.95100021362305 7.472700119018555 12.92310047149658 7.445700168609619 12.88980007171631 L 5.439599990844727 10.50030040740967 C 5.377500057220459 10.42290019989014 5.344200134277344 10.32660007476807 5.346000194549561 10.22760009765625 C 5.347800254821777 10.12860012054443 5.384700298309326 10.03320026397705 5.44950008392334 9.959400177001953 C 5.737500190734863 9.660600662231445 6.082200050354004 9.422100067138672 6.462900161743164 9.257400512695312 C 6.843600273132324 9.093600273132324 7.253100395202637 9.005400657653809 7.668000221252441 9 C 8.082900047302246 9.005400657653809 8.492400169372559 9.093600273132324 8.873100280761719 9.258299827575684 C 9.253800392150879 9.423000335693359 9.59850025177002 9.661499977111816 9.886500358581543 9.960300445556641 C 9.952199935913086 10.03499984741211 9.988200187683105 10.12950038909912 9.989999771118164 10.22850036621094 C 9.991800308227539 10.32750034332275 9.958499908447266 10.42380046844482 9.895500183105469 10.50120067596436 L 7.889400005340576 12.88980007171631 C 7.863300323486328 12.92310047149658 7.829100131988525 12.95100021362305 7.791300296783447 12.96990013122559 C 7.752600193023682 12.98880004882812 7.710299968719482 12.99870014190674 7.668000221252441 12.99960041046143 C 7.624800205230713 12.99870014190674 7.582499980926514 12.98880004882812 7.544700145721436 12.96990013122559 Z M 11.07270050048828 8.779500007629395 C 11.03579998016357 8.761500358581543 11.00250053405762 8.737199783325195 10.97550010681152 8.705699920654297 C 10.55790042877197 8.240400314331055 10.04850006103516 7.866000175476074 9.479700088500977 7.606800079345703 C 8.909999847412109 7.347599983215332 8.293499946594238 7.209000110626221 7.668000221252441 7.200000286102295 C 7.043400287628174 7.209000110626221 6.426900386810303 7.346700191497803 5.858099937438965 7.604100227355957 C 5.289299964904785 7.862400054931641 4.780800342559814 8.235899925231934 4.363200187683105 8.700300216674805 C 4.33620023727417 8.732700347900391 4.303800106048584 8.758800506591797 4.266000270843506 8.776800155639648 C 4.22819995880127 8.793900489807129 4.187700271606445 8.803800582885742 4.145400047302246 8.803800582885742 C 4.104000091552734 8.803800582885742 4.063499927520752 8.793900489807129 4.025700092315674 8.776800155639648 C 3.987900018692017 8.758800506591797 3.954600095748901 8.732700347900391 3.928500175476074 8.700300216674805 L 2.768399953842163 7.315200328826904 C 2.706300020217896 7.237800121307373 2.672100067138672 7.14240026473999 2.672100067138672 7.043400287628174 C 2.672100067138672 6.94350004196167 2.706300020217896 6.848100185394287 2.768399953842163 6.770699977874756 C 3.379500150680542 6.068700313568115 4.131900310516357 5.503499984741211 4.976099967956543 5.111999988555908 C 5.820300102233887 4.720499992370605 6.738300323486328 4.512599945068359 7.668900012969971 4.5 C 8.59950065612793 4.512599945068359 9.517499923706055 4.721400260925293 10.3617000579834 5.112900257110596 C 11.20590019226074 5.505300045013428 11.95830059051514 6.070500373840332 12.56850051879883 6.77340030670166 C 12.63150024414062 6.849900245666504 12.66569995880127 6.946200370788574 12.66569995880127 7.045200347900391 C 12.66569995880127 7.144200325012207 12.63150024414062 7.240499973297119 12.56850051879883 7.317000389099121 L 11.41020011901855 8.700300216674805 C 11.38320064544678 8.732700347900391 11.3499002456665 8.758800506591797 11.31210041046143 8.777700424194336 C 11.27430057525635 8.795700073242188 11.23290061950684 8.805600166320801 11.19060039520264 8.805600166320801 C 11.15010070800781 8.805600166320801 11.10960006713867 8.796600341796875 11.07270050048828 8.779500007629395 Z M 1.350900053977966 5.598900318145752 C 1.313099980354309 5.579999923706055 1.280700087547302 5.552999973297119 1.254600048065186 5.519700050354004 L 0.09450000524520874 4.131900310516357 C 0.0333000011742115 4.055399894714355 0 3.960000038146973 0 3.861900091171265 C 0 3.763800144195557 0.0333000011742115 3.668400049209595 0.09450000524520874 3.591900110244751 C 1.025099992752075 2.484899997711182 2.18340015411377 1.591199994087219 3.490200042724609 0.9720000028610229 C 4.796999931335449 0.3519000113010406 6.221700191497803 0.02070000022649765 7.668000221252441 0 C 9.113400459289551 0.02070000022649765 10.53719997406006 0.3519000113010406 11.8439998626709 0.9720000028610229 C 13.14990043640137 1.592100024223328 14.30730056762695 2.484899997711182 15.23790073394775 3.591900110244751 C 15.29909992218018 3.668400049209595 15.33240032196045 3.763800144195557 15.33240032196045 3.861900091171265 C 15.33240032196045 3.960000038146973 15.29909992218018 4.055399894714355 15.23790073394775 4.131900310516357 L 14.07960033416748 5.515200138092041 C 14.05350017547607 5.548500061035156 14.02020072937012 5.575500011444092 13.98239994049072 5.593500137329102 C 13.94370079040527 5.612400054931641 13.90229988098145 5.622300148010254 13.86000061035156 5.623199939727783 L 13.86000061035156 5.624100208282471 C 13.81860065460205 5.624100208282471 13.77810001373291 5.615099906921387 13.74120044708252 5.598000049591064 C 13.70429992675781 5.579999923706055 13.67100048065186 5.554800033569336 13.64490032196045 5.524199962615967 C 12.90780067443848 4.653900146484375 11.99340057373047 3.951900005340576 10.96199989318848 3.465000152587891 C 9.931500434875488 2.977200031280518 8.808300018310547 2.717100143432617 7.668000221252441 2.700000047683716 C 6.527699947357178 2.716200113296509 5.404500007629395 2.976300001144409 4.373100280761719 3.462300062179565 C 3.342600107192993 3.94920015335083 2.427299976348877 4.650300025939941 1.690200090408325 5.519700050354004 C 1.664100050926208 5.552999973297119 1.630800008773804 5.579999923706055 1.593000054359436 5.598900318145752 C 1.556100010871887 5.616899967193604 1.514700055122375 5.626800060272217 1.472400069236755 5.626800060272217 C 1.430100083351135 5.626800060272217 1.388700008392334 5.616899967193604 1.350900053977966 5.598900318145752 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ymifyt =
    '<svg viewBox="0.0 0.3 17.0 12.7" ><path transform="translate(0.0, 0.34)" d="M 15.00300025939941 12.66660022735596 C 14.7140998840332 12.63960075378418 14.44770050048828 12.50010013580322 14.26049995422363 12.27780055999756 C 14.0733003616333 12.05640029907227 13.98060035705566 11.76930046081543 14.00310039520264 11.48040008544922 L 14.00310039520264 1.187100052833557 C 13.98060035705566 0.8973000049591064 14.0733003616333 0.6111000180244446 14.26049995422363 0.3887999951839447 C 14.44770050048828 0.1665000021457672 14.7140998840332 0.02700000070035458 15.00300025939941 0 L 16.00290107727051 0 C 16.29269981384277 0.02700000070035458 16.55910110473633 0.1665000021457672 16.74629974365234 0.3887999951839447 C 16.93350028991699 0.6111000180244446 17.02530097961426 0.8973000049591064 17.00370025634766 1.187100052833557 L 17.00370025634766 11.47860050201416 C 17.02620124816895 11.76840019226074 16.93350028991699 12.05550003051758 16.74629974365234 12.27780055999756 C 16.55910110473633 12.50010013580322 16.29269981384277 12.63960075378418 16.00290107727051 12.66660022735596 L 15.00300025939941 12.66660022735596 Z M 11.33640003204346 12.66660022735596 L 10.33650016784668 12.66660022735596 C 10.04759979248047 12.63960075378418 9.780300140380859 12.50010013580322 9.593100547790527 12.27780055999756 C 9.405900001525879 12.05640029907227 9.31410026550293 11.76930046081543 9.336600303649902 11.48040008544922 L 9.336600303649902 3.959100008010864 C 9.31410026550293 3.669300079345703 9.405900001525879 3.383100032806396 9.593100547790527 3.160799980163574 C 9.780300140380859 2.938500165939331 10.04759979248047 2.799000024795532 10.33650016784668 2.772000074386597 L 11.33640003204346 2.772000074386597 C 11.62530040740967 2.799000024795532 11.89170074462891 2.938500165939331 12.07890033721924 3.160799980163574 C 12.26609992980957 3.383100032806396 12.35879993438721 3.669300079345703 12.33629989624023 3.959100008010864 L 12.33629989624023 11.48040008544922 C 12.35879993438721 11.76930046081543 12.26609992980957 12.05550003051758 12.07980060577393 12.27780055999756 C 11.89260005950928 12.50010013580322 11.62620067596436 12.63960075378418 11.33730030059814 12.66660022735596 Z M 5.669100284576416 12.66660022735596 C 5.380199909210205 12.63960075378418 5.113800048828125 12.50010013580322 4.926599979400635 12.27780055999756 C 4.739399909973145 12.05640029907227 4.646699905395508 11.76930046081543 4.66919994354248 11.48040008544922 L 4.66919994354248 6.729300022125244 C 4.646699905395508 6.439500331878662 4.739399909973145 6.153300285339355 4.926599979400635 5.931000232696533 C 5.113800048828125 5.708700180053711 5.380199909210205 5.569200038909912 5.669100284576416 5.542200088500977 L 6.669000148773193 5.542200088500977 C 6.957900047302246 5.569200038909912 7.225200176239014 5.708700180053711 7.412400245666504 5.931000232696533 C 7.599600315093994 6.153300285339355 7.691400051116943 6.439500331878662 7.668900012969971 6.729300022125244 L 7.668900012969971 11.48040008544922 C 7.691400051116943 11.76930046081543 7.599600315093994 12.05640029907227 7.412400245666504 12.27780055999756 C 7.225200176239014 12.50010013580322 6.957900047302246 12.63960075378418 6.669000148773193 12.66660022735596 L 5.669100284576416 12.66660022735596 Z M 1.003499984741211 12.66660022735596 C 0.7146000266075134 12.63960075378418 0.4473000168800354 12.50010013580322 0.2601000070571899 12.27780055999756 C 0.07290000468492508 12.05640029907227 -0.01889999955892563 11.76930046081543 0.003600000170990825 11.48040008544922 L 0.003600000170990825 9.099900245666504 C -0.01800000108778477 8.810999870300293 0.0747000053524971 8.525700569152832 0.261900007724762 8.304300308227539 C 0.4491000175476074 8.082900047302246 0.7146000266075134 7.943400382995605 1.003499984741211 7.916399955749512 L 2.003400087356567 7.916399955749512 C 2.291399955749512 7.943400382995605 2.557800054550171 8.082900047302246 2.745000123977661 8.304300308227539 C 2.931300163269043 8.525700569152832 3.02400016784668 8.810999870300293 3.003300189971924 9.099900245666504 L 3.003300189971924 11.47500038146973 C 3.026700019836426 11.765700340271 2.934900045394897 12.05280017852783 2.747699975967407 12.27600002288818 C 2.560500144958496 12.49919986724854 2.293200016021729 12.63960075378418 2.003400087356567 12.66660022735596 L 1.003499984741211 12.66660022735596 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_82ykdu =
    '<svg viewBox="0.0 0.0 375.0 44.0" ><path  d="M 375 0 L 375 44 L 0 44 L 0 0 L 375 0 Z" fill="#212529" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8sg4sd =
    '<svg viewBox="-1474.0 -1382.0 10.0 20.0" ><path transform="translate(-1474.0, -1382.0)" d="M 10 0 L 0 10 L 10 20" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="butt" stroke-linejoin="bevel" /></svg>';
const String _svg_ybt8li =
    '<svg viewBox="10.9 12.0 3.4 4.0" ><path transform="translate(10.86, 12.0)" d="M 0 0 L 3.428571224212646 4" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lseiy1 =
    '<svg viewBox="0.0 0.0 13.3 16.0" ><path  d="M 1.999800086021423 16.00020027160645 C 0.8973000049591064 16.00020027160645 0 15.10290050506592 0 14.00040054321289 L 0 7.333199977874756 C 0 6.230700016021729 0.8973000049591064 5.333400249481201 1.999800086021423 5.333400249481201 L 1.999800086021423 4.666500091552734 C 1.999800086021423 2.094300031661987 4.093200206756592 0 6.666300296783447 0 C 9.240300178527832 0 11.33370018005371 2.094300031661987 11.33370018005371 4.666500091552734 L 11.33370018005371 5.333400249481201 C 12.43620014190674 5.333400249481201 13.33349990844727 6.230700016021729 13.33349990844727 7.333199977874756 L 13.33349990844727 14.00040054321289 C 13.33349990844727 15.10290050506592 12.43620014190674 16.00020027160645 11.33370018005371 16.00020027160645 L 1.999800086021423 16.00020027160645 Z" fill="#b2b2b2" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_nldm84 =
    '<svg viewBox="0.0 0.0 4.0 5.7" ><path  d="M 1.332900047302246 5.000400066375732 L 1.332900047302246 3.877200126647949 C 0.558899998664856 3.600900173187256 0 2.868299961090088 0 1.999800086021423 C 0 0.8973000049591064 0.8973000049591064 0 1.999800086021423 0 C 3.10230016708374 0 3.999600172042847 0.8973000049591064 3.999600172042847 1.999800086021423 C 3.999600172042847 2.868299961090088 3.440700054168701 3.600900173187256 2.666700124740601 3.877200126647949 L 2.666700124740601 5.000400066375732 C 2.666700124740601 5.368500232696533 2.367900133132935 5.666399955749512 1.999800086021423 5.666399955749512 C 1.631700038909912 5.666399955749512 1.332900047302246 5.368500232696533 1.332900047302246 5.000400066375732 Z" fill="#b2b2b2" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_okr2xv =
    '<svg viewBox="5.0 6.0 6.0 4.0" ><path transform="translate(5.0, 6.0)" d="M 0 2 L 2 4 L 6 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pyzwg7 =
    '<svg viewBox="0.0 0.0 13.3 16.0" ><path  d="M 1.999800086021423 16.00020027160645 C 0.8973000049591064 16.00020027160645 0 15.10290050506592 0 14.00040054321289 L 0 7.333199977874756 C 0 6.230700016021729 0.8973000049591064 5.333400249481201 1.999800086021423 5.333400249481201 L 1.999800086021423 4.666500091552734 C 1.999800086021423 2.094300031661987 4.093200206756592 0 6.666300296783447 0 C 9.240300178527832 0 11.33370018005371 2.094300031661987 11.33370018005371 4.666500091552734 L 11.33370018005371 5.333400249481201 C 12.43620014190674 5.333400249481201 13.33349990844727 6.230700016021729 13.33349990844727 7.333199977874756 L 13.33349990844727 14.00040054321289 C 13.33349990844727 15.10290050506592 12.43620014190674 16.00020027160645 11.33370018005371 16.00020027160645 L 1.999800086021423 16.00020027160645 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_bnzn8 =
    '<svg viewBox="0.0 0.0 4.0 5.7" ><path  d="M 1.332900047302246 5.000400066375732 L 1.332900047302246 3.877200126647949 C 0.558899998664856 3.600900173187256 0 2.868299961090088 0 1.999800086021423 C 0 0.8973000049591064 0.8973000049591064 0 1.999800086021423 0 C 3.10230016708374 0 3.999600172042847 0.8973000049591064 3.999600172042847 1.999800086021423 C 3.999600172042847 2.868299961090088 3.440700054168701 3.600900173187256 2.666700124740601 3.877200126647949 L 2.666700124740601 5.000400066375732 C 2.666700124740601 5.368500232696533 2.367900133132935 5.666399955749512 1.999800086021423 5.666399955749512 C 1.631700038909912 5.666399955749512 1.332900047302246 5.368500232696533 1.332900047302246 5.000400066375732 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
