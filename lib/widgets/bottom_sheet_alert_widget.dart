import 'package:adobe_xd/adobe_xd.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AlertType { alert, success }

class BottomSheetAlertWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final AlertType type;
  final VoidCallback? onPress;
  const BottomSheetAlertWidget(
      {Key? key,
      this.message,
      this.title,
      this.type = AlertType.alert,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Adobe XD layer: 'Group 6401' (group)
        Stack(
      children: <Widget>[
        Pinned.fromPins(
          Pin(start: 0.0, end: 0.0),
          Pin(start: 0.0, end: 0.0),
          child:
              // Adobe XD layer: 'Rectangle 1838' (shape)
              Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              color: const Color(0xff212529),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1a000000),
                  offset: Offset(0, 0),
                  blurRadius: 40,
                ),
              ],
            ),
          ),
        ),
        Pinned.fromPins(
          Pin(size: 90.0, middle: 0.5053),
          Pin(size: 6.0, start: 16.0),
          child:
              // Adobe XD layer: 'Rectangle 1839' (shape)
              Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: const Color(0xffffffff),
            ),
          ),
        ),
        Pinned.fromPins(
          Pin(start: 16.0, end: 16.0),
          Pin(size: 48.0, end: 34.0),
          child:
              // Adobe XD layer: 'Group 6218' (group)
              SMEButton(
            onPress: onPress ?? Navigator.of(context).pop,
            title: "Đóng",
          ),
        ),
        Pinned.fromPins(
          Pin(start: 30.0, end: 30.0),
          Pin(size: 121.0, middle: 0.3363),
          child:
              // Adobe XD layer: 'Group 6400' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 36.0, end: 0.0),
                child:
                    // Adobe XD layer: 'Tài khoản và mật kh…' (text)
                    Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      this.message ?? '',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 48.0, middle: 0.5019),
                Pin(size: 48.0, start: 0.0),
                child:
                    // Adobe XD layer: 'coolicon' (shape)
                    SvgPicture.asset(
                  type == AlertType.alert ? Assets.error : Assets.success,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
              Pinned.fromPins(
                Pin(start: 22.0, end: 21.0),
                Pin(size: 21.0, middle: 0.56),
                child:
                    // Adobe XD layer: 'Đăng nhập không thà…' (text)
                    Scrollbar(
                  child: Text(
                    this.title ?? '',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 17,
                      color: type == AlertType.alert
                          ? const Color(0xfffd413c)
                          : const Color(0xff4AA541),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
