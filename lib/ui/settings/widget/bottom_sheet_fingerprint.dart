import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetFingerprint extends StatefulWidget {
  const BottomSheetFingerprint({
    Key? key,
    this.onClickYes,
    this.onClickNo,
    this.title,
    this.titleButtonConfirm,
    this.titleButtonCancel,
    this.icon,
    this.isBold = true,
  }) : super(key: key);

  final GestureTapCallback? onClickYes;
  final GestureTapCallback? onClickNo;
  final String? title;
  final String? titleButtonConfirm;
  final String? titleButtonCancel;
  final Widget? icon;
  final bool isBold;

  @override
  _BottomSheetFingerprintState createState() => _BottomSheetFingerprintState();
}

class _BottomSheetFingerprintState extends State<BottomSheetFingerprint> {
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
              widget.title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17.sp,
                color: const Color(0xffffffff),
                fontWeight: widget.isBold ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          widget.icon ?? SizedBox(),
          const Spacer(),
          if (widget.onClickNo != null)
            Container(
              margin: EdgeInsets.only(top: 30.h, bottom: 12.h),
              child: SMEButton(
                  onPress: widget.onClickNo,
                  title: widget.titleButtonCancel ?? 'Không',
                  primaryColor: const Color(0xff5a5a5a)),
            ),
          if (widget.onClickYes != null)
            Container(
              child: SMEButton(
                onPress: widget.onClickYes,
                title: widget.titleButtonConfirm ?? 'Có',
                primaryColor: const Color(0xfffd7b38),
              ),
            )
        ],
      ),
    );
  }
}
