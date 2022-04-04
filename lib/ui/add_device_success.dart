import 'package:adobe_xd/pinned.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/camera_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class AddDeviceSuccess extends StatefulWidget {
  @override
  _AddDeviceSuccessState createState() => _AddDeviceSuccessState();
}

class _AddDeviceSuccessState extends State<AddDeviceSuccess> {
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
          HeaderWidget(
              headerText: AppLocalizations.of(context).translate('check')),
          Pinned.fromPins(
            Pin(size: 310.0, middle: 0.5027),
            Pin(size: 98.0, middle: 0.1737),
            child:
                // Adobe XD layer: 'Group 7493' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0), Pin(size: 20.0, end: 0.0),
                    child:
                        // Adobe XD layer: 'Seri: 1234567891234…' (text)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Text(
                            'Seri',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 10),
                          Text(
                            serial,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ])),
                CameraLabelWidget()
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.addDeviceInfo,
                    arguments: {'serial': serial});
              },
              child: Pinned.fromPins(
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
                      Pin(size: 20, middle: 0.5),
                      child:
                          // Adobe XD layer: 'Tiếp tục' (text)
                          Text(
                        'Tiếp tục',
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
          Pinned.fromPins(
            Pin(start: 15.0, end: 15.0),
            Pin(size: 45.0, middle: 0.3513),
            child:
                // Adobe XD layer: 'Thêm thiết bị thành…' (text)
                Text(
              'Thêm thiết bị thành công.\nBấm tiếp tục để chỉnh sửa thông tin thiết bị của bạn!',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                color: const Color(0xff4aa541),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
