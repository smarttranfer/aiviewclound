import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/models/region/region.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/ui/device_management/widget_expandable_item.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetListFilter extends StatefulWidget {
  const WidgetListFilter({
    Key? key,
    required this.listPrimaryRegion,
    required this.search,
  }) : super(key: key);

  final List<Region> listPrimaryRegion;
  final TextEditingController search;

  @override
  _WidgetListFilterState createState() => _WidgetListFilterState();
}

class _WidgetListFilterState extends State<WidgetListFilter> {
  final List<Region> listRegion1 = [];

  late CameraP2PStore _cameraP2PStore;

  final List<Region> listRegion2 = [];

  List<bool> selectAllList = [];
  //bool selectAll = false;

  @override
  void initState() {
    widget.listPrimaryRegion.forEach((element) {
      if (element.level == 1) {
        listRegion1.add(element);
        selectAllList.add(false);
      }
    });
    widget.listPrimaryRegion.forEach((element) {
      if (element.level == 2) {
        listRegion2.add(element);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: listRegion1.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpandableItem(
                title: listRegion1[index].regionName,
                currentRegion: listRegion1[index],
                listRegion: widget.listPrimaryRegion,
                currentLevel: listRegion1[index].level ?? 1,
                isVisibleArrow: true,
                onCheckValue: (value) {
                  selectAllList[index] = !selectAllList[index];
                  if (selectAllList[index]) {
                    _cameraP2PStore.observerSelectFilter(listRegion1[index]);
                    _cameraP2PStore.selectChildrenFilter(
                        listRegion1[index].regionId, listRegion2);
                  } else {
                    _cameraP2PStore.unselectFilter(listRegion1[index]);
                    _cameraP2PStore.unSelectChildrenFilter(
                        listRegion1[index].regionId, listRegion2);
                  }
                },
                select: selectAllList[index],
              );
            },
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: AppColors.mGreyColor1,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SMEButton(
              title: AppLocalizations.of(context).translate('select'),
              onPress: () {
                _cameraP2PStore.refresh(
                    keyName: widget.search.text,
                    keyRegionGuid: _cameraP2PStore.keyRegionGuid);
                _cameraP2PStore.popFilter();
              },
            )

            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       _cameraP2PStore.refresh(
            //           keyName: widget.search.text,
            //           keyRegionGuid: _cameraP2PStore.keyRegionGuid);
            //       _cameraP2PStore.popFilter();
            //     },
            //     child: Text("Lựa chọn"),
            //   ),
            // ),
            )
      ],
    );
  }
}
