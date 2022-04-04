import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'drawer_icon_widget.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final String headerText;
  final Widget rightWidget;
  final Widget? leftWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftWidget ??
                GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: DrawerIcon()),
            // Pinned.fromPins(
            //   Pin(size: 243.0, middle: 0.5),
            //   Pin(size: 24.0, start: 40.0),
            //   child:
            // Adobe XD layer: 'Xem trực tiếp' (text)
            Text(
              this.headerText,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 20,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            // ),
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              child: rightWidget,
            ),
          ],
        ));
  }

  const DrawerHeaderWidget({
    Key? key,
    required this.headerText,
    this.rightWidget = const SizedBox(),
    this.leftWidget,
  }) : super(key: key);
}
