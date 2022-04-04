import 'dart:async';

import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/camera_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDeviceProgress extends StatefulWidget {
  @override
  _AddDeviceProgressState createState() => _AddDeviceProgressState();
}

class _AddDeviceProgressState extends State<AddDeviceProgress> {
  String serial = "";
  late Timer timer;

  late CameraP2PStore _cameraP2PStore;
  String errorMessage = "";
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if (arguments != null)
      setState(() {
        serial = arguments["serial"].toString();
      });
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);

    timer = Timer(Duration(seconds: 0), () async {
      final resp = await _cameraP2PStore.addDevice({"Serial": serial});

      if (resp["isError"]) {
        setState(() {
          errorMessage = resp["Object"];
        });
      } else {
        Navigator.pushNamed(context, Routes.addDeviceSuccess,
            arguments: {'serial': serial});
      }
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
                    child: Row(
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
                CameraLabelWidget(),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 22.0, end: 16.0),
            Pin(size: 35.0, middle: 0.3745),
            child:
                // Adobe XD layer: 'Group 7514' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Đang thêm thiết bị …' (text)
                      Text(
                    errorMessage.length > 0
                        ? errorMessage
                        : 'Đang thêm thiết bị vào tài khoản... Vui lòng chờ !',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 56.0, end: 49.0),
            Pin(size: 8.0, middle: 0.3445),
            child:
                // Adobe XD layer: 'Group 7560' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Rectangle 2276' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xff818181),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 145.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Rectangle 2277' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xfffd7b38),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 108.0, middle: 0.5126),
            Pin(size: 31.0, middle: 0.3047),
            child:
                // Adobe XD layer: 'Group 7559' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 37.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Group 7496' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: '80%' (text)
                            Text(
                          '80%',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xfffd7b38),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 73.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Group 7497' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'Loading...' (text)
                            Text(
                          'Loading...',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
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
