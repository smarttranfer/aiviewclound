import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/stores/library/library_store.dart';
import 'package:aiviewcloud/ui/library/photo_page_builder.dart';
import 'package:aiviewcloud/ui/library/video_page_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_manager/photo_manager.dart';

import 'media_item.dart';

class GroupMedia extends StatelessWidget {
  final List<AssetEntity> listAssets;
  final DateTime createdTime;
  final int index;
  final LibraryStore libraryStore;

  const GroupMedia({
    Key? key,
    required this.listAssets,
    required this.createdTime,
    required this.index,
    required this.libraryStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 16, bottom: 8),
          child: Text(
            '${formatCreateDate(createdTime)}',
            style: TextStyle(
              fontFamily: FontFamily.sfProDisplay,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.mWhiteColor,
            ),
          ),
        ),
        GridView.builder(
          itemCount: listAssets.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            crossAxisCount: isPortrait ? 3 : 6,
          ),
          itemBuilder: (context, index) {
            return buildAssetItem(listAssets[index], context);
          },
        ),
      ],
    );
  }

  Widget buildAssetItem(AssetEntity entity, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (libraryStore.isEdit) {
          libraryStore.selectMedia(entity);
        } else {
          if (entity.type == AssetType.video) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VideoPageBuilder(
                    asset: entity,
                    libraryStore: libraryStore,
                  );
                },
              ),
            );
          }
          if (entity.type == AssetType.image) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ImagePageBuilder(
                    asset: entity,
                    libraryStore: libraryStore,
                  );
                },
              ),
            );
          }
        }
      },
      child: Observer(builder: (context) {
        return MediaItemWidget(
          isVisibleCheck: libraryStore.isEdit,
          key: ValueKey(entity),
          entity: entity,
          checkStatus: libraryStore.selectedAssetEntityList
              .map((entity) => entity.id)
              .toList()
              .contains(entity.id),
        );
      }),
    );
  }

  String formatCreateDate(DateTime createdTime) {
    DateTime now = DateTime.now();
    int differentDay =
        createdTime.difference(DateTime(now.year, now.month, now.day)).inDays;
    if (differentDay == -1) {
      return 'Hôm qua';
    }
    if (differentDay == 0) {
      return 'Hôm nay';
    }
    return '${createdTime.day}/${createdTime.month}/${createdTime.year}';
  }
}
