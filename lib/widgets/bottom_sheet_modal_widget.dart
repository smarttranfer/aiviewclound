import 'dart:convert';

import 'package:aiviewcloud/models/camera/camera_lan.dart';
import 'package:aiviewcloud/stores/device/device_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:crypto/crypto.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

class BottomSheetModalWidget extends StatefulWidget {
  final String? address;
  final BuildContext context;
  BottomSheetModalWidget(
      {Key? key, required this.address, required this.context})
      : super(key: key);

  @override
  _BottomSheetModalState createState() => _BottomSheetModalState();
}

// class _LoginScreenState extends State<LoginScreen> {
class _BottomSheetModalState extends State<BottomSheetModalWidget> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late DeviceStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<DeviceStore>(widget.context);
  }

  late FocusNode _passwordFocusNode = FocusNode();

  void onSubmit() async {
    if (_passwordController.text.length == 0 ||
        _usernameController.text.length == 0) {
      return;
    }
    final codec = const Windows1252Codec(allowInvalid: false);
    final none = codec.encode("aiviewcloud");
    String base64none = base64.encode(none);
    DateTime now = DateTime.now();
    codec.encode(now.toString());
    final credentials = [
      ...none,
      ...codec.encode(now.toString()),
      ...codec.encode(_passwordController.text)
    ];
    var digest = sha1.convert(credentials);
    String password = base64.encode(digest.bytes);

    String body = '{"Envelope": {"Header": ' +
        '{"Security": { "UsernameToken": {"Username": "' +
        _usernameController.text +
        '","Password": "' +
        password +
        '","Nonce": "' +
        base64none +
        '","Created": "' +
        now.toString() +
        '"}}}' +
        ',"Body":{"GetDeviceInformation": ""} }}';
    LanCamera resp = await _store.getCamera(widget.address, body);
    if (resp is LanCamera) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(Routes.lanPtzControl, arguments: {
        'lanCamera': resp,
        'address': widget.address,
        'info': {
          'username': _usernameController.text,
          'password': _passwordController.text
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 403,
      padding: EdgeInsets.all(16.h),
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
      child:
          // Adobe XD layer: 'Group 6419' (group)
          Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              height: 6.h,
              width: 90.w,
              child:
                  // Adobe XD layer: 'Rectangle 1839' (shape)
                  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Container(
              child:
                  // Adobe XD layer: 'Group 6387' (group)
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)
                        .translate('login_user_account'),
                    inputType: TextInputType.text,
                    textController: _usernameController,
                    inputAction: TextInputAction.next,
                    headerText: Container(
                      child:
                          // Adobe XD layer: 'Tên' (text)
                          Text(
                        AppLocalizations.of(context).translate('name'),
                        style: TextStyle(
                          fontFamily: 'SFProDisplay-Regular',
                          fontSize: 17,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                ],
              ),
            ),
            Container(
                child:
                    // Adobe XD layer: 'Group 6405' (group)
                    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child:
                        // Adobe XD layer: 'Nhập mật khẩu' (text)
                        TextFieldWidget(
                  hint:
                      AppLocalizations.of(context).translate('enter_password'),
                  inputType: TextInputType.text,
                  focusNode: _passwordFocusNode,
                  textController: _passwordController,
                  inputAction: TextInputAction.next,
                  isObscure: true,
                  autoFocus: false,
                  headerText: Container(
                    child:
                        // Adobe XD layer: 'Mật khẩu' (text)
                        Text(
                      AppLocalizations.of(context).translate('password'),
                      style: TextStyle(
                        fontFamily: 'SFProDisplay-Regular',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
              ],
            )),
            Container(
              margin: EdgeInsets.only(top: 16.h),
              child:
                  // Adobe XD layer: 'Vui lòng nhập Tên v…' (text)
                  Text(
                AppLocalizations.of(context).translate('lan_auth_desc'),
                style: TextStyle(
                  fontFamily: 'SFProDisplay-Regular',
                  fontSize: 14,
                  color: const Color(0xff818181),
                ),
                textAlign: TextAlign.left,
              ),
            )
          ]),
          Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: SMEButton(
                  title: AppLocalizations.of(context).translate('cancel'),
                  onPress: Navigator.of(context).pop,
                  primaryColor: const Color(0xff5A5A5A),
                )),
            SMEButton(
              title: AppLocalizations.of(context).translate('done'),
              onPress: onSubmit,
            )
          ]),
        ],
      ),
    );
  }
}

const String _svg_wepggw =
    '<svg viewBox="0.0 0.0 343.0 48.0" ><path  d="M 335 0 C 337.1217346191406 1.110223024625157e-15 339.1565856933594 0.8428548574447632 340.6568603515625 2.343145847320557 C 342.1571655273438 3.843436717987061 343 5.878268241882324 343 8 L 343 40 C 343 42.12173080444336 342.1571655273438 44.15656280517578 340.6568603515625 45.65685272216797 C 339.1565856933594 47.15714263916016 337.1217346191406 48 335 48 L 8 48 C 5.878268241882324 48 3.84343695640564 47.15714263916016 2.343145847320557 45.65685272216797 C 0.842854917049408 44.15656280517578 1.165734281735533e-15 42.12173080444336 0 40 L 0 8 C 3.885780586188048e-16 5.878268241882324 0.842854917049408 3.843436717987061 2.343145847320557 2.343145847320557 C 3.84343695640564 0.8428548574447632 5.878268241882324 1.998401444325282e-15 8 0 L 335 0 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_2sxf5i =
    '<svg viewBox="0.0 0.0 343.0 48.0" ><path  d="M 335 0 C 337.1217346191406 1.110223024625157e-15 339.1565856933594 0.8428548574447632 340.6568603515625 2.343145847320557 C 342.1571655273438 3.843436717987061 343 5.878268241882324 343 8 L 343 40 C 343 42.12173080444336 342.1571655273438 44.15656280517578 340.6568603515625 45.65685272216797 C 339.1565856933594 47.15714263916016 337.1217346191406 48 335 48 L 8 48 C 5.878268241882324 48 3.84343695640564 47.15714263916016 2.343145847320557 45.65685272216797 C 0.842854917049408 44.15656280517578 1.165734281735533e-15 42.12173080444336 0 40 L 0 8 C 3.885780586188048e-16 5.878268241882324 0.842854917049408 3.843436717987061 2.343145847320557 2.343145847320557 C 3.84343695640564 0.8428548574447632 5.878268241882324 1.998401444325282e-15 8 0 L 335 0 Z" fill="#5a5a5a" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kchglu =
    '<svg viewBox="0.4 24.0 343.0 47.5" ><path transform="translate(0.39, 24.0)" d="M 335 0 C 339.4182739257812 0 343 3.546777248382568 343 7.921948909759521 L 343 39.60974502563477 C 343 43.98491668701172 339.4182739257812 47.53169250488281 335 47.53169250488281 L 8 47.53169250488281 C 3.581721782684326 47.53169250488281 0 43.98491668701172 0 39.60974502563477 L 0 7.921948909759521 C 0 3.546777248382568 3.581721782684326 0 8 0 L 335 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
