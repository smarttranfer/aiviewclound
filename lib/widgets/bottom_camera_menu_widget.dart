import 'package:aiviewcloud/constants/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomMenuCamera extends StatelessWidget {
  final VoidCallback? onControlPress;
  final VoidCallback? onRecordPress;
  final VoidCallback? onSnapshotPress;

  const BottomMenuCamera(
      {Key? key, this.onControlPress, this.onRecordPress, this.onSnapshotPress})
      : super(key: key);
  List<Widget> renderItem() {
    List<Widget> arrs = [
      GestureDetector(
          onTap: this.onRecordPress,
          child: Container(
            width: 51.861717224121094.h,
            height: 51.999996185302734.h,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30.w)),
            child: SvgPicture.asset(
              Assets.record,
            ),
          )),
      GestureDetector(
          onTap: this.onSnapshotPress,
          child: Container(
            width: 51.861717224121094.h,
            height: 51.999996185302734.h,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(Assets.camera),
          )),
      GestureDetector(
          onTap: this.onControlPress,
          child: Container(
            width: 51.861717224121094.h,
            height: 51.999996185302734.h,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xff404447),
                borderRadius: BorderRadius.circular(30)),
            child: SvgPicture.asset(
              Assets.control,
            ),
          )),
      Container(
        width: 51.861717224121094.h,
        height: 51.999996185302734.h,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color(0xff404447),
            borderRadius: BorderRadius.circular(30)),
        child: SvgPicture.asset(
          Assets.volume,
        ),
      ),
    ];
    if (this.onControlPress == null) arrs.removeAt(2);
    return arrs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(color: const Color(0xff2b2f33)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: renderItem(),
      ),
    );
  }
}
