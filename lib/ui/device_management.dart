import 'package:adobe_xd/pinned.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/drawer_header_widget.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:aiviewcloud/widgets/icon_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceManagement extends StatefulWidget {
  @override
  _DeviceManagementState createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  Offset offset = Offset.zero;

  late CameraP2PStore _cameraP2PStore;
  bool showOptions = false;
  @override
  void initState() {
    super.initState();
    // postData(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    if (!_cameraP2PStore.loading) {
      _cameraP2PStore.getCameraList({"CurrentPage": 1, "PageSize": 40});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// viết lại đoạn logic phần này sửa lại cả giao diện nữa đoạn này về build duyêtj
  /// logic duyệt list này họ đang viết sai thiếu phần tử list[0] trong
  Widget _buildListView() {
    return _cameraP2PStore.cameraP2PList != null
        ? ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: _cameraP2PStore.cameraP2PList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              if (index == 0) {
                return Container(
                    height: 48 + 16 + 30,
                    child: Stack(children: [
                      Pinned.fromPins(
                        Pin(end: 106, start: 16.0),
                        Pin(size: 48.0, start: 0.0),
                        child:
                            // Adobe XD layer: 'Group 6581' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1861' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: const Color(0xff2b2f33),
                                ),
                              ),
                            ),
                            // Pinned.fromPins(
                            //   Pin(size: 16.8, start: 16.8),
                            //   Pin(size: 16.0, middle: 0.5),
                            //   child:
                            //       // Adobe XD layer: 'Group 6632' (group)
                            //       Stack(
                            //     children: <Widget>[
                            //       Pinned.fromPins(
                            //         Pin(start: 0.0, end: 1.9),
                            //         Pin(start: 0.0, end: 1.8),
                            //         child:
                            //             // Adobe XD layer: 'Vector' (shape)
                            //             SvgPicture.string(
                            //           _svg_e1w4px,
                            //           allowDrawingOutsideViewBox: true,
                            //           fit: BoxFit.fill,
                            //         ),
                            //       ),
                            //       Pinned.fromPins(
                            //         Pin(size: 4.1, end: 0.0),
                            //         Pin(size: 3.9, end: 0.0),
                            //         child:
                            //             // Adobe XD layer: 'Vector' (shape)
                            //             SvgPicture.string(
                            //           _svg_rtvfq5,
                            //           allowDrawingOutsideViewBox: true,
                            //           fit: BoxFit.fill,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Pinned.fromPins(
                              Pin(size: 57.9, middle: 0.235),
                              Pin(size: 17.0, middle: 0.5161),
                              child:
                                  // Adobe XD layer: 'Tất cả' (text)
                                  Text(
                                'Tất cả',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 82.0, end: 16.0),
                        Pin(size: 48.0, start: 0),
                        child:
                            // Adobe XD layer: 'Group 7511' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 1861' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: const Color(0xff2b2f33),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 24.0, middle: 0.7),
                              Pin(size: 17.0, middle: 0.5161),
                              child:
                                  // Adobe XD layer: 'Lọc' (text)
                                  Text(
                                'Lọc',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 17.5, middle: 0.2481),
                              Pin(size: 14.0, middle: 0.5294),
                              child:
                                  // Adobe XD layer: 'coolicon' (shape)
                                  SvgPicture.string(
                                _svg_osjsyb,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(end: 0.0, start: 16.0),
                        Pin(size: 20.0, start: 48 + 16),
                        child:
                            // Adobe XD layer: 'Danh sách thiết bị …' (text)
                            Text(
                          'Danh sách thiết bị',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ]));
              } else {
                return buildItem(context, index);
              }
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  ///list đoạn sửa từng commopent của list
  Widget buildItem(context, index) {
    return GestureDetector(
        onTap: () {},
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(children: [
            Pinned.fromPins(
              Pin(start: 0.0, end: 0.0),
              Pin(
                size: 233.0,
              ),
              child:
                  // Adobe XD layer: 'Group 7563' (group)
                  Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(size: 80.0, start: 12.0),
                    Pin(size: 16.0, end: 12.0),
                    child:
                        // Adobe XD layer: 'Camera 01' (text)
                        Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(
                          _cameraP2PStore.cameraP2PList[index].cameraName ??
                              "Không có tên",
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 13,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 15.5, end: 12.5),
                    Pin(size: 16.0, end: 12.0),
                    child:
                        // Adobe XD layer: 'coolicon' (shape)
                        SvgPicture.string(
                      _svg_su1o25,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 16.0, end: 44.0),
                    Pin(size: 11.8, end: 14.2),
                    child:
                        // Adobe XD layer: 'coolicon' (shape)
                        SvgPicture.string(
                      _svg_r770n,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(start: 0.0, end: 40.0),
                    child:
                        // Adobe XD layer: 'Mask Group' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Rectangle 2278' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromPins(
                                Pin(start: 0.0, end: 0.0),
                                Pin(start: 0.0, end: 0),
                                child:
                                    // Adobe XD layer: 'Image 4' (shape)
                                    ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      imageUrl: _cameraP2PStore
                                              .cameraP2PList[index]
                                              .snapShotUrl ??
                                          '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: const AssetImage(
                                                    Assets.defaultCamera),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 20.0, middle: 0.5015),
                    Pin(size: 20.0, middle: 0.4038),
                    child:
                        // Adobe XD layer: 'coolicon' (shape)
                        SvgPicture.string(
                      _svg_r1srrt,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  onShowDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          width: 200.w,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: const Color(0xff212529),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showOptions = false;
                                  });
                                  Navigator.of(context).pushNamed(
                                      Routes.addDeviceByQRCodeScreen);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SvgPicture.string(
                                            qrcode,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.w),
                                          child:
                                              // Adobe XD layer: 'Quét mã QR' (text)
                                              Text(
                                            'Quét mã QR',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro Display',
                                              fontSize: 14,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showOptions = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamed(Routes.addDevice);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 16.h),
                                      child: Row(children: [
                                        Container(
                                          child: SvgPicture.string(
                                            edit,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.w),
                                          child:
                                              // Adobe XD layer: 'Nhập thủ công' (text)
                                              Text(
                                            'Nhập thủ công',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro Display',
                                              fontSize: 14,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ]))),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showOptions = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamed(Routes.addDevice);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        child: SvgPicture.string(
                                          wifi,
                                          allowDrawingOutsideViewBox: true,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.w),
                                        child:
                                            // Adobe XD layer: 'Quét trong LAN' (text)
                                            Text(
                                          'Quét trong LAN',
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Display',
                                            fontSize: 14,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )))));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      drawer: SMEDrawer(),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          DrawerHeaderWidget(
            headerText:
                AppLocalizations.of(context).translate('device_management'),
            rightWidget: GestureDetector(
                onTap: () {
                  onShowDialog();
                  // setState(() {
                  //   showOptions = !showOptions;
                  // });
                  // Navigator.of(context).pushNamed(Routes.addDevice);
                },
                child:
                    // Adobe XD layer: 'coolicon' (shape)
                    Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    _svg_cy5,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          // Adobe XD layer: 'Group 7507' (group)

          Expanded(child: Observer(
            builder: (context) {
              return _cameraP2PStore.cameraP2PList.length > 0
                  ? _buildListView()
                  : Container(
                      child:
                          // Adobe XD layer: 'Bạn chưa có thiết b…' (text)
                          Text(
                        'Bạn chưa có thiết bị nào',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 14,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
            },
          )),
        ],
      )),
    );
  }
}

