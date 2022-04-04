import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemAccount extends StatelessWidget {
  const ItemAccount({Key? key, this.onClick, this.title, this.icon})
      : super(key: key);

  final GestureTapCallback? onClick;
  final String? title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 66.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: const Color(0xff2b2f33)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Container(
                height: 24,
                width: 24,
                margin: EdgeInsets.only(right: 12.w),
                child: icon,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
              Container(
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 17,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ]),
            Container(
              child: SvgPicture.string(
                _svg_e6zaj3,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_e6zaj3 =
    '<svg viewBox="335.0 325.0 8.0 16.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 343.0, 341.0)" d="M 8 0 L 0 8 L 8 16" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="butt" stroke-linejoin="bevel" /></svg>';
