import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/stores/global/global_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class SMEDrawer extends StatefulWidget {
  SMEDrawer({Key? key}) : super(key: key);

  @override
  _SMEDrawerState createState() => _SMEDrawerState();
}

class _SMEDrawerState extends State<SMEDrawer> {
  late UserStore _store;
  late GlobalStore _globalStore;

  late CameraP2PStore _cameraP2PStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<UserStore>(context);
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
    _globalStore = Provider.of<GlobalStore>(context);
    // _globalStore.setRoute(Preferences.drawerDeviceManagement);
    // _cameraStore = Provider.of<CameraP2PStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Drawer(
          child: Container(
              color: const Color(0xff212529),
              child: SafeArea(
                  child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.account, (Route<dynamic> route) => false);
                    },
                    child: Container(
                      height: 110.h,
                      child:
                          // Adobe XD layer: 'Rectangle 2033' (shape)
                          Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0, -0.94),
                                  end: Alignment(1.0, 1.0),
                                  colors: [
                                    const Color(0xff2b2f33),
                                    const Color(0xff3f4347),
                                    const Color(0xff2b2f33),
                                    const Color(0x703d4348),
                                    const Color(0xff2b2f33),
                                    const Color(0xff272b2f)
                                  ],
                                  stops: [
                                    0.0,
                                    0.115,
                                    0.229,
                                    0.396,
                                    0.658,
                                    0.688
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(58.5),
                                          child: Observer(
                                            builder: (context) =>
                                                CachedNetworkImage(
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              imageUrl:
                                                  _store.user?.urlAvatar ?? '',
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: const AssetImage(
                                                        Assets.defaultCamera),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 16.w),
                                        child:
                                            // Adobe XD layer: 'Nguyễn Hoàng Anh' (text)
                                            Text(
                                          _store.user?.fullName ??
                                              _store.user?.userName ??
                                              '',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 17,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child:
                                        // Adobe XD layer: 'Vector 1' (shape)
                                        SvgPicture.string(
                                      backSvg,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        _globalStore
                            .setRoute(Preferences.drawerDeviceManagement);
                        _cameraP2PStore.cancelFilter();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.deviceManagement,
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xff626262),
                                    width: 0.5))),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 13.w),
                              child:
                                  // Adobe XD layer: 'coolicon' (shape)
                                  SvgPicture.string(
                                _svg_tamkal,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerDeviceManagement
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Adobe XD layer: 'Xem trực tiếp' (text)
                            Text(
                              AppLocalizations.of(context)
                                  .translate('device_management'),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerDeviceManagement
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        _globalStore
                            .setRoute(Preferences.drawerSystemManagement);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.deviceManagement,
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xff626262),
                                    width: 0.5))),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 13.w),
                              child:
                                  // Adobe XD layer: 'coolicon' (shape)
                                  SvgPicture.string(
                                _svg_obvnu3,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerSystemManagement
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Adobe XD layer: 'Xem trực tiếp' (text)
                            Text(
                              AppLocalizations.of(context)
                                  .translate('system_management'),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerSystemManagement
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () async {
                        await PhotoManager.requestPermissionExtend()
                            .then((value) {
                          if (value.isAuth) {
                            _globalStore.setRoute(Preferences.drawerLibrary);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.libraryScreen,
                                (Route<dynamic> route) => false);
                          } else {
                            PhotoManager.openSetting();
                          }
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xff626262),
                                    width: 0.5))),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 13.w),
                              child:
                                  // Adobe XD layer: 'coolicon' (shape)
                                  SvgPicture.string(
                                _svg_ju9j9w,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerLibrary
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Adobe XD layer: 'Xem trực tiếp' (text)
                            Text(
                              AppLocalizations.of(context).translate('library'),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerLibrary
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        _globalStore.setRoute(Preferences.drawerLibrary);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.deviceManagement,
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xff626262),
                                    width: 0.5))),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 13.w),
                              child:
                                  // Adobe XD layer: 'coolicon' (shape)
                                  SvgPicture.string(
                                _svg_vzgxgf,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerNotification
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Adobe XD layer: 'Xem trực tiếp' (text)
                            Text(
                              AppLocalizations.of(context)
                                  .translate('notification'),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.drawerNotification
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        _globalStore.setRoute(Preferences.setting);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.settingScreen,
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xff626262),
                                    width: 0.5))),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 13.w),
                              child:
                                  // Adobe XD layer: 'coolicon' (shape)
                                  SvgPicture.string(
                                _svg_1tstko,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.setting
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Adobe XD layer: 'Xem trực tiếp' (text)
                            Text(
                              AppLocalizations.of(context).translate('setting'),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                color: _globalStore.selectedDrawer ==
                                        Preferences.setting
                                    ? const Color(0xfffd7b38)
                                    : const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )),
                ],
              ))));
    });
  }
}

