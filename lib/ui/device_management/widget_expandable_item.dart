import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/models/region/region.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ExpandableItem extends StatefulWidget {
  final String title;
  final ValueChanged onCheckValue;
  final bool isVisibleArrow;
  final List<Region>? listRegion;
  final int currentLevel;
  final Region currentRegion;
  final bool select;

  ExpandableItem({
    Key? key,
    required this.title,
    required this.onCheckValue,
    this.isVisibleArrow = true,
    this.listRegion,
    required this.currentLevel,
    required this.currentRegion,
    required this.select,
  }) : super(key: key);

  @override
  _ExpandableItemState createState() => new _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool expandFlag = false;

  late bool isCheck;

  List<Region> listLevelRegion = [];

  List<Region> listChildLevelRegion = [];

  late CameraP2PStore _cameraP2PStore;

  @override
  void didUpdateWidget(covariant ExpandableItem oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget.select != widget.select) {
      setState(() {
        if (widget.select) {
          expandFlag = true;
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    isCheck = widget.select;
    listLevelRegion = widget.listRegion!
        .where((element) =>
            element.level == widget.currentLevel + 1 &&
            element.parentId == widget.currentRegion.regionId)
        .toList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    _cameraP2PStore.regionList.forEach((element) {
      if (element.level == widget.currentLevel + 2) {
        listChildLevelRegion.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Visibility(
                visible: widget.isVisibleArrow,
                child: IconButton(
                    icon: Icon(
                      expandFlag ? Icons.arrow_drop_down : Icons.arrow_right,
                      color: AppColors.mGreyColor1,
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expandFlag = !expandFlag;
                    });
                  },
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontFamily.sfProDisplay,
                      fontSize: 14,
                      color: _cameraP2PStore.selectedFilterItems
                              .map((element) => element.regionId)
                              .toList()
                              .contains(widget.currentRegion.regionId)
                          ? AppColors.mOrangeColor
                          : AppColors.mWhiteColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  widget.onCheckValue(widget.currentRegion);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _cameraP2PStore.selectedFilterItems
                          .map((element) => element.regionId)
                          .toList()
                          .contains(widget.currentRegion.regionId)
                      ? SvgPicture.asset(Assets.checked)
                      : SvgPicture.asset(Assets.unchecked),
                ),
              )
            ],
          ),
          Visibility(
            visible: expandFlag,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 4),
                itemCount: listLevelRegion.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ExpandableItem(
                    currentLevel: widget.currentLevel + 1,
                    currentRegion: listLevelRegion[index],
                    title: listLevelRegion[index].regionName,
                    listRegion: widget.listRegion,
                    isVisibleArrow: true,
                    onCheckValue: (check) {
                      setState(() {
                        if (!_cameraP2PStore
                            .checkSelect(listLevelRegion[index])) {
                          isCheck = !isCheck;
                          _cameraP2PStore
                              .observerSelectFilter(listLevelRegion[index]);
                          _cameraP2PStore.selectFatherFilter(
                              thisRegions: listLevelRegion,
                              parentRegion: widget.listRegion!,
                              region: listLevelRegion[index]);
                          _cameraP2PStore.selectChildrenFilter(
                              listLevelRegion[index].regionId,
                              listChildLevelRegion);
                        } else {
                          isCheck = !isCheck;
                          _cameraP2PStore
                              .unselectFilter(listLevelRegion[index]);
                          _cameraP2PStore.unSelectChildrenFilter(
                              listLevelRegion[index].regionId,
                              listChildLevelRegion);
                          _cameraP2PStore.unselectParent(
                              listLevelRegion[index].parentId!,
                              widget.listRegion!);
                        }
                      });
                      // setState(() {
                      //   _cameraP2PStore.observerSelectFilter(check);
                      //   listChildLevelRegion.forEach((element) {
                      //     if (element.parentId ==
                      //         listLevelRegion[index].regionId) {
                      //       _cameraP2PStore.observerSelectFilter(element);
                      //     }
                      //   });
                      // });
                    },
                    select: isCheck,
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 16, top: 0, bottom: 0),
                  child: Divider(
                    color: AppColors.mGreyColor1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
