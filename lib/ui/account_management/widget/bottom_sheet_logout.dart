import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetLogoutWidget extends StatefulWidget {
  final GestureTapCallback? onClickYes;
  final GestureTapCallback? onClickNo;

  BottomSheetLogoutWidget({Key? key, this.onClickYes, this.onClickNo})
      : super(key: key);

  @override
  _BottomSheetLogoutWidgetState createState() =>
      _BottomSheetLogoutWidgetState();
}

class _BottomSheetLogoutWidgetState extends State<BottomSheetLogoutWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 90.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: const Color(0xffffffff),
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
            child: Text(
              'Bạn có muốn đăng xuất không ?',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.only(top: 30.h, bottom: 12.h),
            child: SMEButton(
                onPress: widget.onClickNo,
                title: "Không",
                primaryColor: const Color(0xff5a5a5a)),
          ),
          Container(
            child: SMEButton(
              onPress: widget.onClickYes,
              title: "Có",
              primaryColor: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
