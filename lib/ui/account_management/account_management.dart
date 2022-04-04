import 'dart:io';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/stores/global/global_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/ui/account_management/widget/bottom_sheet_change_name.dart';
import 'package:aiviewcloud/ui/account_management/widget/bottom_sheet_country.dart';
import 'package:aiviewcloud/ui/account_management/widget/bottom_sheet_logout.dart';
import 'package:aiviewcloud/ui/account_management/widget/item_account.dart';
import 'package:aiviewcloud/utils/device/media_permission.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AccountManagement extends StatefulWidget {
  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  late UserStore _store;
  late CameraP2PStore _cameraP2PStore;
  late GlobalStore _globalStore;

  final picker = ImagePicker();
  File avatarUrl = File('');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<UserStore>(context);
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    _globalStore = Provider.of<GlobalStore>(context);
  }

  showAlertDialog(BuildContext context) {
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
                height: 320.h,
                child: BottomSheetLogoutWidget(
                  onClickNo: () {
                    Navigator.pop(context);
                  },
                  onClickYes: () {
                    onLogout();
                  },
                ),
              ),
            ),
          );
        });
    return SizedBox.shrink();
  }

  showChangeAvaDialog(BuildContext context) {
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
                height: 200.h,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                  color: const Color(0xff212529),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1a000000),
                      offset: Offset(0, 0),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 90.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        var file =
                            await MediaPermission.checkPermissionAndPickImage(
                                'camera', context);
                        if (file != null) {
                          setState(() {
                            avatarUrl = file;
                            _store.changeAvatar(avatarUrl).then((value) {
                              setState(() {});
                            });
                          });
                        } else {
                          print('no image');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.icPicture),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('take_photo'),
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 19.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.6,
                      height: 1.0,
                    ),
                    InkWell(
                      onTap: () async {
                        var status = await Permission.storage.status;
                        if (status.isDenied) {
                          openAppSettings();
                        }
                        if (status.isGranted) {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);
                          if (pickedFile != null) {
                            // cropImage(pickedFile.path);
                          }
                        }
                        if (status.isRestricted) {
                          await bottomErrorDialog();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.icImage),
                            Text(
                              AppLocalizations.of(context).translate('upload'),
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 19.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    return SizedBox.shrink();
  }

  showChangeName() {
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
                height: 400.h,
                child: BottomSheetChangeNameWidget(
                  name: _store.user?.fullName ?? "",
                ),
              ),
            ),
          );
        }).then((value) {
      setState(() {});
    });
    return SizedBox.shrink();
  }

  showPickCountry() {
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
                height: 600.h,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                  color: const Color(0xff212529),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1a000000),
                      offset: Offset(0, 0),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: BottomSheetFindCountry(),
              ),
            ),
          );
        });
    return SizedBox.shrink();
  }

  // void cropImage(String filePath) async {
  //   File? _croppedImage = await ImageCropper.cropImage(
  //     sourcePath: filePath,
  //     androidUiSettings: AndroidUiSettings(
  //         activeControlsWidgetColor: Colors.blue,
  //         cropFrameColor: Colors.blue,
  //         toolbarTitle: AppLocalizations.of(context).translate('cut_photo'),
  //         toolbarColor: Colors.black,
  //         toolbarWidgetColor: Colors.white,
  //         lockAspectRatio: false),
  //     iosUiSettings: IOSUiSettings(
  //       title: AppLocalizations.of(context).translate('cut_photo'),
  //     ),
  //   );
  //   if (_croppedImage != null) {
  //     setState(() {
  //       avatarUrl = _croppedImage;
  //       _store.changeAvatar(avatarUrl).then((value) {
  //         setState(() {});
  //       });
  //     });
  //   }
  // }

  Future bottomErrorDialog() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context).translate('error_occur')),
          content: Text(AppLocalizations.of(context).translate('blocked')),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, false),
              child: Text(AppLocalizations.of(context).translate('Ok')),
            ),
          ]),
    );
  }

  void onLogout() async {
    Navigator.pop(context);
    _cameraP2PStore.clearCameraList();

    await _store.logout();
    _globalStore.setRoute(Preferences.drawerDeviceManagement);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showChangeAvaDialog(context);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h, top: 16.h),
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(58.5),
              image: DecorationImage(
                image: const AssetImage(Assets.defaultAvatar),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(58.5),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                imageUrl: _store.user?.urlAvatar ?? '',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage(Assets.defaultCamera),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Text(
                  _store.user?.fullName ?? _store.user?.userName ?? '',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 17,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: showChangeName,
              child: Container(
                width: 24,
                height: 24,
                padding: EdgeInsets.all(6.sp),
                margin: EdgeInsets.only(left: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xfffd7b38),
                ),
                child: Container(
                  width: 12.003278732299805,
                  height: 12,
                  child: SvgPicture.string(
                    pencil,
                    width: 12,
                    height: 12,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        ItemAccount(
          onClick: () {
            Navigator.of(context).pushNamed(Routes.LoginInfoScreen);
          },
          title: AppLocalizations.of(context).translate('login_info'),
          icon: SvgPicture.string(
            info,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.contain,
          ),
        ),
        ItemAccount(
          onClick: () {
            showPickCountry();
          },
          title: AppLocalizations.of(context).translate('country'),
          icon: SvgPicture.string(
            earth,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.contain,
          ),
        ),
        ItemAccount(
          onClick: () {
            Navigator.of(context).pushNamed(Routes.changePassword);
          },
          title: AppLocalizations.of(context).translate('change_pwd'),
          icon: SvgPicture.string(
            changePwd,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.contain,
          ),
        ),
        ItemAccount(
          onClick: () {
            showAlertDialog(context);
          },
          title: AppLocalizations.of(context).translate('logout'),
          icon: SvgPicture.string(
            logout,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      drawer: SMEDrawer(),
      body: ScreenWidget(
        widget: buildBody(),
        headerText: AppLocalizations.of(context).translate('Quản lý tài khoản'),
        isDrawer: true,
      ),
    );
  }
}

const String pencil =
    '<svg width="13" height="12" viewBox="0 0 13 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0.661263 12C0.476502 11.9997 0.300371 11.9218 0.175843 11.7853C0.0490184 11.6499 -0.0140013 11.4668 0.00261996 11.2821L0.163987 9.5077L7.6185 2.05581L9.94812 4.38477L2.49558 11.836L0.721199 11.9974C0.700781 11.9993 0.680363 12 0.661263 12ZM10.4131 3.91911L8.08417 1.59015L9.48115 0.193171C9.60469 0.0694931 9.77233 0 9.94714 0C10.1219 0 10.2896 0.0694931 10.4131 0.193171L11.8101 1.59015C11.9338 1.71369 12.0033 1.88133 12.0033 2.05614C12.0033 2.23095 11.9338 2.39859 11.8101 2.52213L10.4131 3.91911Z" fill="white"/></svg>';
const String info =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 24C5.37258 24 0 18.6274 0 12C0 5.37258 5.37258 0 12 0C18.6274 0 24 5.37258 24 12C23.9927 18.6244 18.6244 23.9927 12 24ZM9.588 10.788V13.2H10.788V18H14.412V15.6H13.2L13.212 10.7892L9.588 10.788ZM10.788 6V8.4228H13.212V6H10.788Z" fill="#FD7B38"/></svg>';
const String changePwd =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect width="24" height="24" rx="12" fill="#FD7B38"/><path d="M15.7999 10.9497H8.09999C7.49248 10.9497 7 11.4422 7 12.0497V15.8997C7 16.5072 7.49248 16.9997 8.09999 16.9997H15.7999C16.4074 16.9997 16.8999 16.5072 16.8999 15.8997V12.0497C16.8999 11.4422 16.4074 10.9497 15.7999 10.9497Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M9.20013 10.95V8.74998C9.20013 8.02064 9.48986 7.32117 10.0056 6.80545C10.5213 6.28973 11.2208 6 11.9501 6C12.6795 6 13.3789 6.28973 13.8946 6.80545C14.4104 7.32117 14.7001 8.02064 14.7001 8.74998V10.95" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
const String earth =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect width="24" height="24" rx="12" fill="#4AA541"/><path d="M12 17.8332C15.2217 17.8332 17.8333 15.2215 17.8333 11.9998C17.8333 8.77818 15.2217 6.1665 12 6.1665C8.77834 6.1665 6.16667 8.77818 6.16667 11.9998C6.16667 15.2215 8.77834 17.8332 12 17.8332Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M6.16667 12H17.8333" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12 6.1665C13.4591 7.76388 14.2883 9.83686 14.3333 11.9998C14.2883 14.1628 13.4591 16.2358 12 17.8332C10.5409 16.2358 9.71173 14.1628 9.66667 11.9998C9.71173 9.83686 10.5409 7.76388 12 6.1665V6.1665Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
const String logout =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect width="24" height="24" rx="12" fill="#FD413C"/><path d="M15.6667 18H9.66667C8.93029 18 8.33333 17.403 8.33333 16.6667V14H9.66667V16.6667H15.6667V7.33333H9.66667V10H8.33333V7.33333C8.33333 6.59695 8.93029 6 9.66667 6H15.6667C16.403 6 17 6.59695 17 7.33333V16.6667C17 17.403 16.403 18 15.6667 18ZM11 14.6667V12.6667H5V11.3333H11V9.33333L14.3333 12L11 14.6667Z" fill="white"/></svg>';
