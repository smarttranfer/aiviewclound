import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPermission {
  static var picker = ImagePicker();

  static Future<File?> checkPermissionAndPickImage(
      String type, BuildContext context) async {
    if (Platform.isAndroid) {
      if (type == 'gallery') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.storage].request();
        if (request[Permission.storage] == PermissionStatus.permanentlyDenied) {
          final openSetting = await bottomDialog(
            'BKAV sme muốn truy cập thư viện của bạn',
            'Điều này sẽ cho phép ứng dụng truy cập thư viện của bạn',
            context,
          );
          if (openSetting == true) {
            await openAppSettings();
          }
        } else if (request[Permission.storage] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
        } else if (request[Permission.storage] == PermissionStatus.granted) {
          return await getImage(ImageSource.gallery);
        }
      }
      if (type == 'camera') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.camera].request();
        if (request[Permission.camera] == PermissionStatus.permanentlyDenied) {
          final openSetting = await bottomDialog(
            'BKAV sme muốn sử dụng camera',
            'Điều này sẽ cho phép ứng dụng sử dụng camera',
            context,
          );
          if (openSetting == true) {
            await openAppSettings();
          }
        } else if (request[Permission.camera] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
        } else if (request[Permission.camera] == PermissionStatus.granted) {
          return await getImage(ImageSource.camera);
        }
      }
    } else if (Platform.isIOS) {
      if (type == 'gallery') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.photos].request();
        if (request[Permission.photos] != PermissionStatus.granted) {
          final openSetting = await bottomDialog(
            'BKAV sme muốn truy cập thư viện của bạn',
            'Điều này sẽ cho phép ứng dụng truy cập thư viện của bạn',
            context,
          );
          if (openSetting == true) {
            await openAppSettings();
          }
        } else if (request[Permission.photos] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
        } else if (request[Permission.photos] == PermissionStatus.granted) {
          return await getImage(ImageSource.gallery);
        }
      }
      if (type == 'camera') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.camera].request();
        if (request[Permission.camera] == PermissionStatus.permanentlyDenied) {
          final openSetting = await bottomDialog(
            'BKAV sme muốn sử dụng camera',
            'Điều này sẽ cho phép ứng dụng sử dụng camera',
            context,
          );
          if (openSetting == true) {
            await openAppSettings();
          }
        } else if (request[Permission.camera] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
        } else if (request[Permission.camera] == PermissionStatus.granted) {
          return await getImage(ImageSource.camera);
        }
      }
    }
  }

  static Future<File?> getImage(ImageSource imageSource) async {
    try {
      final pickedFile =
          await picker.pickImage(source: imageSource, imageQuality: 100);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<bool> bottomDialog(
      String title, String content, BuildContext context) async {
    final bool openSetting = await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Không cho phép'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('Cho phép'),
          ),
        ],
      ),
    );
    return openSetting;
  }

  static Future bottomErrorDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
          title: Text('Có lỗi xảy ra!'),
          content: Text('Quyền truy cập đã bị từ chối.'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, false),
              child: Text('OK'),
            ),
          ]),
    );
  }
}
