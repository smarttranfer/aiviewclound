import 'package:aiviewcloud/widgets/drawer_header_widget.dart';
import 'package:flutter/material.dart';

import 'header_widget.dart';

class ScreenWidget extends StatelessWidget {
  final String? headerText;
  final Widget? widget;
  final bool isDrawer;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onBackPress;
  const ScreenWidget(
      {this.headerText,
      this.widget,
      this.mainAxisAlignment,
      this.onBackPress,
      this.padding,
      this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          this.isDrawer
              ? DrawerHeaderWidget(headerText: this.headerText ?? '')
              : HeaderWidget(
                  headerText: this.headerText ?? '', onBackPress: onBackPress),
          Expanded(
              flex: 1,
              child: Padding(
                  padding: this.padding ??
                      const EdgeInsets.only(
                          left: 16, right: 16, top: 23, bottom: 16),
                  child: widget ?? Container()))
        ]));
  }
}
