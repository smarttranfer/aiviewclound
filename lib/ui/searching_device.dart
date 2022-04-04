import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aiviewcloud/di/module/ws-discovery/Model/probe_match.dart';
import 'package:aiviewcloud/di/module/ws-discovery/sme_discovery.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/bottom_sheet_modal_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/loading_icon_widget.dart';
import 'package:flutter/material.dart';

class SearchingDeviceScreen extends StatefulWidget {
  @override
  _SearchingDeviceScreenState createState() => _SearchingDeviceScreenState();
}

class _SearchingDeviceScreenState extends State<SearchingDeviceScreen> {
  List<ProbeMatch?> deviceList = [];
  bool loading = true;
  late SMEWS onvif;
  @override
  void initState() {
    super.initState();
    onvif = SMEWS();
    initSocket();
  }

  void initSocket() async {
    onvif.getDevices((device) {
      setState(() {
        deviceList = device;
        loading = false;
      });
    });
  }

  Future<void> _pullRefresh() async {
    initSocket();
  }

  onShowBottomModal(index) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                  height: 410,
                  child: BottomSheetModalWidget(
                      context: context, address: deviceList[index]!.xAddrs)));
        });
  }

  Widget buildItem(context, index) {
    final uri = Uri.parse(deviceList[index]!.xAddrs!);
    return GestureDetector(
        onTap: () {
          onShowBottomModal(index);
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16),
            child: Row(children: [
              Container(
                  width: 42.w,
                  height: 42.w,
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(right: 16.w),
                  child: SvgPicture.string(
                    camera,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.contain,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: const Color(0xff403634))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child:
                        // Adobe XD layer: 'Mã Model; Seri Numb…' (text)

                        Text('${deviceList[index]!.serialNumber}',
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "SFProDisplay",
                                fontStyle: FontStyle.normal,
                                fontSize: 17.0),
                            textAlign: TextAlign.left),
                  ),
                  Container(
                    child:
                        // Adobe XD layer: 'ID; Port' (text)
                        Text('${uri.host}:${uri.port}',
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProDisplay",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.left),
                  ),
                ],
              )
            ]),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: const Color(0xff2b2f33))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: Column(
        children: <Widget>[
          HeaderWidget(
              headerText:
                  AppLocalizations.of(context).translate('searching_device')),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LoadingIcon(),

                      // Adobe XD layer: 'Đang quét thiết bị …' (text)
                      Text(
                        AppLocalizations.of(context).translate('lan_searching'),
                        style: TextStyle(
                          fontFamily: 'SFProDisplay-Regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Container(
                    child: RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 0),
                            itemCount: deviceList.length,
                            itemBuilder: (BuildContext ctxt, int index) =>
                                buildItem(context, index)))),
          )
        ],
      ),
    );
  }
}

String camera =
    '<svg width="22" height="16" viewBox="0 0 22 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path opacity="0.4" d="M20.723 2.6056C20.2761 2.32404 19.7268 2.29914 19.2585 2.53738L17.6777 3.33548C17.0931 3.63003 16.7305 4.22563 16.7305 4.88837V11.1108C16.7305 11.7735 17.0931 12.368 17.6777 12.6648L19.2574 13.4618C19.4718 13.5722 19.7012 13.6253 19.9305 13.6253C20.2057 13.6253 20.4788 13.5473 20.723 13.3946C21.17 13.1142 21.4366 12.6279 21.4366 12.0951V3.90617C21.4366 3.37338 21.17 2.88716 20.723 2.6056Z" fill="#FD7B38"/><path d="M10.5654 16H4.38724C1.80375 16 0 14.2186 0 11.6684V4.33164C0 1.7803 1.80375 0 4.38724 0H10.5654C13.1489 0 14.9527 1.7803 14.9527 4.33164V11.6684C14.9527 14.2186 13.1489 16 10.5654 16Z" fill="#FD7B38"/></svg>';
