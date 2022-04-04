import 'dart:convert';
import 'dart:io';

import 'package:aiviewcloud/models/device/device.dart';
import 'package:aiviewcloud/models/device/device_list.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_modal_widget.dart';
import 'package:aiviewcloud/widgets/device_list_icon_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  DeviceList deviceList = new DeviceList(devices: []);

  @override
  void initState() {
    super.initState();
    postData(context);
  }

  dynamic postData(context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/mocks/device.json");
    final jsonResult = json.decode(data);
    print(DeviceList.fromJson(jsonResult).devices!.first.model);
    setState(() {
      deviceList = DeviceList.fromJson(jsonResult);
    });
  }

  Widget buildItem(index) {
    return Container(
        height: 75,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Stack(children: [
          DeviceListIcon(),
          Pinned.fromPins(
            Pin(start: 72, size: 300),
            Pin(size: 20.0, middle: 0.2614),
            child:
                // Adobe XD layer: 'Mã Model; Seri Numb…' (text)
                Text(
              '${deviceList.devices?[index].model} ${deviceList.devices?[index].seri}',
              style: TextStyle(
                fontFamily: 'SFProDisplay-Bold',
                fontSize: 17,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 243.0, start: 72),
            Pin(size: 15.0, middle: 0.7114),
            child:
                // Adobe XD layer: 'ID; Port' (text)
                Text(
              '${deviceList.devices?[index].id}',
              style: TextStyle(
                fontFamily: 'SFProDisplay-Regular',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ]),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: const Color(0xff2b2f33)));
  }

  onShowBottomModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                  height: 410,
                  child:
                      BottomSheetModalWidget(context: context, address: "")));
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      resizeToAvoidBottomInset: true,
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
                      // Adobe XD layer: 'Tìm kiếm thiết bị (…' (shape)
                      Container(
                    color: const Color(0xff212529),
                  ),
                ),
                HeaderWidget(headerText: "Danh sách tìm kiếm"),
                GestureDetector(
                    onTap: () => onShowBottomModal(),
                    child: Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(size: 92.0, start: 0.0),
                      child:
                          // Adobe XD layer: 'Group 6408' (group)
                          Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(size: 17.9, end: 16.1),
                            Pin(size: 20.0, middle: 0.8056),
                            child:
                                // Adobe XD layer: 'Group 6238' (group)
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
                        ],
                      ),
                    )),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 44.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0), Pin(end: 0.0, start: 64.0),
                          child: Stack(children: [
                            ListView.builder(
                                padding: EdgeInsets.only(top: 0),
                                itemCount: deviceList.devices!.length,
                                itemBuilder: (BuildContext ctxt, int index) =>
                                    buildItem(index)),
                          ])),

                      // Adobe XD layer: 'Group' (group)
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
const String _svg_lxp3mb =
    '<svg viewBox="-3523.0 -2403.0 375.0 812.0" ><path transform="translate(-3523.0, -2403.0)" d="M 375 0 L 375 812 L 0 812 L 0 0 L 375 0 Z" fill="#000000" fill-opacity="0.7" stroke="none" stroke-width="1" stroke-opacity="0.7" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
