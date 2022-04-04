import 'package:another_flushbar/flushbar.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

EdgeInsets dialogMar = const EdgeInsets.fromLTRB(50, 10, 50, 10);
TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

class DialogApp {
  static void errorDialog(BuildContext context, String message) {
    Flushbar(
      margin: dialogMar,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
      backgroundColor: AppColors.mGreyColor2,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 2),
      isDismissible: false,
    ).show(context);
  }

  static Future deleteVideoAndImageBottomSheet(BuildContext context,
      {required VoidCallback yesCallBack}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        final height = MediaQuery.of(context).size.height;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: isPortrait ? height / 2 : height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mGreyColor3,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 6,
                      width: 90,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mWhiteColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xoá ảnh & Video',
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 26, bottom: 8),
                          child: SvgPicture.asset(
                            Assets.trash,
                            width: 36,
                            height: 40,
                            color: AppColors.mRedColor,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate('delete_confirm'),
                          style: textStyle.copyWith(
                            fontSize: 17,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.mGreyColor2,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SMEButton(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    title: AppLocalizations.of(context).translate('no'),
                    primaryColor: AppColors.mGreyColor1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 32),
                    child: SMEButton(
                      onPress: yesCallBack,
                      title: AppLocalizations.of(context).translate('yes'),
                      primaryColor: AppColors.mOrangeColor,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Future videoPlaySpeedList(BuildContext context,
      {required ValueChanged onSelectValue}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        final height = MediaQuery.of(context).size.height;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: isPortrait ? height / 2 : height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mGreyColor3,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 6,
                      width: 90,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mWhiteColor,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      8,
                      (index) => SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: RawMaterialButton(
                          onPressed: () {
                            onSelectValue(index * 0.25);
                          },
                          child: Text(
                            index * 0.25 == 1 ? 'Normal' : '${index * 0.25}',
                            style: textStyle,
                          ),
                        ),
                      ),
                    ).sublist(1),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
