import 'package:aiviewcloud/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  final String headerText;
  final VoidCallback? onBackPress;
  final Widget? actionWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onBackPress ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15),
                        // Adobe XD layer: 'Vector 1' (shape)
                        child: SvgPicture.string(
                          Strings.backSvg,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                // Adobe XD layer: 'Nhập mật khẩu mới' (text)
                Expanded(
                  flex: 3,
                  child: Text(
                    headerText,
                    style: TextStyle(
                      fontFamily: 'SFProDisplay-Bold',
                      fontSize: 20,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: actionWidget ?? Container()))
              ],
            )));
  }

  const HeaderWidget(
      {Key? key, required this.headerText, this.onBackPress, this.actionWidget})
      : super(key: key);
}
