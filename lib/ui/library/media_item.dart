import 'dart:io';
import 'dart:ui';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/ui/library/video_play_duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

// ignore: must_be_immutable
class MediaItemWidget extends StatelessWidget {
  MediaItemWidget({
    Key? key,
    required this.entity,
    this.checkStatus = false,
    required this.isVisibleCheck,
  }) : super(key: key);

  final AssetEntity entity;
  final bool checkStatus;
  final bool isVisibleCheck;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.file(
            File(entity.relativePath!),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Visibility(
              visible: isVisibleCheck,
              child: checkStatus
                  ? SvgPicture.asset(Assets.checked)
                  : SvgPicture.asset(Assets.unchecked),
            ),
          ),
          Visibility(
            visible: entity.type == AssetType.video,
            child: VideoDisplayLength(
              duration: entity.duration,
            ),
          )
        ],
      ),
    );
  }
}

Widget loadWidget({double sizeLoading = 15}) => Center(
      child: SizedBox.fromSize(
        size: Size.square(sizeLoading),
        child: CupertinoActivityIndicator(
          radius: sizeLoading,
        ),
      ),
    );