const String _svg_o2muup =
    '<svg viewBox="331.4 19.0 22.0 11.3" ><path transform="translate(331.45, 19.0)" d="M 2.66700005531311 0 L 19.33300018310547 0 C 20.80594444274902 0 22 1.194056630134583 22 2.66700005531311 L 22 8.666000366210938 C 22 10.13894367218018 20.80594444274902 11.33300018310547 19.33300018310547 11.33300018310547 L 2.66700005531311 11.33300018310547 C 1.194056630134583 11.33300018310547 0 10.13894367218018 0 8.666000366210938 L 0 2.66700005531311 C 0 1.194056630134583 1.194056630134583 0 2.66700005531311 0 Z" fill="#ffffff" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7zzpga =
    '<svg viewBox="354.4 22.7 1.3 4.0" ><path transform="translate(354.45, 22.67)" d="M 0 2.220446049250313e-16 L 0 4 C 0.3935926258563995 3.834296226501465 0.7295427322387695 3.55614161491394 0.9657710194587708 3.200376033782959 C 1.201999306678772 2.844610452651978 1.32800304889679 2.427051544189453 1.327999949455261 2 C 1.32800304889679 1.572948575019836 1.201999306678772 1.155389547348022 0.9657710194587708 0.7996240258216858 C 0.7295427322387695 0.4438585042953491 0.3935926258563995 0.1657038182020187 2.220446049250313e-16 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_8unnsq =
    '<svg viewBox="333.4 21.0 18.0 7.3" ><path transform="translate(333.45, 21.0)" d="M 1.33299994468689 0 L 16.66699981689453 0 C 17.40319442749023 0 18 0.5968043804168701 18 1.33299994468689 L 18 6 C 18 6.73619556427002 17.40319442749023 7.333000183105469 16.66699981689453 7.333000183105469 L 1.33299994468689 7.333000183105469 C 0.5968043804168701 7.333000183105469 0 6.73619556427002 0 6 L 0 1.33299994468689 C 0 0.5968043804168701 0.5968043804168701 0 1.33299994468689 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_6tpr3i =
    '<svg viewBox="311.1 18.0 15.3 13.0" ><path transform="translate(311.12, 18.0)" d="M 7.667769908905029 13 C 7.624964714050293 12.99906158447266 7.582889556884766 12.98872184753418 7.544525146484375 12.96971225738525 C 7.506160736083984 12.95070266723633 7.472446441650391 12.92348957061768 7.445770263671875 12.89000034332275 L 5.439770221710205 10.5 C 5.3775954246521 10.4230260848999 5.34451961517334 10.32661247253418 5.346348285675049 10.22768115997314 C 5.348176956176758 10.12874984741211 5.384793281555176 10.03362369537354 5.449769973754883 9.958999633789062 C 5.737918853759766 9.66071891784668 6.082252025604248 9.422415733337402 6.462923526763916 9.257823944091797 C 6.843595027923584 9.093232154846191 7.253077507019043 9.005607604980469 7.667769908905029 9 C 8.082701683044434 9.005606651306152 8.492417335510254 9.093323707580566 8.873273849487305 9.258092880249023 C 9.254130363464355 9.42286205291748 9.598587036132812 9.661418914794922 9.886770248413086 9.960000038146973 C 9.951788902282715 10.03465270996094 9.988348007202148 10.12987422943115 9.989995002746582 10.22885799407959 C 9.991641998291016 10.32784175872803 9.958271026611328 10.42422580718994 9.895771026611328 10.50100040435791 L 7.889770030975342 12.89000034332275 C 7.863093852996826 12.92348957061768 7.829379558563232 12.95070266723633 7.791015148162842 12.96971225738525 C 7.752650737762451 12.98872184753418 7.710575103759766 12.99906158447266 7.667769908905029 13 Z M 11.19077014923096 8.805999755859375 C 11.14989948272705 8.805482864379883 11.10960388183594 8.796302795410156 11.07254219055176 8.779065132141113 C 11.03548049926758 8.76182746887207 11.00249862670898 8.73692512512207 10.97577095031738 8.706000328063965 C 10.55832386016846 8.240079879760742 10.04886054992676 7.865714073181152 9.479512214660645 7.606512546539307 C 8.910163879394531 7.347311019897461 8.293281555175781 7.208896636962891 7.667769908905029 7.199999809265137 C 7.043233394622803 7.208670139312744 6.427237987518311 7.346399784088135 5.858478546142578 7.604535579681396 C 5.289719104766846 7.862671375274658 4.780486583709717 8.235635757446289 4.362770080566406 8.699999809265137 C 4.336616992950439 8.732362747192383 4.303556442260742 8.758466720581055 4.266009330749512 8.776398658752441 C 4.228462219238281 8.794330596923828 4.187379360198975 8.803637504577637 4.145770072937012 8.803637504577637 C 4.104160785675049 8.803637504577637 4.063077926635742 8.794330596923828 4.025530815124512 8.776398658752441 C 3.987983703613281 8.758466720581055 3.954923152923584 8.732362747192383 3.928770065307617 8.699999809265137 L 2.768769979476929 7.315000057220459 C 2.706062793731689 7.238220691680908 2.671810626983643 7.142132759094238 2.671810626983643 7.043000221252441 C 2.671810626983643 6.943867683410645 2.706062793731689 6.847779273986816 2.768769979476929 6.770999908447266 C 3.379574060440063 6.068788051605225 4.131803035736084 5.503499984741211 4.976210117340088 5.112143039703369 C 5.820617198944092 4.720786094665527 6.738160610198975 4.512186050415039 7.668770313262939 4.5 C 8.599499702453613 4.512624740600586 9.517075538635254 4.721620559692383 10.36146450042725 5.113313674926758 C 11.20585346221924 5.505006790161133 11.95802688598633 6.07056999206543 12.56877040863037 6.77299976348877 C 12.63147735595703 6.84977912902832 12.66573047637939 6.945867538452148 12.66573047637939 7.045000076293945 C 12.66573047637939 7.144132614135742 12.63147735595703 7.240220546722412 12.56877040863037 7.316999912261963 L 11.40977096557617 8.699999809265137 C 11.38325977325439 8.732630729675293 11.34990310668945 8.759037971496582 11.31205940246582 8.777355194091797 C 11.27421569824219 8.795672416687012 11.23281002044678 8.805450439453125 11.19077014923096 8.805999755859375 L 11.19077014923096 8.805999755859375 Z M 13.85977077484131 5.624000072479248 C 13.81883335113525 5.623874187469482 13.77841091156006 5.614867687225342 13.74129199981689 5.597603321075439 C 13.70417308807373 5.580338954925537 13.67124271392822 5.555226802825928 13.64477062225342 5.52400016784668 C 12.90781497955322 4.653919219970703 11.99310398101807 3.951717376708984 10.9621467590332 3.464612722396851 C 9.93118953704834 2.977508068084717 8.80788516998291 2.716793537139893 7.667769908905029 2.700000047683716 C 6.527806282043457 2.716221570968628 5.404520988464355 2.976274013519287 4.373409748077393 3.462679862976074 C 3.34229850769043 3.949085712432861 2.427252292633057 4.650574207305908 1.689770102500916 5.519999980926514 C 1.664071559906006 5.553214550018311 1.631107211112976 5.580102443695068 1.593405365943909 5.598601341247559 C 1.555703520774841 5.617100238800049 1.514265775680542 5.626718044281006 1.472270131111145 5.626718044281006 C 1.430274486541748 5.626718044281006 1.388836622238159 5.617100238800049 1.351134777069092 5.598601341247559 C 1.313432931900024 5.580102443695068 1.280468583106995 5.553214550018311 1.254770040512085 5.519999980926514 L 0.09477010369300842 4.131999969482422 C 0.03342462703585625 4.055379390716553 -9.367506770274758e-17 3.960152864456177 0 3.861999988555908 C -1.457167719820518e-16 3.76384711265564 0.03342462703585625 3.668620586395264 0.09477010369300842 3.592000007629395 C 1.025538802146912 2.485098838806152 2.18357515335083 1.591421365737915 3.490261554718018 0.9716381430625916 C 4.796947956085205 0.3518549799919128 6.221692085266113 0.0204766783863306 7.667769908905029 0 C 9.113386154174805 0.02064345590770245 10.53763484954834 0.3521116375923157 11.84381103515625 0.9718981981277466 C 13.14998722076416 1.591684818267822 14.30750560760498 2.485276699066162 15.23777103424072 3.592000007629395 C 15.29911613464355 3.668620586395264 15.33254051208496 3.76384711265564 15.33254051208496 3.861999988555908 C 15.33254051208496 3.960152864456177 15.29911613464355 4.055379390716553 15.23777103424072 4.131999969482422 L 14.07977104187012 5.514999866485596 C 14.05344295501709 5.548232078552246 14.02003192901611 5.575171947479248 13.98197269439697 5.593855381011963 C 13.94391345977783 5.612538814544678 13.90216541290283 5.622495651245117 13.85977077484131 5.623000144958496 L 13.85977077484131 5.624000072479248 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eydtws =
    '<svg viewBox="289.1 18.3 17.0 12.7" ><path transform="translate(289.11, 18.34)" d="M 16.00326156616211 12.66699981689453 L 15.00326061248779 12.66699981689453 C 14.71422386169434 12.63979339599609 14.44744110107422 12.50013160705566 14.2603931427002 12.27810573577881 C 14.07334518432617 12.05607986450195 13.98100280761719 11.76945972442627 14.00326061248779 11.47999954223633 L 14.00326061248779 1.187000036239624 C 13.98100280761719 0.8975398540496826 14.07334518432617 0.6109204292297363 14.2603931427002 0.3888942897319794 C 14.44744110107422 0.1668681800365448 14.71422386169434 0.02720663137733936 15.00326061248779 1.665334536937735e-16 L 16.00326156616211 0 C 16.29229927062988 0.02720663137733936 16.55908012390137 0.1668681800365448 16.74612808227539 0.3888942897319794 C 16.93317604064941 0.6109204292297363 17.02552032470703 0.8975398540496826 17.00326156616211 1.187000036239624 L 17.00326156616211 11.47900009155273 C 17.02579498291016 11.76862525939941 16.9335765838623 12.05550098419189 16.74650192260742 12.27774715423584 C 16.55942726135254 12.49999332427979 16.2924861907959 12.63979625701904 16.00326156616211 12.66699981689453 L 16.00326156616211 12.66699981689453 Z M 11.33626079559326 12.66699981689453 L 10.33626079559326 12.66699981689453 C 10.0472240447998 12.63979339599609 9.780441284179688 12.50013160705566 9.593393325805664 12.27810573577881 C 9.406345367431641 12.05607986450195 9.314002990722656 11.76945972442627 9.336260795593262 11.47999954223633 L 9.336260795593262 3.959000110626221 C 9.314002990722656 3.669539928436279 9.406345367431641 3.382920503616333 9.593393325805664 3.160894393920898 C 9.780441284179688 2.938868284225464 10.0472240447998 2.799206733703613 10.33626079559326 2.772000074386597 L 11.33626079559326 2.772000074386597 C 11.62529754638672 2.799206733703613 11.89207935333252 2.938868284225464 12.07912731170654 3.160894393920898 C 12.26617527008057 3.382920503616333 12.35851860046387 3.669539928436279 12.33626079559326 3.959000110626221 L 12.33626079559326 11.47999954223633 C 12.35853099822998 11.76930236816406 12.26632404327393 12.05578422546387 12.07948589324951 12.27778244018555 C 11.8926477432251 12.49978065490723 11.62611675262451 12.63954734802246 11.33726024627686 12.66699981689453 L 11.33626079559326 12.66699981689453 Z M 6.669260501861572 12.66699981689453 L 5.669260501861572 12.66699981689453 C 5.380223274230957 12.63979339599609 5.113441467285156 12.50013160705566 4.926393508911133 12.27810573577881 C 4.739345550537109 12.05607986450195 4.647002696990967 11.76945972442627 4.669260501861572 11.47999954223633 L 4.669260501861572 6.729000091552734 C 4.647002696990967 6.439539909362793 4.739345550537109 6.152920722961426 4.926393508911133 5.930894374847412 C 5.113441467285156 5.708868026733398 5.380223274230957 5.569206237792969 5.669260501861572 5.541999816894531 L 6.669260501861572 5.541999816894531 C 6.958297729492188 5.569206237792969 7.225079536437988 5.708868026733398 7.412127494812012 5.930894374847412 C 7.599175453186035 6.152920722961426 7.691518306732178 6.439539909362793 7.669260501861572 6.729000091552734 L 7.669260501861572 11.47999954223633 C 7.691518306732178 11.76945972442627 7.599175453186035 12.05607986450195 7.412127494812012 12.27810573577881 C 7.225079536437988 12.50013160705566 6.958297729492188 12.63979339599609 6.669260501861572 12.66699981689453 L 6.669260501861572 12.66699981689453 Z M 2.003260612487793 12.66699981689453 L 1.003260731697083 12.66699981689453 C 0.7142237424850464 12.63979339599609 0.4474418163299561 12.50013160705566 0.2603936791419983 12.27810573577881 C 0.07334555685520172 12.05607986450195 -0.01899724081158638 11.76945972442627 0.003260678611695766 11.47999954223633 L 0.003260678611695766 9.100000381469727 C -0.01791370287537575 8.811094284057617 0.07489818334579468 8.525383949279785 0.2618142068386078 8.304075241088867 C 0.4487302303314209 8.082766532897949 0.7148842811584473 7.943460941314697 1.003260731697083 7.915999889373779 L 2.003260612487793 7.915999889373779 C 2.291636943817139 7.943460941314697 2.557790994644165 8.082766532897949 2.744707107543945 8.304075241088867 C 2.931623220443726 8.525383949279785 3.024435043334961 8.811094284057617 3.003260612487793 9.100000381469727 L 3.003260612487793 11.47500038146973 C 3.026895523071289 11.76528453826904 2.935181379318237 12.05318927764893 2.747995376586914 12.2763147354126 C 2.560809373855591 12.49944019317627 2.293233633041382 12.63980960845947 2.003260612487793 12.66699981689453 L 2.003260612487793 12.66699981689453 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rwn8iy =
    '<svg viewBox="0.0 0.0 375.0 44.0" ><path  d="M 0 0 L 375 0 L 375 44 L 0 44 L 0 0 Z" fill="#212529" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_604vch =
    '<svg viewBox="343.0 60.0 16.0 16.0" ><path transform="translate(343.0, 60.0)" d="M 0.8816834092140198 16 C 0.6353361010551453 15.99957275390625 0.4004952609539032 15.89569473266602 0.2344572991132736 15.71370983123779 C 0.06535784900188446 15.53320693969727 -0.01866841688752174 15.2891149520874 0.003493274096399546 15.04277229309082 L 0.2186498641967773 12.67692756652832 L 10.1580057144165 2.741083383560181 L 13.2641658782959 5.84636402130127 L 3.32744288444519 15.78133010864258 L 0.961598813533783 15.99648761749268 C 0.9343749284744263 15.99912166595459 0.90715092420578 16 0.8816834092140198 16 Z M 13.8841667175293 5.225482940673828 L 10.77888679504395 2.120202779769897 L 12.64152812957764 0.2575614750385284 C 12.80624866485596 0.09265750646591187 13.0297679901123 0 13.26284790039062 0 C 13.49592781066895 0 13.71944618225098 0.09265750646591187 13.8841667175293 0.2575614750385284 L 15.74680995941162 2.120202779769897 C 15.91171360015869 2.284923553466797 16.00437164306641 2.508442640304565 16.00437164306641 2.741522312164307 C 16.00437164306641 2.974602222442627 15.91171360015869 3.198121547698975 15.74680995941162 3.362842082977295 L 13.88504505157471 5.224605083465576 L 13.8841667175293 5.225482940673828 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dv4tiu =
    '<svg viewBox="64.7 688.4 4.7 11.3" ><path transform="translate(64.73, 688.38)" d="M 3.992573976516724 0.2305991947650909 C 3.545635938644409 -0.05095741525292397 2.996297121047974 -0.07586436718702316 2.52802562713623 0.1623758673667908 L 0.9472096562385559 0.9604806303977966 C 0.3626703917980194 1.255032181739807 0 1.850632905960083 0 2.513373851776123 L 0 8.735774993896484 C 0 9.398515701293945 0.3626703917980194 9.993033409118652 0.9472096562385559 10.28975105285645 L 2.526959180831909 11.08677387237549 C 2.741361379623413 11.19723033905029 2.970696926116943 11.25029277801514 3.200032472610474 11.25029277801514 C 3.475235223770142 11.25029277801514 3.748304843902588 11.17232322692871 3.992573976516724 11.01963329315186 C 4.439511775970459 10.73915958404541 4.706181049346924 10.25293254852295 4.706181049346924 9.72014045715332 L 4.706181049346924 1.531174302101135 C 4.706181049346924 0.9983825087547302 4.439511775970459 0.5121558308601379 3.992573976516724 0.2305991947650909 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3nkhj5 =
    '<svg viewBox="48.0 686.0 15.0 16.0" ><path transform="translate(48.0, 686.0)" d="M 10.56543636322021 16 L 4.387242317199707 16 C 1.80375063419342 16 0 14.21861171722412 0 11.66835880279541 L 0 4.33164119720459 C 0 1.780304431915283 1.80375063419342 0 4.387242317199707 0 L 10.56543636322021 0 C 13.14892768859863 0 14.95267868041992 1.780304431915283 14.95267868041992 4.33164119720459 L 14.95267868041992 11.66835880279541 C 14.95267868041992 14.21861171722412 13.14892768859863 16 10.56543636322021 16 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qevv3q =
    '<svg viewBox="343.0 686.0 15.5 16.0" ><path transform="translate(343.0, 686.0)" d="M 9.218044281005859 16 L 6.306045055389404 16 C 5.930136680603027 16 5.604888916015625 15.73840045928955 5.524444580078125 15.37120056152344 L 5.198844432830811 13.86400032043457 C 4.764485836029053 13.67369270324707 4.352624416351318 13.43569850921631 3.970844507217407 13.15440082550049 L 2.501244306564331 13.62240028381348 C 2.142844676971436 13.73669052124023 1.753233551979065 13.58584213256836 1.565244197845459 13.26000022888184 L 0.1060441210865974 10.7391996383667 C -0.07988558709621429 10.41321277618408 -0.01582901552319527 10.00199031829834 0.260444164276123 9.748000144958496 L 1.400444388389587 8.708000183105469 C 1.348601818084717 8.236888885498047 1.348601818084717 7.761511325836182 1.400444388389587 7.29040002822876 L 0.260444164276123 6.252799987792969 C -0.01623597368597984 5.99869441986084 -0.08031793683767319 5.586976051330566 0.1060441210865974 5.260800361633301 L 1.562044262886047 2.738399982452393 C 1.750033617019653 2.412558317184448 2.139644622802734 2.261708974838257 2.498044490814209 2.375999927520752 L 3.967644453048706 2.844000101089478 C 4.162894725799561 2.6993248462677 4.366150856018066 2.565779447555542 4.576444625854492 2.444000005722046 C 4.778316497802734 2.33015513420105 4.986073970794678 2.22707724571228 5.198844432830811 2.135200023651123 L 5.52524471282959 0.6295999884605408 C 5.605300426483154 0.2623750269412994 5.930195331573486 0.0003955143038183451 6.306045055389404 0 L 9.218044281005859 0 C 9.593894004821777 0.0003955143038183451 9.918788909912109 0.2623750269412994 9.998845100402832 0.6295999884605408 L 10.328444480896 2.136000156402588 C 10.55307483673096 2.23481297492981 10.77183723449707 2.346463918685913 10.98364543914795 2.470400094985962 C 11.18119144439697 2.584650278091431 11.37215900421143 2.709914445877075 11.55564403533936 2.845599889755249 L 13.02604484558105 2.377600193023682 C 13.38420391082764 2.26373553276062 13.77333450317383 2.414527416229248 13.9612455368042 2.740000009536743 L 15.41724491119385 5.262400150299072 C 15.60317516326904 5.588387489318848 15.53911781311035 5.999610424041748 15.26284503936768 6.253600120544434 L 14.12284469604492 7.293599605560303 C 14.17468738555908 7.764710903167725 14.17468738555908 8.24008846282959 14.12284469604492 8.711199760437012 L 15.26284503936768 9.751199722290039 C 15.53911781311035 10.00518989562988 15.60317516326904 10.41641330718994 15.41724491119385 10.74240016937256 L 13.9612455368042 13.26479911804199 C 13.77333450317383 13.59027194976807 13.38420391082764 13.74106502532959 13.02604484558105 13.62720012664795 L 11.55564403533936 13.15919971466064 C 11.36958503723145 13.29623699188232 11.17623424530029 13.4230899810791 10.97644424438477 13.53919982910156 C 10.76670455932617 13.66072368621826 10.55037117004395 13.77049446105957 10.328444480896 13.86800098419189 L 9.998845100402832 15.37120056152344 C 9.918464660644531 15.73810768127441 9.593652725219727 15.99968719482422 9.218044281005859 16 Z M 4.258044242858887 11.38319969177246 L 4.914044380187988 11.86320018768311 C 5.061924934387207 11.97212314605713 5.216055393218994 12.07229423522949 5.375644683837891 12.16320037841797 C 5.525805950164795 12.25016403198242 5.680417537689209 12.32920551300049 5.838844776153564 12.39999961853027 L 6.585244655609131 12.72720050811768 L 6.950844287872314 14.39999961853027 L 8.574844360351562 14.39999961853027 L 8.940443992614746 12.72640037536621 L 9.686844825744629 12.39920043945312 C 10.01268768310547 12.25550651550293 10.32196712493896 12.07685947418213 10.60924434661865 11.86639976501465 L 11.26604461669922 11.38640022277832 L 12.89884471893311 11.90640068054199 L 13.71084594726562 10.5 L 12.44444465637207 9.345600128173828 L 12.53404521942139 8.53600025177002 C 12.57340335845947 8.181890487670898 12.57340335845947 7.824510097503662 12.53404521942139 7.470400333404541 L 12.44444465637207 6.660799980163574 L 13.71164512634277 5.504000186920166 L 12.89884471893311 4.096799850463867 L 11.26604461669922 4.616799831390381 L 10.60924434661865 4.136799812316895 C 10.32187652587891 3.925368547439575 10.01263809204102 3.74540376663208 9.686844825744629 3.599999904632568 L 8.940443992614746 3.272799968719482 L 8.574844360351562 1.600000023841858 L 6.950844287872314 1.600000023841858 L 6.583644866943359 3.273600101470947 L 5.838844776153564 3.599999904632568 C 5.680289268493652 3.669635057449341 5.52565860748291 3.747885227203369 5.375644683837891 3.834400177001953 C 5.217033863067627 3.925063133239746 5.063718318939209 4.024691104888916 4.916444301605225 4.132800102233887 L 4.259644508361816 4.612799644470215 L 2.627644300460815 4.092800140380859 L 1.81404435634613 5.504000186920166 L 3.080444574356079 6.656800270080566 L 2.990844488143921 7.467199802398682 C 2.951486587524414 7.821309566497803 2.951486587524414 8.178690910339355 2.990844488143921 8.532800674438477 L 3.080444574356079 9.342400550842285 L 1.81404435634613 10.49680042266846 L 2.626044273376465 11.90320014953613 L 4.258044242858887 11.38319969177246 Z M 7.75884485244751 11.19999980926514 C 5.991533279418945 11.19999980926514 4.558844566345215 9.767311096191406 4.558844566345215 8 C 4.558844566345215 6.232688903808594 5.991533279418945 4.800000190734863 7.75884485244751 4.800000190734863 C 9.526156425476074 4.800000190734863 10.9588451385498 6.232688903808594 10.9588451385498 8 C 10.95664119720459 9.766397476196289 9.525242805480957 11.19779586791992 7.75884485244751 11.19999980926514 Z M 7.75884485244751 6.400000095367432 C 6.884761333465576 6.400885581970215 6.173154830932617 7.10307788848877 6.160629749298096 7.977072238922119 C 6.148104667663574 8.851066589355469 6.839296817779541 9.573362350463867 7.712996006011963 9.599294662475586 C 8.586694717407227 9.625227928161621 9.319510459899902 8.945199012756348 9.358844757080078 8.072000503540039 L 9.358844757080078 8.392000198364258 L 9.358844757080078 8 C 9.358844757080078 7.116344451904297 8.642499923706055 6.400000095367432 7.75884485244751 6.400000095367432 Z" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_5g9sv9 =
    '<svg viewBox="16.0 686.0 8.0 16.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 16.0, 702.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_osjsyb =
    '<svg viewBox="293.0 126.0 17.5 14.0" ><path transform="translate(293.0, 126.0)" d="M 5.249837398529053 13.99999809265137 C 3.653236150741577 14.00080299377441 2.258467674255371 12.92098331451416 1.859317421913147 11.37508010864258 L 0 11.37508010864258 L 0 9.625134468078613 L 1.86019229888916 9.625134468078613 C 2.314862728118896 7.864203929901123 4.042476177215576 6.744941234588623 5.835440158843994 7.049705982208252 C 7.628404140472412 7.354470252990723 8.889176368713379 8.981692314147949 8.736482620239258 10.79395294189453 C 8.583788871765137 12.6062126159668 7.06851863861084 13.99953556060791 5.249837398529053 13.99999809265137 Z M 5.249837398529053 8.750161170959473 C 4.293838024139404 8.751130104064941 3.515543222427368 9.519128799438477 3.501844167709351 10.47503089904785 C 3.488145351409912 11.43093204498291 4.244113445281982 12.22091960906982 5.199692249298096 12.24928188323975 C 6.155271053314209 12.27764511108398 6.956762790679932 11.53388595581055 6.999783515930176 10.57885456085205 L 6.999783515930176 10.92884349822998 L 6.999783515930176 10.50010681152344 C 6.999783515930176 9.533638954162598 6.216305732727051 8.750161170959473 5.249837398529053 8.750161170959473 Z M 17.49945831298828 11.37508010864258 L 9.624702453613281 11.37508010864258 L 9.624702453613281 9.625134468078613 L 17.49945831298828 9.625134468078613 L 17.49945831298828 11.37508010864258 Z M 9.624702453613281 7.00021505355835 C 8.028426170349121 7.00062084197998 6.634125709533691 5.920883655548096 6.23505687713623 4.375296115875244 L 0 4.375296115875244 L 0 2.625350475311279 L 6.23505687713623 2.625350475311279 C 6.689727306365967 0.8644198179244995 8.417341232299805 -0.2548425793647766 10.21030521392822 0.04992192983627319 C 12.00326824188232 0.3546864092350006 13.26404094696045 1.981908559799194 13.11134719848633 3.794168710708618 C 12.95865345001221 5.606428623199463 11.44338321685791 6.999752998352051 9.624702453613281 7.00021505355835 Z M 9.624702453613281 1.750377416610718 C 8.668703079223633 1.751345872879028 7.890407562255859 2.519345283508301 7.876708984375 3.475246667861938 C 7.863009929656982 4.431148529052734 8.618977546691895 5.221135139465332 9.574556350708008 5.24949836730957 C 10.53013515472412 5.27786111831665 11.33162784576416 4.534102439880371 11.37464809417725 3.579071044921875 L 11.37464809417725 3.929060220718384 L 11.37464809417725 3.500323295593262 C 11.37464809417725 2.533854722976685 10.59117031097412 1.750377416610718 9.624702453613281 1.750377416610718 Z M 17.49945831298828 4.375296115875244 L 13.99956703186035 4.375296115875244 L 13.99956703186035 2.625350475311279 L 17.49945831298828 2.625350475311279 L 17.49945831298828 4.375296115875244 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_e1w4px =
    '<svg viewBox="32.8 124.0 15.0 14.2" ><path transform="translate(32.85, 124.0)" d="M 14.97659111022949 7.111149311065674 C 14.97659111022949 11.03852844238281 11.62396717071533 14.22229862213135 7.488295555114746 14.22229862213135 C 3.35262393951416 14.22229862213135 0 11.03852844238281 0 7.111149311065674 C 0 3.183769702911377 3.35262393951416 0 7.488295555114746 0 C 11.62396717071533 0 14.97659111022949 3.183769702911377 14.97659111022949 7.111149311065674 Z" fill="none" stroke="#818181" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_rtvfq5 =
    '<svg viewBox="45.6 136.1 4.1 3.9" ><path transform="translate(45.63, 136.13)" d="M 4.071761131286621 3.866688013076782 L 0 0" fill="none" stroke="#818181" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_cy5 =
    '<svg viewBox="343.0 60.0 16.0 16.0" ><path transform="translate(343.0, 60.0)" d="M 8 16 C 3.581721782684326 16 0 12.41827774047852 0 8 C 0 3.581721782684326 3.581721782684326 0 8 0 C 12.41827774047852 0 16 3.581721782684326 16 8 C 15.99515056610107 12.41626739501953 12.41626739501953 15.99515056610107 8 16 Z M 1.600000023841858 8.137599945068359 C 1.637852907180786 11.65859222412109 4.512886047363281 14.48763465881348 8.034030914306641 14.46879863739014 C 11.55517578125 14.44978141784668 14.39963054656982 11.58999538421631 14.39963054656982 8.068798065185547 C 14.39963054656982 4.547604560852051 11.55517578125 1.687819123268127 8.034030914306641 1.668798089027405 C 4.512886047363281 1.649965763092041 1.637852907180786 4.479008197784424 1.600000023841858 8 L 1.600000023841858 8.137599945068359 Z M 8.800000190734863 12 L 7.199999809265137 12 L 7.199999809265137 8.800000190734863 L 4 8.800000190734863 L 4 7.199999809265137 L 7.199999809265137 7.199999809265137 L 7.199999809265137 4 L 8.800000190734863 4 L 8.800000190734863 7.199999809265137 L 12 7.199999809265137 L 12 8.800000190734863 L 8.800000190734863 8.800000190734863 L 8.800000190734863 12 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_su1o25 =
    '<svg viewBox="331.0 651.0 15.5 16.0" ><path transform="translate(331.0, 651.0)" d="M 9.218044281005859 16 L 6.306045055389404 16 C 5.930136680603027 16 5.604888916015625 15.73840045928955 5.524444580078125 15.37120056152344 L 5.198844432830811 13.86400032043457 C 4.764485836029053 13.67369270324707 4.352624416351318 13.43569850921631 3.970844507217407 13.15440082550049 L 2.501244306564331 13.62240028381348 C 2.142844676971436 13.73669052124023 1.753233551979065 13.58584213256836 1.565244197845459 13.26000022888184 L 0.1060441210865974 10.7391996383667 C -0.07988558709621429 10.41321277618408 -0.01582901552319527 10.00199031829834 0.260444164276123 9.748000144958496 L 1.400444388389587 8.708000183105469 C 1.348601818084717 8.236888885498047 1.348601818084717 7.761511325836182 1.400444388389587 7.29040002822876 L 0.260444164276123 6.252799987792969 C -0.01623597368597984 5.99869441986084 -0.08031793683767319 5.586976051330566 0.1060441210865974 5.260800361633301 L 1.562044262886047 2.738399982452393 C 1.750033617019653 2.412558317184448 2.139644622802734 2.261708974838257 2.498044490814209 2.375999927520752 L 3.967644453048706 2.844000101089478 C 4.162894725799561 2.6993248462677 4.366150856018066 2.565779447555542 4.576444625854492 2.444000005722046 C 4.778316497802734 2.33015513420105 4.986073970794678 2.22707724571228 5.198844432830811 2.135200023651123 L 5.52524471282959 0.6295999884605408 C 5.605300426483154 0.2623750269412994 5.930195331573486 0.0003955143038183451 6.306045055389404 0 L 9.218044281005859 0 C 9.593894004821777 0.0003955143038183451 9.918788909912109 0.2623750269412994 9.998845100402832 0.6295999884605408 L 10.328444480896 2.136000156402588 C 10.55307483673096 2.23481297492981 10.77183723449707 2.346463918685913 10.98364543914795 2.470400094985962 C 11.18119144439697 2.584650278091431 11.37215900421143 2.709914445877075 11.55564403533936 2.845599889755249 L 13.02604484558105 2.377600193023682 C 13.38420391082764 2.26373553276062 13.77333450317383 2.414527416229248 13.9612455368042 2.740000009536743 L 15.41724491119385 5.262400150299072 C 15.60317516326904 5.588387489318848 15.53911781311035 5.999610424041748 15.26284503936768 6.253600120544434 L 14.12284469604492 7.293599605560303 C 14.17468738555908 7.764710903167725 14.17468738555908 8.24008846282959 14.12284469604492 8.711199760437012 L 15.26284503936768 9.751199722290039 C 15.53911781311035 10.00518989562988 15.60317516326904 10.41641330718994 15.41724491119385 10.74240016937256 L 13.9612455368042 13.26479911804199 C 13.77333450317383 13.59027194976807 13.38420391082764 13.74106502532959 13.02604484558105 13.62720012664795 L 11.55564403533936 13.15919971466064 C 11.36958503723145 13.29623699188232 11.17623424530029 13.4230899810791 10.97644424438477 13.53919982910156 C 10.76670455932617 13.66072368621826 10.55037117004395 13.77049446105957 10.328444480896 13.86800098419189 L 9.998845100402832 15.37120056152344 C 9.918464660644531 15.73810768127441 9.593652725219727 15.99968719482422 9.218044281005859 16 Z M 4.258044242858887 11.38319969177246 L 4.914044380187988 11.86320018768311 C 5.061924934387207 11.97212314605713 5.216055393218994 12.07229423522949 5.375644683837891 12.16320037841797 C 5.525805950164795 12.25016403198242 5.680417537689209 12.32920551300049 5.838844776153564 12.39999961853027 L 6.585244655609131 12.72720050811768 L 6.950844287872314 14.39999961853027 L 8.574844360351562 14.39999961853027 L 8.940443992614746 12.72640037536621 L 9.686844825744629 12.39920043945312 C 10.01268768310547 12.25550651550293 10.32196712493896 12.07685947418213 10.60924434661865 11.86639976501465 L 11.26604461669922 11.38640022277832 L 12.89884471893311 11.90640068054199 L 13.71084594726562 10.5 L 12.44444465637207 9.345600128173828 L 12.53404521942139 8.53600025177002 C 12.57340335845947 8.181890487670898 12.57340335845947 7.824510097503662 12.53404521942139 7.470400333404541 L 12.44444465637207 6.660799980163574 L 13.71164512634277 5.504000186920166 L 12.89884471893311 4.096799850463867 L 11.26604461669922 4.616799831390381 L 10.60924434661865 4.136799812316895 C 10.32187652587891 3.925368547439575 10.01263809204102 3.74540376663208 9.686844825744629 3.599999904632568 L 8.940443992614746 3.272799968719482 L 8.574844360351562 1.600000023841858 L 6.950844287872314 1.600000023841858 L 6.583644866943359 3.273600101470947 L 5.838844776153564 3.599999904632568 C 5.680289268493652 3.669635057449341 5.52565860748291 3.747885227203369 5.375644683837891 3.834400177001953 C 5.217033863067627 3.925063133239746 5.063718318939209 4.024691104888916 4.916444301605225 4.132800102233887 L 4.259644508361816 4.612799644470215 L 2.627644300460815 4.092800140380859 L 1.81404435634613 5.504000186920166 L 3.080444574356079 6.656800270080566 L 2.990844488143921 7.467199802398682 C 2.951486587524414 7.821309566497803 2.951486587524414 8.178690910339355 2.990844488143921 8.532800674438477 L 3.080444574356079 9.342400550842285 L 1.81404435634613 10.49680042266846 L 2.626044273376465 11.90320014953613 L 4.258044242858887 11.38319969177246 Z M 7.75884485244751 11.19999980926514 C 5.991533279418945 11.19999980926514 4.558844566345215 9.767311096191406 4.558844566345215 8 C 4.558844566345215 6.232688903808594 5.991533279418945 4.800000190734863 7.75884485244751 4.800000190734863 C 9.526156425476074 4.800000190734863 10.9588451385498 6.232688903808594 10.9588451385498 8 C 10.95664119720459 9.766397476196289 9.525242805480957 11.19779586791992 7.75884485244751 11.19999980926514 Z M 7.75884485244751 6.400000095367432 C 6.884761333465576 6.400885581970215 6.173154830932617 7.10307788848877 6.160629749298096 7.977072238922119 C 6.148104667663574 8.851066589355469 6.839296817779541 9.573362350463867 7.712996006011963 9.599294662475586 C 8.586694717407227 9.625227928161621 9.319510459899902 8.945199012756348 9.358844757080078 8.072000503540039 L 9.358844757080078 8.392000198364258 L 9.358844757080078 8 C 9.358844757080078 7.116344451904297 8.642499923706055 6.400000095367432 7.75884485244751 6.400000095367432 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_r770n =
    '<svg viewBox="299.0 653.0 16.0 11.8" ><path transform="translate(299.0, 653.0)" d="M 8 11.79017639160156 C 6.687900066375732 11.80737590789795 5.389360904693604 11.5092887878418 4.203200340270996 10.91859817504883 C 3.283754348754883 10.44636535644531 2.458122730255127 9.794193267822266 1.770400047302246 8.996912956237793 C 1.041945219039917 8.172592163085938 0.4683739244937897 7.210520267486572 0.07999999821186066 6.161544799804688 L 0 5.895439147949219 L 0.08399999886751175 5.629333972930908 C 0.4726521670818329 4.581276893615723 1.044988632202148 3.619455575942993 1.771199941635132 2.793965101242065 C 2.458673000335693 1.996755480766296 3.284029960632324 1.344586610794067 4.203200340270996 0.8722808361053467 C 5.389369964599609 0.2816183865070343 6.687902927398682 -0.01646785996854305 8 0.0007017859607003629 C 9.312094688415527 -0.01643822155892849 10.61062145233154 0.2816466093063354 11.79680061340332 0.8722808361053467 C 12.71626663208008 1.344478249549866 13.54190444946289 1.996654510498047 14.22960090637207 2.793965101242065 C 14.95943546295166 3.617169857025146 15.53318119049072 4.579535484313965 15.92000007629395 5.629333972930908 L 16 5.895439147949219 L 15.91600036621094 6.161544799804688 C 14.66097164154053 9.60052490234375 11.49935817718506 11.84857368469238 8 11.79017639160156 Z M 8 1.684912443161011 C 5.27669620513916 1.595084547996521 2.777134895324707 3.263940334320068 1.693600058555603 5.895439147949219 C 2.776957511901855 8.527097702026367 5.276634216308594 10.19603061676025 8 10.10596561431885 C 10.72324275970459 10.19555759429932 13.22268772125244 8.526779174804688 14.30639934539795 5.895439147949219 C 13.22428417205811 3.262663602828979 10.72379589080811 1.593189358711243 8 1.684912443161011 Z M 8 8.421755790710449 C 6.845860004425049 8.429797172546387 5.847493648529053 7.577426910400391 5.616772651672363 6.387038230895996 C 5.386051177978516 5.196649551391602 5.98741626739502 4.00072193145752 7.05230712890625 3.532206773757935 C 8.11719799041748 3.063691854476929 9.348188400268555 3.453447103500366 9.990836143493652 4.462602138519287 C 10.63348484039307 5.471757411956787 10.50829792022705 6.81845235824585 9.691999435424805 7.677334308624268 C 9.24505615234375 8.153340339660645 8.635805130004883 8.421389579772949 8 8.421755790710449 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_r1srrt =
    '<svg viewBox="178.0 532.0 20.0 20.0" ><path transform="translate(178.0, 532.0)" d="M 10 20.0000171661377 C 4.479665756225586 19.99395561218262 0.006062370259314775 15.52035331726074 0 10.00001811981201 L 0 9.800018310546875 C 0.1099314838647842 4.304549217224121 4.634586334228516 -0.07202570885419846 10.13067150115967 0.0008982174331322312 C 15.62675666809082 0.07382214814424515 20.03369903564453 4.568903923034668 19.9977855682373 10.06535530090332 C 19.96187210083008 15.56180667877197 15.49656867980957 19.9989185333252 10 20.0000171661377 Z M 8 5.500018119812012 L 8 14.50001811981201 L 14 10.00001811981201 L 8 5.500018119812012 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String qrcode =
    '<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2.66667 2.66667H4.44444V4.44444H2.66667V2.66667Z" fill="white"/><path d="M0 7.11111V0H7.11111V7.11111H0ZM1.77778 1.77778V5.33333H5.33333V1.77778H1.77778Z" fill="white"/><path d="M8.88889 8.88889H11.5556V10.6667H8.88889V8.88889Z" fill="white"/><path d="M11.5556 10.6667H13.3333V8.88889H16V11.5556H13.3333V12.4444H14.2222V13.3333H16V16H14.2222V14.2222H12.4444V16H8.88889V12.4444H10.6667V14.2222H11.5556V10.6667Z" fill="white"/><path d="M13.3333 2.66667H11.5556V4.44444H13.3333V2.66667Z" fill="white"/><path d="M8.88889 0V7.11111H16V0H8.88889ZM14.2222 1.77778V5.33333H10.6667V1.77778H14.2222Z" fill="white"/><path d="M2.66667 11.5556H4.44444V13.3333H2.66667V11.5556Z" fill="white"/><path d="M0 16V8.88889H7.11111V16H0ZM1.77778 10.6667V14.2222H5.33333V10.6667H1.77778Z" fill="white"/></svg>';
