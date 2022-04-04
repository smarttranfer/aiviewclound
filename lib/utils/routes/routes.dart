import 'package:aiviewcloud/ui/account_management/account_management.dart';
import 'package:aiviewcloud/ui/account_management/login_info.dart';
import 'package:aiviewcloud/ui/add_device_final.dart';
import 'package:aiviewcloud/ui/add_device_info.dart';
import 'package:aiviewcloud/ui/add_device_progress.dart';
import 'package:aiviewcloud/ui/add_device_step_2.dart';
import 'package:aiviewcloud/ui/add_device_success.dart';
import 'package:aiviewcloud/ui/add_url.dart';
import 'package:aiviewcloud/ui/change_password.dart';
import 'package:aiviewcloud/ui/confirm_attach_device.dart';
import 'package:aiviewcloud/ui/device-list.dart';
import 'package:aiviewcloud/ui/device_management/add_device.dart';
import 'package:aiviewcloud/ui/device_management/add_device_by_qrcode.dart';
import 'package:aiviewcloud/ui/device_management/add_device_progressing.dart';
import 'package:aiviewcloud/ui/device_management/device_info_checking.dart';
import 'package:aiviewcloud/ui/device_management/device_information.dart';
import 'package:aiviewcloud/ui/device_management/device_management.dart';
import 'package:aiviewcloud/ui/enter_confirm_code.dart';
import 'package:aiviewcloud/ui/findcountry.dart';
import 'package:aiviewcloud/ui/forgot_password.dart';
import 'package:aiviewcloud/ui/home/home.dart';
import 'package:aiviewcloud/ui/language.dart';
import 'package:aiviewcloud/ui/library/library_screen.dart';
import 'package:aiviewcloud/ui/list_live_cam.dart';
import 'package:aiviewcloud/ui/live_by_lan.dart';
import 'package:aiviewcloud/ui/live_cam.dart';
import 'package:aiviewcloud/ui/login.dart';
import 'package:aiviewcloud/ui/new_password.dart';
import 'package:aiviewcloud/ui/policy.dart';
import 'package:aiviewcloud/ui/register.dart';
import 'package:aiviewcloud/ui/register_by_phone.dart';
import 'package:aiviewcloud/ui/remote_ptz.dart';
import 'package:aiviewcloud/ui/remote_ptz_for_lan.dart';
import 'package:aiviewcloud/ui/search_device.dart';
import 'package:aiviewcloud/ui/searching_device.dart';
import 'package:aiviewcloud/ui/settings/page/help_page.dart';
import 'package:aiviewcloud/ui/settings/page/security_account.dart';
import 'package:aiviewcloud/ui/settings/settings_screen.dart';
import 'package:aiviewcloud/ui/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String policy = '/policy';
  static const String home = '/home';
  static const String forgotPassword = '/forgotPassword';
  static const String enterComfirmationCode = '/confirmCode';
  static const String newPassword = '/newPassword';
  static const String viewLan = '/viewLan';
  static const String language = '/language';
  static const String searchingDevice = '/searchingDevice';
  static const String searchDevice = '/searchDevice';
  static const String deviceList = '/deviceList';
  static const String register = '/register';
  static const String registerByEmail = '/registerByEmail';
  static const String registerByPhone = '/registerByPhone';
  static const String liveCam = '/liveCam';
  static const String ptzControl = '/ptzControl';
  static const String liveCamList = '/liveCamList';
  static const String findCountry = '/findCountry';
  static const String account = '/account';
  static const String deviceManagement = '/deviceManagement';
  static const String addDevice = '/addDevice';
  static const String addDeviceStep2 = '/addDeviceStep2';
  static const String confirmAttachDevice = '/confirmAttachDevice';
  static const String addDeviceInfo = '/addDeviceInfo';
  static const String addDeviceProgress = '/addDeviceProgress';
  static const String addDeviceFinal = '/addDeviceFinal';
  static const String addDeviceSuccess = '/addDeviceSuccess';
  static const String addDeviceByQRCodeScreen = '/addDeviceByQRCodeScreen';
  static const String addUrl = '/addUrl';
  static const String changePassword = '/changePassword';
  static const String deviceInfoChecking = '/deviceInfoChecking';
  static const String addDeviceProgressing = '/addDeviceProgressing';
  static const String deviceInformation = '/deviceInformation';
  static const String libraryScreen = '/libraryScreen';
  static const String LoginInfoScreen = '/loginInfoScreen';
  static const String settingScreen = '/settingsScreen';
  static const String securityPage = '/securityPage';
  static const String helpPage = '/helpPage';
  static const String lanPtzControl = '/lanPtzControl';
  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    LoginInfoScreen: (BuildContext context) => LoginInfo(),
    settingScreen: (BuildContext context) => SettingScreen(),
    securityPage: (BuildContext context) => SecurityAccount(),
    helpPage: (BuildContext context) => HelpPage(),
    login: (BuildContext context) => LoginScreen(),
    policy: (BuildContext context) => PolicyScreen(),
    forgotPassword: (BuildContext context) => ForgotPassword(),
    changePassword: (BuildContext context) => ChangePasswordScreen(),
    home: (BuildContext context) => HomeScreen(),
    enterComfirmationCode: (BuildContext context) => ConfirmationCode(),
    newPassword: (BuildContext context) => NewPassword(),
    language: (BuildContext context) => LanguageScreen(),
    viewLan: (BuildContext context) => ViewByLan(),
    searchingDevice: (BuildContext context) => SearchingDeviceScreen(),
    searchDevice: (BuildContext context) => SearchDevice(),
    deviceList: (BuildContext context) => DeviceListScreen(),
    register: (BuildContext context) => RegisterScreen(),
    registerByPhone: (BuildContext context) => RegisterByPhoneScreen(),
    liveCam: (BuildContext context) => LiveCamScreen(),
    ptzControl: (BuildContext context) => PTZControlScreen(),
    lanPtzControl: (BuildContext context) => LanPTZControlScreen(),
    liveCamList: (BuildContext context) => LiveCamList(),
    findCountry: (BuildContext context) => FindCountry(),
    account: (BuildContext context) => AccountManagement(),
    deviceManagement: (BuildContext context) => DeviceManagement(),
    addUrl: (BuildContext context) => AddUrlScreen(),
    addDevice: (BuildContext context) => AddDeviceScreen(),
    addDeviceStep2: (BuildContext context) => AddDeviceStep2Screen(),
    confirmAttachDevice: (BuildContext context) => ConfirmAttachDevice(),
    addDeviceInfo: (BuildContext context) => AddDeviceInfo(),
    addDeviceProgress: (BuildContext context) => AddDeviceProgress(),
    addDeviceFinal: (BuildContext context) => AddDeviceFinal(),
    addDeviceSuccess: (BuildContext context) => AddDeviceSuccess(),
    addDeviceByQRCodeScreen: (BuildContext context) =>
        AddDeviceByQRCodeScreen(),
    deviceInfoChecking: (BuildContext context) => DeviceInfoChecking(),
    addDeviceProgressing: (BuildContext context) => AddDeviceProgressing(),
    deviceInformation: (BuildContext context) => DeviceInformation(),
    libraryScreen: (BuildContext context) => LibraryScreen(),
  };
}
