import 'package:aiviewcloud/constants/colors.dart';
import 'package:flutter/material.dart';

import 'media_item.dart';

class VideoDisplayLength extends StatelessWidget {
  final int duration;

  const VideoDisplayLength({Key? key, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 20,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.mGreyColor4.withOpacity(.3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                color: AppColors.mRedColor, shape: BoxShape.circle),
          ),
          Text(
            formatDuration(duration),
            style: textStyle.copyWith(fontSize: 10, height: 0.9),
          ),
        ],
      ),
    );
  }

  String formatDuration(int seconds) {
    return '${Duration(seconds: seconds).inHours.toString().padLeft(2, '0')}:${Duration(seconds: seconds).inMinutes.toString().padLeft(2, '0')}:${Duration(seconds: seconds).inSeconds.toString().padLeft(2, '0')}';
  }
}
