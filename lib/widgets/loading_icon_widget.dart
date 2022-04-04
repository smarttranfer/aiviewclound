import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 8),
        child: SizedBox(
          child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(const Color(0xfffd7b38))),
          height: 20.0,
          width: 20.0,
        ));
  }
}
