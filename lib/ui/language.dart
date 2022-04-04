import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/language/Language.dart';
import 'package:aiviewcloud/stores/language/language_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'device_management/device_management.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<LanguageScreen> {
  late UserStore _userStore;
  late LanguageStore _languageStore;

  bool isEmpty = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              HeaderWidget(
                  headerText: AppLocalizations.of(context)
                      .translate("home_tv_choose_language")),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: _languageStore.supportedLanguages
                        .map(
                          (object) => Container(
                            // color: Colors.white,
                            // margin: EdgeInsets.only(bottom: 16),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(
                                        object.language == 'vi'
                                            ? Assets.vietnamese
                                            : Assets.english,
                                        fit: BoxFit.cover,
                                        width: 23,
                                        height: 23),
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate(object.language!),
                                        style: const TextStyle(
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFProDisplay",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 17.0),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ]),
                                  Radio<String>(
                                    value: object.language!,
                                    groupValue: _languageStore.locale,
                                    onChanged: (value) {
                                      _languageStore.changeLanguage(value!);
                                    },
                                  ),
                                ]),
                          ),
                        )
                        .toList(),
                  )),
            ]))));
  }
}
