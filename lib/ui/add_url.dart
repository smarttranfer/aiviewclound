import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUrlScreen extends StatefulWidget {
  @override
  _AddUrlState createState() => _AddUrlState();
}

class _AddUrlState extends State<AddUrlScreen> {
  TextEditingController _serialController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void initUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('url');
    if (url != null) {
      _serialController.text = url;
    } else {
      _serialController.text = Endpoints.getUrlEndPoint;
    }
  }

  bool isCorrectSerial = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          HeaderWidget(headerText: 'Chỉnh sửa url api'),
          GestureDetector(
              onTap: () async {
                Endpoints.baseUrl = _serialController.text;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('url', _serialController.text);
                Navigator.of(context).pop();
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
                            color: const Color(0xfffd7b38)),
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
              Pin(end: 16.0, start: 16.0), Pin(size: 65.0, middle: 0.2575),
              child: TextFieldWidget(
                hint: "Nhập url",
                inputType: TextInputType.text,
                textController: _serialController,
                inputAction: TextInputAction.next,
                // onChanged: (text) {
                //   if (text.length == 0) {
                //     setState(() {
                //       isCorrectSerial = false;
                //     });
                //     return;
                //   }
                //   if (text.length > 0 && !isCorrectSerial) {
                //     setState(() {
                //       isCorrectSerial = true;
                //     });
                //   }
                // },
                errorText: "",
                autoFocus: false,
                textStyle: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  color: const Color(0xff818181),
                ),
              )
              // Adobe XD layer: 'Nhập số seri thiết …' (text
              ),
          Pinned.fromPins(
            Pin(size: 205.0, start: 16.0),
            Pin(size: 20.0, middle: 0.1895),
            child:
                // Adobe XD layer: 'Số seri' (text)
                Text(
              'Đường dẫn api',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_eaphde =
    '<svg viewBox="16.0 182.0 343.0 47.5" ><path transform="translate(16.0, 182.0)" d="M 8 0 L 335 0 C 339.4182739257812 0 343 3.546775817871094 343 7.921946048736572 L 343 39.6097297668457 C 343 43.98490142822266 339.4182739257812 47.53167724609375 335 47.53167724609375 L 8 47.53167724609375 C 3.581721782684326 47.53167724609375 0 43.98490142822266 0 39.6097297668457 L 0 7.921946048736572 C 0 3.546775817871094 3.581721782684326 0 8 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
