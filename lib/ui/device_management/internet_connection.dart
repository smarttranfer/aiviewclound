import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnection {
  InternetConnection._privateConstructor();

  static final InternetConnection instance =
      InternetConnection._privateConstructor();
  final Connectivity connectivity = Connectivity();

  void listenInternetConnection(BuildContext context) async {
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    openDialog(connectivityResult, context);
    connectivity.onConnectivityChanged.listen((
      ConnectivityResult connectivityResult,
    ) {
      openDialog(connectivityResult, context);
    });
  }

  void openDialog(ConnectivityResult connectivityResult, BuildContext context) {
    if (connectivityResult == ConnectivityResult.none) {
      FlushbarHelper.createError(
        message: 'Không có mạng',
        title: AppLocalizations.of(context).translate('home_tv_error'),
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}
