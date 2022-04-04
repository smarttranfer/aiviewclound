import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInfo extends StatelessWidget {
  const LoginInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        body: ScreenWidget(
          widget: body(),
          headerText: 'Tài khoản đăng nhập',
        ));
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.only(top: 80.h),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text:
                  'Tài khoản đăng nhập của bạn là duy nhất.\nNếu có bất kì thắc mắc gì về tài khoản của bạn, vui lòng liên hệ đến hotline: ',
              style: TextStyle(color: Colors.white),
            ),
            TextSpan(
              text: ' 19001088',
              style: TextStyle(
                  color: const Color(0xfffd7b38), fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' để được hỗ trợ!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
