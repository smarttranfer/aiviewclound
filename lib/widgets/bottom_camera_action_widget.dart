import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/ui/live_cam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomActionCamera extends StatelessWidget {
  final VoidCallback? onTrashPress;
  final VoidCallback? onHdModePress;
  final VoidCallback? onSettingPress;
  final VoidCallback? onFullScreenPress;
  final bool isShowTrash;
  final bool isShowSetting;
  final bool isShowHD;
  final Channel? channel;
  const BottomActionCamera(
      {this.onTrashPress,
      this.onFullScreenPress,
      this.onHdModePress,
      this.channel,
      this.isShowHD = true,
      this.isShowSetting = true,
      this.isShowTrash = true,
      this.onSettingPress})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 80.w),
        decoration: BoxDecoration(color: const Color(0xff404447)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          this.isShowTrash
              ? GestureDetector(
                  onTap: onTrashPress,
                  child: Container(
                      width: 48.h,
                      height: 48.h,
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        Assets.trash,
                        fit: BoxFit.none,
                      )),
                )
              : Container(),
          this.isShowHD
              ? GestureDetector(
                  onTap: onHdModePress,
                  child: Container(
                      width: 48.h,
                      height: 48.h,
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        this.channel == Channel.MAIN
                            ? Assets.hdmode
                            : Assets.sdmode,
                        fit: BoxFit.none,
                      )))
              : Container(),
          this.isShowSetting
              ? GestureDetector(
                  onTap: onSettingPress,
                  child: Container(
                      width: 48.h,
                      height: 48.h,
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        Assets.setting,
                        fit: BoxFit.none,
                      )))
              : Container(),
          GestureDetector(
              onTap: onFullScreenPress,
              child: Container(
                width: 48.h,
                height: 48.h,
                color: Colors.transparent,
                child: SvgPicture.asset(
                  Assets.fullscreen,
                  fit: BoxFit.none,
                ),
              ))
          // GridView.builder(
          //   itemCount: camList.cameras!.length,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          //   itemBuilder: (BuildContext context, int index) {
          //     return CamItem(camera: camList.cameras![index]);
          //   },
          // ),
        ]));
  }
}