const String _svg_tamkal =
    '<svg viewBox="19.0 174.1 10.2 16.0" ><path transform="translate(19.0, 174.13)" d="M 8.727272987365723 16 L 1.454545378684998 16 C 0.6512222290039062 16 0 15.34877777099609 0 14.54545497894287 L 0 1.454545497894287 C 0 0.6512221693992615 0.6512222290039062 0 1.454545378684998 0 L 8.727272987365723 0 C 9.530595779418945 0 10.18181800842285 0.6512221693992615 10.18181800842285 1.454545497894287 L 10.18181800842285 14.54545497894287 C 10.18181800842285 15.34877777099609 9.530595779418945 16 8.727272987365723 16 Z M 1.454545378684998 1.454545497894287 L 1.454545378684998 14.54545497894287 L 8.727272987365723 14.54545497894287 L 8.727272987365723 1.454545497894287 L 1.454545378684998 1.454545497894287 Z M 5.090909004211426 13.81818199157715 C 4.689247131347656 13.81818199157715 4.363636493682861 13.4925708770752 4.363636493682861 13.09090900421143 C 4.363636493682861 12.68924713134766 4.689247131347656 12.3636360168457 5.090909004211426 12.3636360168457 C 5.492570877075195 12.3636360168457 5.81818151473999 12.68924713134766 5.81818151473999 13.09090900421143 C 5.81818151473999 13.4925708770752 5.492570877075195 13.81818199157715 5.090909004211426 13.81818199157715 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vzgxgf =
    '<svg viewBox="18.0 317.0 12.8 16.0" ><path transform="translate(18.0, 317.0)" d="M 6.400000095367432 16 C 5.516344547271729 16 4.800000190734863 15.28365516662598 4.800000190734863 14.39999961853027 L 8 14.39999961853027 C 8 15.28365516662598 7.283655643463135 16 6.400000095367432 16 Z M 12.80000019073486 13.60000038146973 L 0 13.60000038146973 L 0 12 L 1.600000023841858 11.19999980926514 L 1.600000023841858 6.800000190734863 C 1.600000023841858 4.030400276184082 2.736799955368042 2.234400033950806 4.800000190734863 1.74400007724762 L 4.800000190734863 0 L 8 0 L 8 1.74400007724762 C 10.06319999694824 2.23360013961792 11.19999980926514 4.028800010681152 11.19999980926514 6.800000190734863 L 11.19999980926514 11.19999980926514 L 12.80000019073486 12 L 12.80000019073486 13.60000038146973 Z M 6.400000095367432 3 C 5.423736095428467 2.936961889266968 4.482227802276611 3.37382173538208 3.900000095367432 4.159999847412109 C 3.402036666870117 4.947645664215088 3.157710313796997 5.869105339050293 3.200000047683716 6.800000190734863 L 3.200000047683716 12 L 9.600000381469727 12 L 9.600000381469727 6.800000190734863 C 9.642238616943359 5.869110584259033 9.397915840148926 4.947666645050049 8.90000057220459 4.159999847412109 C 8.31777286529541 3.37382173538208 7.376264095306396 2.936961889266968 6.400000095367432 3 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1tstko =
    '<svg viewBox="16.0 366.0 15.5 16.0" ><path transform="translate(16.0, 366.0)" d="M 9.218043327331543 16 L 6.306044578552246 16 C 5.930136203765869 16 5.604888916015625 15.73840045928955 5.524444103240967 15.37120056152344 L 5.198844432830811 13.86400032043457 C 4.764485359191895 13.67369270324707 4.35262393951416 13.43569850921631 3.970844268798828 13.15440082550049 L 2.501244306564331 13.62240028381348 C 2.142844438552856 13.73669052124023 1.753233432769775 13.58584213256836 1.565244197845459 13.26000022888184 L 0.1060441136360168 10.7391996383667 C -0.0798855796456337 10.41321277618408 -0.01582901552319527 10.00199031829834 0.2604441344738007 9.748000144958496 L 1.400444269180298 8.708000183105469 C 1.348601698875427 8.236888885498047 1.348601698875427 7.761511325836182 1.400444269180298 7.29040002822876 L 0.2604441344738007 6.252799987792969 C -0.01623597182333469 5.99869441986084 -0.08031792938709259 5.586976051330566 0.1060441136360168 5.260800361633301 L 1.562044143676758 2.738399982452393 C 1.750033497810364 2.412558317184448 2.139644622802734 2.261708974838257 2.49804425239563 2.375999927520752 L 3.967644214630127 2.844000101089478 C 4.162894248962402 2.6993248462677 4.366150856018066 2.565779447555542 4.576444149017334 2.444000005722046 C 4.778316020965576 2.33015513420105 4.98607349395752 2.22707724571228 5.198844432830811 2.135200023651123 L 5.525244235992432 0.6295999884605408 C 5.605299949645996 0.2623750269412994 5.930194854736328 0.0003955143038183451 6.306044578552246 0 L 9.218043327331543 0 C 9.593893051147461 0.0003955143038183451 9.918788909912109 0.2623750269412994 9.998844146728516 0.6295999884605408 L 10.328444480896 2.136000156402588 C 10.55307483673096 2.23481297492981 10.77183628082275 2.346463918685913 10.98364448547363 2.470400094985962 C 11.18119049072266 2.584650278091431 11.37215805053711 2.709914445877075 11.55564403533936 2.845599889755249 L 13.02604389190674 2.377600193023682 C 13.38420295715332 2.26373553276062 13.77333354949951 2.414527416229248 13.96124458312988 2.740000009536743 L 15.41724395751953 5.262400150299072 C 15.60317420959473 5.588387489318848 15.53911685943604 5.999610424041748 15.26284408569336 6.253600120544434 L 14.12284469604492 7.293599605560303 C 14.17468643188477 7.764710903167725 14.17468643188477 8.24008846282959 14.12284469604492 8.711199760437012 L 15.26284408569336 9.751199722290039 C 15.53911685943604 10.00518989562988 15.60317420959473 10.41641330718994 15.41724395751953 10.74240016937256 L 13.96124458312988 13.26479911804199 C 13.77333354949951 13.59027194976807 13.38420295715332 13.74106502532959 13.02604389190674 13.62720012664795 L 11.55564403533936 13.15919971466064 C 11.36958408355713 13.29623699188232 11.17623424530029 13.4230899810791 10.97644329071045 13.53919982910156 C 10.76670360565186 13.66072368621826 10.55037021636963 13.77049446105957 10.328444480896 13.86800098419189 L 9.998844146728516 15.37120056152344 C 9.918464660644531 15.73810768127441 9.59365177154541 15.99968719482422 9.218043327331543 16 Z M 4.258044242858887 11.38319969177246 L 4.914044380187988 11.86320018768311 C 5.061924457550049 11.97212314605713 5.216054916381836 12.07229423522949 5.375644207000732 12.16320037841797 C 5.525805950164795 12.25016403198242 5.680417537689209 12.32920551300049 5.838844299316406 12.39999961853027 L 6.585244178771973 12.72720050811768 L 6.950843811035156 14.39999961853027 L 8.574843406677246 14.39999961853027 L 8.940443992614746 12.72640037536621 L 9.686843872070312 12.39920043945312 C 10.01268768310547 12.25550651550293 10.32196617126465 12.07685947418213 10.60924434661865 11.86639976501465 L 11.2660436630249 11.38640022277832 L 12.89884376525879 11.90640068054199 L 13.71084499359131 10.5 L 12.44444370269775 9.345600128173828 L 12.53404426574707 8.53600025177002 C 12.57340240478516 8.181890487670898 12.57340240478516 7.824510097503662 12.53404426574707 7.470400333404541 L 12.44444370269775 6.660799980163574 L 13.71164417266846 5.504000186920166 L 12.89884376525879 4.096799850463867 L 11.2660436630249 4.616799831390381 L 10.60924434661865 4.136799812316895 C 10.32187652587891 3.925368547439575 10.0126371383667 3.74540376663208 9.686843872070312 3.599999904632568 L 8.940443992614746 3.272799968719482 L 8.574843406677246 1.600000023841858 L 6.950843811035156 1.600000023841858 L 6.583644390106201 3.273600101470947 L 5.838844299316406 3.599999904632568 C 5.680288791656494 3.669635057449341 5.525658130645752 3.747885227203369 5.375644207000732 3.834400177001953 C 5.217033863067627 3.925063133239746 5.063718318939209 4.024691104888916 4.916444301605225 4.132800102233887 L 4.259644508361816 4.612799644470215 L 2.627644300460815 4.092800140380859 L 1.814044237136841 5.504000186920166 L 3.0804443359375 6.656800270080566 L 2.990844488143921 7.467199802398682 C 2.951486349105835 7.821309566497803 2.951486349105835 8.178690910339355 2.990844488143921 8.532800674438477 L 3.0804443359375 9.342400550842285 L 1.814044237136841 10.49680042266846 L 2.626044034957886 11.90320014953613 L 4.258044242858887 11.38319969177246 Z M 7.758844375610352 11.19999980926514 C 5.991532802581787 11.19999980926514 4.558844089508057 9.767311096191406 4.558844089508057 8 C 4.558844089508057 6.232688903808594 5.991532802581787 4.800000190734863 7.758844375610352 4.800000190734863 C 9.526155471801758 4.800000190734863 10.95884418487549 6.232688903808594 10.95884418487549 8 C 10.95664024353027 9.766397476196289 9.525241851806641 11.19779586791992 7.758844375610352 11.19999980926514 Z M 7.758844375610352 6.400000095367432 C 6.884760856628418 6.400885581970215 6.173154354095459 7.10307788848877 6.160629272460938 7.977072238922119 C 6.148104190826416 8.851066589355469 6.839296340942383 9.573362350463867 7.712995529174805 9.599294662475586 C 8.586694717407227 9.625227928161621 9.319510459899902 8.945199012756348 9.358843803405762 8.072000503540039 L 9.358843803405762 8.392000198364258 L 9.358843803405762 8 C 9.358843803405762 7.116344451904297 8.642499923706055 6.400000095367432 7.758844375610352 6.400000095367432 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ju9j9w =
    '<svg viewBox="16.0 269.0 16.0 16.0" ><path transform="translate(16.0, 269.0)" d="M 14.22222232818604 16 L 1.777777791023254 16 C 0.7959381937980652 16 0 15.20406150817871 0 14.22222232818604 L 0 1.777777791023254 C 0 0.7959381937980652 0.7959381937980652 0 1.777777791023254 0 L 14.22222232818604 0 C 15.20406150817871 0 16 0.7959381937980652 16 1.777777791023254 L 16 14.22222232818604 C 16 15.20406150817871 15.20406150817871 16 14.22222232818604 16 Z M 1.777777791023254 1.777777791023254 L 1.777777791023254 14.22222232818604 L 14.22222232818604 14.22222232818604 L 14.22222232818604 1.777777791023254 L 1.777777791023254 1.777777791023254 Z M 13.33333301544189 12.44444465637207 L 2.666666746139526 12.44444465637207 L 5.333333492279053 8.888889312744141 L 6.222222328186035 9.777777671813965 L 8.888889312744141 6.222222328186035 L 13.33333301544189 12.44444465637207 Z M 4.888888835906982 7.111111164093018 C 4.152509212493896 7.111111164093018 3.555555582046509 6.514157295227051 3.555555582046509 5.777777671813965 C 3.555555582046509 5.041398048400879 4.152509212493896 4.44444465637207 4.888888835906982 4.44444465637207 C 5.625268459320068 4.44444465637207 6.222222328186035 5.041398048400879 6.222222328186035 5.777777671813965 C 6.222222328186035 6.514157295227051 5.625268459320068 7.111111164093018 4.888888835906982 7.111111164093018 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_obvnu3 =
    '<svg viewBox="16.0 223.0 16.0 12.8" ><path transform="translate(16.0, 223.0)" d="M 14.39999961853027 12.80073356628418 L 1.600000023841858 12.80073356628418 C 0.7444127202033997 12.826340675354 0.02913311682641506 12.15540885925293 0 11.29993438720703 L 0 1.500734210014343 C 0.02913052774965763 0.6453798413276672 0.7445464134216309 -0.02532260492444038 1.600000023841858 0.0007342217722907662 L 14.39999961853027 0.0007342217722907662 C 15.25545310974121 -0.02532260492444038 15.97086906433105 0.6453798413276672 16 1.500734210014343 L 16 11.30073356628418 C 15.97043704986572 12.15589237213135 15.25528526306152 12.8263463973999 14.39999961853027 12.80073356628418 Z M 1.600000023841858 1.600734114646912 L 1.600000023841858 11.19193458557129 L 14.39999961853027 11.20073413848877 L 14.39999961853027 1.609534025192261 L 1.600000023841858 1.600734114646912 Z M 9.144000053405762 9.600733757019043 L 3.200000047683716 9.600733757019043 C 3.258820772171021 8.938381195068359 3.572273254394531 8.324668884277344 4.074399948120117 7.888733863830566 C 4.63346004486084 7.334107875823975 5.38464879989624 7.016099452972412 6.171999931335449 7.000733852386475 C 6.959351539611816 7.016099452972412 7.710539817810059 7.334107875823975 8.269599914550781 7.888733863830566 C 8.77159309387207 8.324773788452148 9.085016250610352 8.93842887878418 9.144000053405762 9.600733757019043 Z M 12.80000019073486 8.80073356628418 L 10.39999961853027 8.80073356628418 L 10.39999961853027 7.20073413848877 L 12.80000019073486 7.20073413848877 L 12.80000019073486 8.80073356628418 Z M 6.171999931335449 6.400733947753906 C 5.743259906768799 6.415632724761963 5.327579021453857 6.251851558685303 5.02423095703125 5.948503494262695 C 4.720882892608643 5.645155429840088 4.557101249694824 5.229474544525146 4.572000026702881 4.800734519958496 C 4.5573410987854 4.372062206268311 4.721200466156006 3.956522941589355 5.024494647979736 3.653228759765625 C 5.327788829803467 3.349934577941895 5.743327617645264 3.186075448989868 6.171999931335449 3.200734376907349 C 6.600672245025635 3.186075448989868 7.016211032867432 3.349934577941895 7.319505214691162 3.653228759765625 C 7.622799396514893 3.956522941589355 7.786658763885498 4.372062206268311 7.772000312805176 4.800734519958496 C 7.786899089813232 5.229474544525146 7.623117446899414 5.645155429840088 7.319769382476807 5.948503494262695 C 7.016420841217041 6.251851558685303 6.600740432739258 6.415632724761963 6.171999931335449 6.400733947753906 Z M 12.80000019073486 5.600734233856201 L 9.600000381469727 5.600734233856201 L 9.600000381469727 4.000734329223633 L 12.80000019073486 4.000734329223633 L 12.80000019073486 5.600734233856201 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String backSvg =
    '<svg viewBox="296.0 45.0 10.0 20.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 306.0, 65.0)" d="M 10 0 L 0 10 L 10 20" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="bevel" /></svg>';
const String camera =
    '<svg width="18" height="11" viewBox="0 0 18 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11.7071 1.53992H3.15389C2.26171 1.53992 1.53845 2.2651 1.53845 3.15966V8.27734C1.53845 9.1719 2.26171 9.89708 3.15389 9.89708H11.7071C12.5993 9.89708 13.3225 9.1719 13.3225 8.27734V3.15966C13.3225 2.2651 12.5993 1.53992 11.7071 1.53992Z" stroke="white" stroke-width="1.5"/><path d="M14.6896 5.06591V6.82959L17 9.12607V2.20288L14.6896 5.06591Z" stroke="white" stroke-width="1.5" stroke-linejoin="round"/></svg>';
