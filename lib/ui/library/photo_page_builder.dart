import 'dart:io';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/stores/library/library_store.dart';
import 'package:aiviewcloud/ui/library/dialog_app.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/drawer_header_widget.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'library_screen.dart';
import 'locally_available_builder.dart';

class ImagePageBuilder extends StatefulWidget {
  const ImagePageBuilder({
    Key? key,
    required this.asset,
    this.hasOnlyOneVideoAndMoment = false,
    required this.libraryStore,
  }) : super(key: key);

  final AssetEntity asset;
  final LibraryStore libraryStore;

  final bool hasOnlyOneVideoAndMoment;

  @override
  _ImagePageBuilderState createState() => _ImagePageBuilderState();
}

class _ImagePageBuilderState extends State<ImagePageBuilder> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mGreyColor3,
      drawer: SMEDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            DrawerHeaderWidget(
              headerText: AppLocalizations.of(context).translate('view_detail'),
              leftWidget: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.mWhiteColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              rightWidget: IconButton(
                  onPressed: () {
                    onShowDialog(
                      context: context,
                      onShare: () async {
                        Navigator.pop(context);
                        Share.shareFiles([widget.asset.relativePath!],
                            subject: 'Chia sẻ file');
                      },
                      onDelete: () {
                        Navigator.pop(context);
                        DialogApp.deleteVideoAndImageBottomSheet(
                          context,
                          yesCallBack: () {
                            Navigator.pop(context);
                            widget.libraryStore
                                .deleteAAssetEntity(widget.asset)
                                .then((isDeleted) {
                              if (isDeleted) {
                                Navigator.pop(context);
                              }
                            });
                          },
                        );
                      },
                      onSave: () {
                        widget.libraryStore.saveAssetEntity(widget.asset);
                      },
                    );
                  },
                  icon: SvgPicture.asset(Assets.icVerticalDots)),
            ),
            Expanded(
              child: InteractiveViewer(
                panEnabled: false,
                minScale: 0.1,
                maxScale: 2,
                constrained: true,
                child: Image.file(
                  File(widget.asset.relativePath!),
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
