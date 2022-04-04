import 'package:aiviewcloud/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderLandscapeWidget extends StatelessWidget {
  final String headerText;
  final String? pageString;
  final VoidCallback? onBackPress;
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
                        child: Row(children: [
                          SvgPicture.string(
                            Strings.backSvg,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.contain,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 8.w),
                              child: Text(
                                headerText,
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay-Bold',
                                  fontSize: 20,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.center,
                              ))
                        ])),
                  ),
                ),
                // Adobe XD layer: 'Nhập mật khẩu mới' (text)
                Expanded(
                    flex: 1,
                    child: Text(
                      pageString ?? '',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay-Bold',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    )),

                Expanded(flex: 1, child: Container())
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0.5, -3.0616171314629196e-17),
                    end: Alignment(0.5000000000000001, 1),
                    colors: [
                  const Color(0xff212529),
                  const Color(0x00212529)
                ]))));
  }

  const HeaderLandscapeWidget(
      {Key? key, required this.headerText, this.onBackPress, this.pageString})
      : super(key: key);
}
