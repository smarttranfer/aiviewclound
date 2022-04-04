import 'package:aiviewcloud/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CamItemEmpty extends StatelessWidget {
  CamItemEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: double.infinity,
      child: AspectRatio(
          aspectRatio: isportrait ? 16 / 11 : 1 / 1,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: const Color(0xff2b2f33)),
                      child: Center(
                        child: SvgPicture.asset(Assets.add_camera),
                      ))),
              SizedBox(
                  child: Container(
                height: 28.h,
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                decoration: BoxDecoration(color: const Color(0xff404447)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "SFProDisplay",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    Container()
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
