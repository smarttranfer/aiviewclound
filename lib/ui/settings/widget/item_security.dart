import 'package:aiviewcloud/ui/settings/widget/bottom_sheet_fingerprint.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum optionType { FINGER_PRINT, AUTH2STEP, DELETE_ACCOUNT }

class ItemSecurity extends StatefulWidget {
  const ItemSecurity({
    Key? key,
    this.onClick,
    this.title,
    required this.switchButton,
    required this.type,
    this.onClickSwitch,
  }) : super(key: key);

  final GestureTapCallback? onClick;
  final ValueChanged<bool>? onClickSwitch;
  final String? title;
  final bool switchButton;
  final optionType type;

  @override
  State<ItemSecurity> createState() => _ItemSecurityState();
}

class _ItemSecurityState extends State<ItemSecurity> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
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
            Container(
              child: Text(
                widget.title ?? '',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 17,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            widget.type == optionType.FINGER_PRINT
                ? CupertinoSwitch(
                    value: _switchValue,
                    activeColor: const Color(0xfffd7b38),
                    onChanged: widget.onClickSwitch,
                  )
                : Row(
                    children: [
                      widget.type == optionType.AUTH2STEP
                          ? Text(
                              AppLocalizations.of(context)
                                  .translate('turn_off'),
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 18.sp,
                                color: const Color(0xffffffff),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(width: 8.w),
                      Container(
                        child: SvgPicture.string(
                          _svg_e6zaj3,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

const String _svg_e6zaj3 =
    '<svg viewBox="335.0 325.0 8.0 16.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 343.0, 341.0)" d="M 8 0 L 0 8 L 8 16" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="butt" stroke-linejoin="bevel" /></svg>';
