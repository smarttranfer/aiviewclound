import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/ui/live_cam.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomMenuCameraLandcape extends StatelessWidget {
  final VoidCallback? onControlPress;
  final VoidCallback? onTrashPress;
  final VoidCallback? onHdModePress;
  final VoidCallback? onSettingPress;
  final VoidCallback? onFullScreenPress;
  final VoidCallback? onRecordPress;
  final VoidCallback? onSnapshotPress;
  final bool isShowTrash;
  final bool isShowSetting;
  final bool isShowHD;
  final Channel? channel;
  const BottomMenuCameraLandcape(
      {this.onControlPress,
      this.onSnapshotPress,
      this.onRecordPress,
      this.onTrashPress,
      this.onFullScreenPress,
      this.onHdModePress,
      this.channel,
      this.isShowHD = true,
      this.isShowSetting = true,
      this.isShowTrash = true,
      this.onSettingPress})
      : super();

  List<Widget> renderItem() {
    List<Widget> arrs = [
      Opacity(
          opacity: 1,
          child: Container(
            width: 52,
            height: 52,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(60)),
            child: SvgPicture.asset(
              Assets.record,
            ),
          )),
      GestureDetector(
          onTap: this.onControlPress,
          child: Container(
            width: 52,
            height: 52,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(Assets.camera),
          )),
      GestureDetector(
          onTap: this.onControlPress,
          child: Container(
            width: 52,
            height: 52,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(
              Assets.control,
            ),
          )),
      GestureDetector(
          onTap: this.onControlPress,
          child: Container(
            width: 52,
            height: 52,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(
              Assets.volume,
            ),
          )),
      GestureDetector(
          onTap: this.onHdModePress,
          child: Container(
            width: 52,
            height: 52,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(
              Assets.hdmode,
            ),
          )),
      GestureDetector(
          onTap: this.onControlPress,
          child: Container(
            width: 52,
            height: 52,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(Assets.trash),
          )),
      Container(
        width: 52,
        height: 52,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color(0xff404447),
            borderRadius: BorderRadius.circular(30)),
        child: SvgPicture.asset(
          Assets.setting,
        ),
      )
    ];
    if (this.onControlPress == null) arrs.removeAt(2);
    return arrs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration:
          BoxDecoration(color: const Color(0xff2b2f33).withOpacity(0.6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: renderItem(),
      ),
    );
  }
}
