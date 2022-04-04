import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adobe_xd/pinned.dart';
import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:qrcodeplugin/qrcodeplugin.dart';
import 'package:scan/scan.dart';

class AddDeviceByQRCodeScreen extends StatefulWidget {
  @override
  _AddDeviceByQRCodeScreenState createState() =>
      _AddDeviceByQRCodeScreenState();
}

class _AddDeviceByQRCodeScreenState extends State<AddDeviceByQRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController controller;

  // late StreamSubscription<Barcode>? subscription;
  bool isValidSerial = true;
  late CameraP2PStore _cameraP2PStore;
  final _imagePicker = ImagePicker();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddDeviceByQRCodeScreen oldWidget) {
    print('======did update wwidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('======did didChangeDependencies');
    super.didChangeDependencies();
    _cameraP2PStore = Provider.of<CameraP2PStore>(context);
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = MediaQuery.of(context).size.width < 400 ? 240.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xfffd7b38),
          borderRadius: 0,
          borderLength: 30,
          borderWidth: 10,
          cutOutBottomOffset: MediaQuery.of(context).size.height / 6,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  bool isValidSerialNumber(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern =
        r'(^[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Za-z0-9]?[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9])';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  void _onQRViewCreated(QRViewController controller) {
    int count = 0;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code.isNotEmpty) {
        try {
          Map<String, dynamic> json = jsonDecode(scanData.code);
          if (json["serial"] != null) {
            if (isValidSerialNumber(json["serial"])) {
              if (!isValidSerial) {
                setState(() {
                  isValidSerial = true;
                });
              }
              if (count == 0) {
                count++;
                final resp = await _cameraP2PStore
                    .checkDeviceStatus({"serial": json["serial"].toString()});
                Navigator.pushNamed(
                  context,
                  Routes.deviceInfoChecking,
                  arguments: {
                    'serial': json["serial"].toString(),
                    'isError': resp["isError"],
                    'message': resp["isError"] == false
                        ? 'Thiết bị đã tồn tại!'
                        : resp["Object"],
                  },
                ).then((value) {
                  count = 0;
                });
              }
            } else {
              if (isValidSerial) {
                setState(() {
                  isValidSerial = false;
                });
              }
            }
          }
        } catch (e) {
          if (isValidSerial) {
            setState(() {
              isValidSerial = false;
            });
          }
        }
      }
    });
  }

  Future<void> getQRCodeFromPhoto() async {
    await PhotoManager.requestPermissionExtend().then((value) async {
      if (value.isAuth) {
        final pickedFile =
            await _imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          String? data = await Scan.parse(pickedFile.path);
          try {
            Map<String, dynamic> json = jsonDecode(data ?? '');
            if (json["serial"] != null) {
              if (isValidSerialNumber(json["serial"])) {
                if (!isValidSerial) {
                  setState(() {
                    isValidSerial = true;
                  });
                }
                final resp = await _cameraP2PStore
                    .checkDeviceStatus({"serial": json["serial"].toString()});
                Navigator.pushNamed(
                  context,
                  Routes.deviceInfoChecking,
                  arguments: {
                    'serial': json["serial"].toString(),
                    'isError': resp["isError"],
                    'message': resp["isError"] == false ? '' : resp["Object"],
                  },
                );
              } else {
                if (isValidSerial) {
                  setState(() {
                    isValidSerial = false;
                  });
                }
              }
            }
          } catch (e) {
            if (isValidSerial) {
              setState(() {
                isValidSerial = false;
              });
            }
          }
        }
      } else {
        await openAppSettings();
      }
    });
  }

  @override
  void dispose() {
    print('on dispose');
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          HeaderWidget(
            headerText: AppLocalizations.of(context).translate('add_device'),
            onBackPress: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.deviceManagement, (Route<dynamic> route) => false);
            },
            actionWidget: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.addDevice);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(
                    Assets.icPen,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(
              start: 30.0,
              end: 30.0,
            ),
            Pin(size: 17.0, middle: 0.56),
            child: Text(
              'Di chuyển Camera đến  vùng có Mã QR để quét',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 16.0, end: 16.0),
            Pin(size: 48.0, end: 34.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xfffd7b38),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 151.0, middle: 0.5),
                  Pin(size: 20, middle: 0.5),
                  child: GestureDetector(
                    onTap: () async {
                      await getQRCodeFromPhoto();
                    },
                    child: Text(
                      'Quét ảnh có sẵn',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              print(await controller.getFlashStatus());
              await controller.toggleFlash();
            },
            child: Pinned.fromPins(
              Pin(size: 76.0, middle: 0.5016),
              Pin(size: 72.0, end: 114.0),
              child:
                  // Adobe XD layer: 'Group 6303' (group)
                  Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(size: 20.0, middle: 1),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(
                          'Bật đèn',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 4.0, end: 4.0),
                    Pin(size: 48.0, start: 0.0),
                    child:
                        // Adobe XD layer: 'Group 6302' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(size: 48.0, middle: 0.5),
                          Pin(size: 48.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Ellipse 153' (shape)
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              color: const Color(0xff404447),
                            ),
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 26.0, middle: 0.5),
                          Pin(size: 26.0, middle: 0.5),
                          child:
                              // Adobe XD layer: 'Group 6301' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromPins(
                                Pin(start: 0.0, end: 0.0),
                                Pin(start: 0.0, end: 0.0),
                                child:
                                    // Adobe XD layer: 'Vector' (shape)
                                    SvgPicture.string(
                                  _svg_rf7wx3,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromPins(
                                Pin(size: 6.0, middle: 0.5015),
                                Pin(size: 6.0, middle: 0.5836),
                                child:
                                    // Adobe XD layer: 'Vector' (shape)
                                    SvgPicture.string(
                                  _svg_qn8qzq,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 51.0, end: 51.0),
            Pin(size: 32.0, middle: 0.5987),
            child:
                // Adobe XD layer: 'Rectangle 1841' (shape)
                SvgPicture.string(
              _svg_k2,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 20.0, middle: 0.5972),
            child:
                // Adobe XD layer: 'Mã Seri không hợp l…' (text)
                Scrollbar(
              child: SingleChildScrollView(
                child: Text(
                  isValidSerial ? '' : 'Mã Seri không hợp lệ!',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    color: const Color(0xfffd413c),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_rf7wx3 =
    '<svg viewBox="175.0 637.0 26.0 26.0" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 175.0, 650.03)" d="M 18.20791625976562 5.711624622344971 L 12.71910858154297 0.2227716147899628 C 12.57723140716553 0.07961590588092804 12.38381576538086 -0.0006353000062517822 12.18227481842041 3.788030426221667e-06 C 11.98073387145996 -0.0006353000062517822 11.78731727600098 0.07961590588092804 11.64544010162354 0.2227716147899628 L 9.655137062072754 2.23133397102356 C 8.453651428222656 3.432819366455078 8.344093322753906 4.696387767791748 8.731198310852051 5.748144149780273 L 0.2221972048282623 14.24253559112549 C -0.07406574487686157 14.53911781311035 -0.07406574487686157 15.01962280273438 0.2221972048282623 15.31620502471924 L 3.008620977401733 18.11723518371582 C 3.305203437805176 18.41349792480469 3.785706758499146 18.41349792480469 4.082289218902588 18.11723518371582 L 12.55111980438232 9.66301441192627 C 12.9169979095459 9.819955825805664 13.31067657470703 9.901942253112793 13.70878314971924 9.90404224395752 C 14.6589241027832 9.871631622314453 15.55843925476074 9.4677734375 16.2140064239502 8.779247283935547 L 18.20796203613281 6.785293102264404 C 18.50417900085449 6.488710403442383 18.50417900085449 6.008207321166992 18.20791625976562 5.711624622344971 Z M 3.567321062088013 17.58770561218262 L 3.541757345199585 17.60231399536133 L 0.7407258749008179 14.79762935638428 C 0.7300439476966858 14.78635406494141 0.7300439476966858 14.76873397827148 0.7407258749008179 14.75745868682861 L 1.182609677314758 14.28270721435547 L 4.027464389801025 17.12756156921387 L 3.567321062088013 17.58770561218262 Z M 4.557040214538574 16.62724876403809 L 1.712185382843018 13.78239345550537 L 9.070827484130859 6.427403926849365 C 9.237812042236328 6.691849231719971 9.433784484863281 6.936802864074707 9.655137062072754 7.157790184020996 L 11.27659511566162 8.779247283935547 C 11.46439552307129 8.969512939453125 11.66844749450684 9.143071174621582 11.88646793365479 9.297821998596191 L 4.557040214538574 16.62724876403809 Z M 15.70273685455322 8.260672569274902 L 15.95837306976318 8.519960403442383 L 15.69908428192139 8.260672569274902 C 15.23894119262695 8.717164039611816 13.60287666320801 10.08663845062256 11.79151821136475 8.260672569274902 L 10.17005920410156 6.63921594619751 C 9.713567733764648 6.179072380065918 8.344093322753906 4.543006896972656 10.17005920410156 2.727996826171875 L 11.08669471740723 1.811361908912659 L 16.61937141418457 7.344038009643555 L 15.70273685455322 8.260672569274902 Z M 17.69299507141113 6.270370960235596 L 17.13424873352051 6.829115867614746 L 11.60522365570068 1.296439409255981 L 12.16396999359131 0.7376939058303833 L 12.18588066101074 0.7376939058303833 L 12.20413970947266 0.7376939058303833 L 17.68203735351562 6.215591907501221 C 17.69810676574707 6.217189788818359 17.70979499816895 6.231523036956787 17.70819664001465 6.247591495513916 C 17.70723724365234 6.257223606109619 17.7015323638916 6.26576042175293 17.69299507141113 6.270370960235596 Z" fill="#ffffff" stroke="#ffffff" stroke-width="0.30000001192092896" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qn8qzq =
    '<svg viewBox="185.0 648.7 6.0 6.0" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 185.05, 651.68)" d="M 3.998295068740845 0.7276140451431274 L 3.487024784088135 0.2163428068161011 C 3.187246799468994 -0.0721142590045929 2.713135004043579 -0.0721142590045929 2.413357019424438 0.2163428068161011 L 0.2221972793340683 2.407502889633179 C -0.07406575977802277 2.7040855884552 -0.07406575977802277 3.184589385986328 0.2221972793340683 3.48117208480835 L 0.7334677577018738 3.992441892623901 C 1.03005039691925 4.288704872131348 1.510552883148193 4.288704872131348 1.807135462760925 3.992441892623901 L 3.998295068740845 1.801281929016113 C 4.294558048248291 1.504699230194092 4.294558048248291 1.024196624755859 3.998295068740845 0.7276140451431274 Z M 3.487070560455322 1.282707452774048 L 1.295910954475403 3.473868131637573 C 1.284087777137756 3.482997894287109 1.267562747001648 3.482997894287109 1.255739569664001 3.473868131637573 L 0.7517731189727783 2.958944797515869 L 0.7517731189727783 2.918774127960205 L 2.942932844161987 0.7276140451431274 L 2.983103513717651 0.7276140451431274 L 3.494374752044678 1.238884568214417 L 3.487070560455322 1.282707452774048 Z" fill="#ffffff" stroke="#ffffff" stroke-width="0.30000001192092896" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_k2 =
    '<svg viewBox="51.0 467.0 273.0 32.0" ><path transform="translate(51.0, 467.0)" d="M 6.36734676361084 0 L 266.6326599121094 0 C 270.1492309570312 0 273 2.387814521789551 273 5.333333015441895 L 273 26.66666603088379 C 273 29.61218452453613 270.1492309570312 32 266.6326599121094 32 L 6.36734676361084 32 C 2.850758075714111 32 0 29.61218452453613 0 26.66666603088379 L 0 5.333333015441895 C 0 2.387814521789551 2.850758075714111 0 6.36734676361084 0 Z" fill="#2b2f33" fill-opacity="0.3" stroke="none" stroke-width="1" stroke-opacity="0.3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