const String edit =
    '<svg width="18" height="17" viewBox="0 0 18 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.88477 16H16.7697" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12.8274 1.54434C13.1759 1.1958 13.6486 1 14.1415 1C14.3856 1 14.6272 1.04807 14.8527 1.14147C15.0782 1.23487 15.2831 1.37176 15.4557 1.54434C15.6282 1.71692 15.7651 1.92179 15.8585 2.14728C15.9519 2.37276 16 2.61443 16 2.85849C16 3.10255 15.9519 3.34422 15.8585 3.5697C15.7651 3.79519 15.6282 4.00006 15.4557 4.17264L4.5044 15.1239L1 16L1.8761 12.4956L12.8274 1.54434Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
const String wifi =
    '<svg width="18" height="14" viewBox="0 0 18 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 12.3403H9.00853" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M6.37622 9.39941C7.14386 8.85404 8.06217 8.56104 9.00382 8.56104C9.94547 8.56104 10.8638 8.85404 11.6314 9.39941" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M3.707 6.70683C5.20157 5.46197 7.08515 4.78027 9.03025 4.78027C10.9754 4.78027 12.8589 5.46197 14.3535 6.70683" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M1 4.02257C3.20977 2.07472 6.05429 1 9 1C11.9457 1 14.7902 2.07472 17 4.02257" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
