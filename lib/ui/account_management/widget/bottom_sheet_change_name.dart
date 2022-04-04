import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomSheetChangeNameWidget extends StatefulWidget {
  final String? name;

  BottomSheetChangeNameWidget({Key? key, this.name}) : super(key: key);

  @override
  _BottomSheetChangeNameWidgetState createState() =>
      _BottomSheetChangeNameWidgetState();
}

class _BottomSheetChangeNameWidgetState
    extends State<BottomSheetChangeNameWidget> {
  TextEditingController _userAccountController = TextEditingController();
  late UserStore _userStore;
  bool isNotEmpty = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _userAccountController.text = widget.name ?? '';
  }

  void onChangeName() {
    _userStore
        .changeFullName({"newFullName": _userAccountController.text})
        .then((value) => {
              if (value["isOk"])
                {
                  Navigator.of(context).pop(),
                }
              else
                {_showErrorMessage(value["Object"])}
            })
        .catchError((onError) => _showErrorMessage(onError["Object"]));
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              child: Container(
                width: 90.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: const Color(0xffffffff),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
            child:
                // Adobe XD layer: 'Đổi tên' (text)
                Text(
              'Đổi tên',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          TextFieldWidget(
            inputType: TextInputType.emailAddress,
            textController: _userAccountController,
            inputAction: TextInputAction.next,
            autoFocus: false,
            headerText: Text(
              'Tên',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
            onChanged: (text) {
              if (text.length == 0) {
                setState(() {
                  isNotEmpty = false;
                });
                return;
              }
              if (text.length > 0 && !isNotEmpty) {
                setState(() {
                  isNotEmpty = true;
                });
              }
            },
          ),
          Container(
            child:
                // Adobe XD layer: 'Từ 2 - 50 Ký tự' (text)
                Text(
              'Từ  2 - 50 Ký tự',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30.h, bottom: 12.h),
              child: SMEButton(
                  onPress: Navigator.of(context).pop,
                  title: "Hủy",
                  isLoading: _userStore.stringResponseloading,
                  primaryColor: const Color(0xff5a5a5a))),
          Container(
              child: SMEButton(
                  onPress: () => {
                        if (isNotEmpty) {onChangeName()}
                      },
                  title: "Lưu",
                  isLoading: _userStore.stringResponseloading))
        ],
      ),
    );
  }
}
