import 'package:aiviewcloud/ui/settings/widget/bottom_sheet_fingerprint.dart';
import 'package:aiviewcloud/ui/settings/widget/item_security.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoStepAuth extends StatefulWidget {
  const TwoStepAuth({Key? key}) : super(key: key);

  @override
  _TwoStepAuthState createState() => _TwoStepAuthState();
}

class _TwoStepAuthState extends State<TwoStepAuth> {
  Widget body() {
    return Column(
      children: [
        ItemSecurity(
          switchButton: true,
          type: optionType.FINGER_PRINT,
          title: AppLocalizations.of(context).translate('twostep_confirm'),
          onClickSwitch: (value) {
            showConfirmDialog(context);
          },
        ),
        Text(
          AppLocalizations.of(context).translate('twostep_desc'),
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 17.sp,
            color: const Color(0xff818181),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: ScreenWidget(
        widget: body(),
        headerText: AppLocalizations.of(context).translate('twostep'),
      ),
    );
  }

  showConfirmDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 280.h,
                child: BottomSheetFingerprint(
                  title: AppLocalizations.of(context)
                      .translate('confirm_phone_first'),
                  titleButtonCancel:
                      AppLocalizations.of(context).translate('cancel'),
                  titleButtonConfirm:
                      AppLocalizations.of(context).translate('confirm'),
                  isBold: false,
                  onClickYes: () {},
                  onClickNo: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
        });
    return SizedBox.shrink();
  }
}
