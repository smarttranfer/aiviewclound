import 'dart:io';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/stores/library/library_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/drawer_header_widget.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'dialog_app.dart';
import 'group_media.dart';

TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

class LibraryScreen extends StatefulWidget {
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final LibraryStore _libraryStore = LibraryStore();
  late UserStore _userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _libraryStore.getMediaList(_userStore);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mGreyColor3,
      drawer: SMEDrawer(),
      body: SafeArea(
        child: Observer(builder: (context) {
          return Column(
            children: [
              DrawerHeaderWidget(
                headerText: AppLocalizations.of(context).translate('library'),
                rightWidget: IconButton(
                  onPressed: () {
                    if (!_libraryStore.isEdit) {
                      _libraryStore.clearSelectedEntityList();
                    } else {
                      onShowDialog(
                        context: context,
                        onShare: () async {
                          Navigator.pop(context);
                          if (_libraryStore.selectedAssetEntityList.isEmpty) {
                            DialogApp.errorDialog(
                                context,
                                AppLocalizations.of(context)
                                    .translate('not_choose_image'));
                          } else {
                            List<String> filePaths =
                                await getSelectedFilePaths();
                            Share.shareFiles(filePaths,
                                subject: AppLocalizations.of(context)
                                    .translate('file_share'));
                          }
                        },
                        onDelete: () {
                          Navigator.pop(context);
                          if (_libraryStore.selectedAssetEntityList.isEmpty) {
                            DialogApp.errorDialog(
                                context, 'Bạn chưa chọn ảnh để xoá!');
                          } else {
                            DialogApp.deleteVideoAndImageBottomSheet(
                              context,
                              yesCallBack: () {
                                Navigator.pop(context);
                                _libraryStore.deleteSelectedAssetEntities();
                              },
                            );
                          }
                        },
                        onSave: () {
                          Navigator.pop(context);
                          if (_libraryStore.selectedAssetEntityList.isEmpty) {
                            DialogApp.errorDialog(
                                context, 'Bạn chưa chọn ảnh để lưu!');
                          } else {
                            _libraryStore.downloadSelectedAssetEntities();
                          }
                        },
                      );
                    }
                    _libraryStore.edit(true);
                  },
                  icon: Container(
                    child: _libraryStore.isEdit
                        ? SvgPicture.asset(Assets.icVerticalDots)
                        : SvgPicture.asset(Assets.icRotatePen),
                  ),
                ),
              ),
              Visibility(
                visible: _libraryStore.isEdit,
                child: true
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_libraryStore.isSelectedAll) {
                                      _libraryStore.clearSelectedEntityList();
                                    } else {
                                      _libraryStore.selectAllAssetEntityList();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 8),
                                    child: _libraryStore.isSelectedAll
                                        ? SvgPicture.asset(Assets.checked)
                                        : SvgPicture.asset(Assets.unchecked),
                                  ),
                                ),
                                Text(
                                  'Tất cả (${_libraryStore.selectedAssetEntityList.length})',
                                  style: TextStyle(
                                      fontFamily: FontFamily.sfProDisplay,
                                      fontSize: 17,
                                      color: AppColors.mWhiteColor),
                                )
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    _libraryStore.edit(false);
                                  },
                                  customBorder: const CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('Hủy'),
                                      style: TextStyle(
                                        fontFamily: FontFamily.sfProDisplay,
                                        fontSize: 17,
                                        color: AppColors.mRedColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8)
                          ],
                        ),
                      )
                    : SvgPicture.asset(Assets.unchecked),
              ),
              Expanded(
                  child: _libraryStore.mediaList.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: Container(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('photo_empty'),
                              style: textStyle,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _libraryStore.mediaList.length,
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 30),
                          itemBuilder: (context, index) {
                            return GroupMedia(
                              index: index,
                              listAssets:
                                  _libraryStore.mediaList[index].listMedia,
                              createdTime:
                                  _libraryStore.mediaList[index].createdTime,
                              libraryStore: _libraryStore,
                            );
                          },
                        ))
            ],
          );
        }),
      ),
    );
  }

  Future<List<String>> getSelectedFilePaths() async {
    List<String> filePaths = [];
    for (AssetEntity entity in _libraryStore.selectedAssetEntityList) {
      File file = File(entity.relativePath!);
      filePaths.add(file.path);
    }
    return filePaths;
  }
}

onShowDialog({
  required BuildContext context,
  required VoidCallback onShare,
  required VoidCallback onDelete,
  required VoidCallback onSave,
}) {
  showDialog(
    context: context,
    useSafeArea: false,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.8),
    builder: (_) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.none,
          child: Stack(
            children: [
              Positioned(
                top: 80.h,
                right: 16,
                child: Container(
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.mGreyColor2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: onSave,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: SvgPicture.asset(Assets.icSave),
                              ),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('download'),
                                  style: textStyle),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onShare,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: SvgPicture.asset(Assets.icShare),
                              ),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('share'),
                                  style: textStyle),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onDelete,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: SvgPicture.asset(
                                  Assets.trash,
                                  color: AppColors.mRedColor,
                                ),
                              ),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('delete'),
                                  style: textStyle),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
