import 'package:aiviewcloud/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';

class SMEButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? title;
  final bool isLoading;
  final Color? primaryColor;
  const SMEButton(
      {this.onPress, this.title, this.isLoading = false, this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.0),
        primary: onPress == null || this.isLoading
            ? const Color(0xff818181)
            : this.primaryColor ?? const Color(0xfffd7b38), // background
        onPrimary: Colors.white, // foreground
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPress,
      child: this.isLoading
          ? CustomProgressIndicatorWidget()
          : Text(
              this.title ?? '',
              style: TextStyle(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w400,
                  fontFamily: "SFProDisplay",
                  fontStyle: FontStyle.normal,
                  fontSize: 17.0),
              textAlign: TextAlign.center,
            ),
    );
  }
}
