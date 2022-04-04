import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217),
    1000: const Color(0xfffd7b38)
  };
  static Color mWhiteColor = Colors.white;
  static Color mGreyColor1 = Color(0xff818181);
  static Color mGreyColor2 = Color(0xff2B2F33);
  static Color mGreyColor3 = Color(0xff212529);
  static Color mGreyColor4 = Color(0xff2C343E);
  static Color mGreyColor5 = Color(0xff404447);
  static Color mRedColor = Color(0xffFD413C);
  static Color mGreenColor = Color(0xff4AA541);
  static Color mOrangeColor = Color(0xffFD7B38);
}
