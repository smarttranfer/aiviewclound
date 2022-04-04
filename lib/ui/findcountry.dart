import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/strings.dart';
import 'package:aiviewcloud/models/country/country.dart';
import 'package:aiviewcloud/models/country/country_list.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/debound.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
import 'package:aiviewcloud/widgets/header_widget.dart';
import 'package:aiviewcloud/widgets/select_country_bottom_sheet.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindCountry extends StatefulWidget {
  final bool isModal;

  FindCountry({Key? key, this.isModal = false}) : super(key: key);

  @override
  _FindCountryState createState() => _FindCountryState();
}

class _FindCountryState extends State<FindCountry> {
  TextEditingController _searcController = TextEditingController();

  late int expandIndex = -1;
  late int lastIndex = -1;
  late String selectedCountryCode = "";
  Country? selectedCountry;
  late CountryList countryArr = new CountryList(coutries: []);
  final _debouncer = Debouncer(milliseconds: 500);
  bool showSearch = false;
  bool loading = true;
  late UserStore _store;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getCurrentPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentLocation = prefs.getString(Strings.currentLocation);
    if (currentLocation != null) {
      try {
        Map<String, dynamic> jsonLocation = json.decode(currentLocation);
        if (jsonLocation['Code'] != null) {
          Country country = Country.fromJson(jsonLocation);
          setState(() {
            loading = false;
            selectedCountryCode = country.code!;
            selectedCountry = country;
          });
        }
      } catch (e) {
        print(e);
      }
    } else {
      final hasPermission = await _handlePermission();
      if (!hasPermission) {
        return;
      }
      final position = await _geolocatorPlatform.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      var first = placemarks.first;
      Country foundedCountry =
          await _store.getDetailCountryByCode(first.isoCountryCode!);
      await prefs.setString(
          Strings.currentLocation, jsonEncode(foundedCountry));
      setState(() {
        loading = false;
        selectedCountryCode = first.isoCountryCode!;
        selectedCountry = foundedCountry;
      });
    }
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<UserStore>(context);
    _getCurrentPosition();

    if (_store.continents == null) {
      _store.getContinents();
    }
  }

  void _onSearchChanged(dynamic query) {
    if (query.length > 0) {
      setState(() {
        showSearch = true;
      });
      _debouncer.run(() => {
            _store.searchCountry({"Name": query})
          });
    } else {
      setState(() {
        showSearch = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildListView() {
    return _store.continents != null
        ? ListView.separated(
            itemCount: _store.continents!.length,
            padding: EdgeInsets.only(top: 0),
            separatorBuilder: (BuildContext context, int index) => Container(
                height: 1,
                child: Container(
                  child:
                      // Adobe XD layer: 'Line 17' (shape)
                      SvgPicture.string(
                    line,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                )),
            itemBuilder: (context, position) {
              return ExpansionTile(
                tilePadding: EdgeInsets.only(left: 0),
                title: Text(
                  _store.continents![position].nameVi,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.left,
                ),
                onExpansionChanged: (value) {
                  if (expandIndex != position && lastIndex != position) {
                    getCountryList(_store.continents!.elementAt(position).code);
                  }
                  setState(() {
                    expandIndex = position == expandIndex ? -1 : position;
                    lastIndex = position;
                  });
                },
                trailing: Container(
                  width: 16,
                  height: 16,
                  child: Container(
                    child:
                        // Adobe XD layer: 'Line 21' (shape)
                        SvgPicture.string(
                      next,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                children: _store.loading ? [] : _buildCountryList(),
              );
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  List<Widget> _buildCountryList() {
    return countryArr.coutries!.map((e) => _buildCountryListItem(e)).toList();
  }

  Widget? _buildSearchCountryList() {
    return _store.countryList != null
        ? ListView.separated(
            itemCount: _store.countryList!.coutries!.length,
            padding: EdgeInsets.only(top: 0),
            separatorBuilder: (BuildContext context, int index) => Container(
                height: 1,
                child: Container(
                  child:
                      // Adobe XD layer: 'Line 17' (shape)
                      SvgPicture.string(
                    line,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                )),
            itemBuilder: (context, position) {
              return ListTile(
                title: Text(
                  _store.countryList?.coutries![position].name ?? '',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Container(
                  width: 20,
                  height: 20,
                  child: selectedCountryCode ==
                          _store.countryList?.coutries![position].code
                      ? SelectedCountry()
                      : UnSelected(),
                ),
                onTap: () {
                  setState(() {
                    loading = false;
                    selectedCountryCode =
                        _store.countryList!.coutries![position].code!;
                    selectedCountry = _store.countryList?.coutries![position];
                  });
                },
              );
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  Widget _buildCountryListItem(Country position) {
    return Column(children: [
      ListTile(
        title: Text(
          position.name ?? '',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 14,
            color: const Color(0xffffffff),
          ),
          textAlign: TextAlign.left,
        ),
        trailing: Container(
          width: 20,
          height: 20,
          child: selectedCountryCode == position.code
              ? SelectedCountry()
              : UnSelected(),
        ),
        onTap: () {
          setState(() {
            loading = false;
            selectedCountryCode = position.code!;
            selectedCountry = position;
          });
        },
      ),
    ]);
  }

  void getCountryList(code) async {
    CountryList data = await _store.getCountry({"Code": code});
    setState(() {
      countryArr = data;
    });
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
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              widget.isModal
                  ? Container(
                      width: 90.w,
                      height: 6,
                      margin: EdgeInsets.only(top: 16.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: const Color(0xffffffff)))
                  : HeaderWidget(
                      headerText: AppLocalizations.of(context)
                          .translate('choose_country')),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 23, bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(right: 8.h),
                                          child: SvgPicture.string(
                                            _svg_3wu8kj,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          )),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child:
                                                // Adobe XD layer: 'Việt Nam' (text)
                                                loading
                                                    ? Container(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator())
                                                    : Text(
                                                        selectedCountry?.name ??
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'not_choose_country'),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'SF Pro Display',
                                                          fontSize: 17,
                                                          color: const Color(
                                                              0xffffffff),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4.h),
                                            child:
                                                // Adobe XD layer: 'Quốc gia định vị' (text)
                                                Text(
                                              AppLocalizations.of(context)
                                                  .translate('located_country'),
                                              style: TextStyle(
                                                fontFamily: 'SF Pro Display',
                                                fontSize: 14,
                                                color: const Color(0xff818181),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                Container(
                                    margin: EdgeInsets.only(right: 8.h),
                                    child: SvgPicture.string(
                                      dotString,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    )),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 16.h),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                decoration: BoxDecoration(
                                    color: const Color(0xff626262))),
                            // Container(
                            //   child:
                            //       // Adobe XD layer: 'Line 17' (shape)
                            //       SvgPicture.string(
                            //     _svg_hafds1,
                            //     allowDrawingOutsideViewBox: true,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            Container(
                              child: TextFieldWidget(
                                hint: AppLocalizations.of(context)
                                    .translate('search_country_hint'),
                                textController: _searcController,
                                inputAction: TextInputAction.next,
                                autoFocus: false,
                                onChanged: _onSearchChanged,
                                suffixIcon: Container(
                                  width: 16,
                                  height: 16,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  alignment: Alignment.center,
                                  child:

                                      // Adobe XD layer: 'Vector' (shape)
                                      SvgPicture.string(
                                    _svg_qhuzq5,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // Adobe XD layer: 'Chọn hoặc nhập tìm …' (text)
                            ),
                          ]),
                          Expanded(
                            child: Observer(
                              builder: (context) {
                                return !showSearch
                                    ? _buildListView()
                                    : _buildSearchCountryList() ?? Container();
                              },
                            ),
                          ),
                          // Adobe XD layer: 'Group' (group)
                          SMEButton(
                            onPress: () {
                              try {
                                print(selectedCountry);
                                _store.onSelectedCountry(selectedCountry!);
                                widget.isModal
                                    ? Navigator.of(context).pop()
                                    : Navigator.of(context)
                                        .pushNamed(Routes.policy);
                              } catch (error) {
                                _showErrorMessage(AppLocalizations.of(context)
                                    .translate("not_select_country"));
                              }
                            },
                            title: widget.isModal
                                ? AppLocalizations.of(context).translate('done')
                                : AppLocalizations.of(context)
                                    .translate('continue'),
                          )
                        ],
                      ))),
            ])));
  }
}

// const String_svg_o2muup =
//     '<svg viewBox="331.4 19.0 22.0 11.3" ><path transform="translate(331.45, 19.0)" d="M 2.66700005531311 0 L 19.33300018310547 0 C 20.80594444274902 0 22 1.194056630134583 22 2.66700005531311 L 22 8.666000366210938 C 22 10.13894367218018 20.80594444274902 11.33300018310547 19.33300018310547 11.33300018310547 L 2.66700005531311 11.33300018310547 C 1.194056630134583 11.33300018310547 0 10.13894367218018 0 8.666000366210938 L 0 2.66700005531311 C 0 1.194056630134583 1.194056630134583 0 2.66700005531311 0 Z" fill="#ffffff" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_7zzpga =
//     '<svg viewBox="354.4 22.7 1.3 4.0" ><path transform="translate(354.45, 22.67)" d="M 0 2.220446049250313e-16 L 0 4 C 0.3935926258563995 3.834296226501465 0.7295427322387695 3.55614161491394 0.9657710194587708 3.200376033782959 C 1.201999306678772 2.844610452651978 1.32800304889679 2.427051544189453 1.327999949455261 2 C 1.32800304889679 1.572948575019836 1.201999306678772 1.155389547348022 0.9657710194587708 0.7996240258216858 C 0.7295427322387695 0.4438585042953491 0.3935926258563995 0.1657038182020187 2.220446049250313e-16 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_8unnsq =
//     '<svg viewBox="333.4 21.0 18.0 7.3" ><path transform="translate(333.45, 21.0)" d="M 1.33299994468689 0 L 16.66699981689453 0 C 17.40319442749023 0 18 0.5968043804168701 18 1.33299994468689 L 18 6 C 18 6.73619556427002 17.40319442749023 7.333000183105469 16.66699981689453 7.333000183105469 L 1.33299994468689 7.333000183105469 C 0.5968043804168701 7.333000183105469 0 6.73619556427002 0 6 L 0 1.33299994468689 C 0 0.5968043804168701 0.5968043804168701 0 1.33299994468689 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_6tpr3i =
//     '<svg viewBox="311.1 18.0 15.3 13.0" ><path transform="translate(311.12, 18.0)" d="M 7.667769908905029 13 C 7.624964714050293 12.99906158447266 7.582889556884766 12.98872184753418 7.544525146484375 12.96971225738525 C 7.506160736083984 12.95070266723633 7.472446441650391 12.92348957061768 7.445770263671875 12.89000034332275 L 5.439770221710205 10.5 C 5.3775954246521 10.4230260848999 5.34451961517334 10.32661247253418 5.346348285675049 10.22768115997314 C 5.348176956176758 10.12874984741211 5.384793281555176 10.03362369537354 5.449769973754883 9.958999633789062 C 5.737918853759766 9.66071891784668 6.082252025604248 9.422415733337402 6.462923526763916 9.257823944091797 C 6.843595027923584 9.093232154846191 7.253077507019043 9.005607604980469 7.667769908905029 9 C 8.082701683044434 9.005606651306152 8.492417335510254 9.093323707580566 8.873273849487305 9.258092880249023 C 9.254130363464355 9.42286205291748 9.598587036132812 9.661418914794922 9.886770248413086 9.960000038146973 C 9.951788902282715 10.03465270996094 9.988348007202148 10.12987422943115 9.989995002746582 10.22885799407959 C 9.991641998291016 10.32784175872803 9.958271026611328 10.42422580718994 9.895771026611328 10.50100040435791 L 7.889770030975342 12.89000034332275 C 7.863093852996826 12.92348957061768 7.829379558563232 12.95070266723633 7.791015148162842 12.96971225738525 C 7.752650737762451 12.98872184753418 7.710575103759766 12.99906158447266 7.667769908905029 13 Z M 11.19077014923096 8.805999755859375 C 11.14989948272705 8.805482864379883 11.10960388183594 8.796302795410156 11.07254219055176 8.779065132141113 C 11.03548049926758 8.76182746887207 11.00249862670898 8.73692512512207 10.97577095031738 8.706000328063965 C 10.55832386016846 8.240079879760742 10.04886054992676 7.865714073181152 9.479512214660645 7.606512546539307 C 8.910163879394531 7.347311019897461 8.293281555175781 7.208896636962891 7.667769908905029 7.199999809265137 C 7.043233394622803 7.208670139312744 6.427237987518311 7.346399784088135 5.858478546142578 7.604535579681396 C 5.289719104766846 7.862671375274658 4.780486583709717 8.235635757446289 4.362770080566406 8.699999809265137 C 4.336616992950439 8.732362747192383 4.303556442260742 8.758466720581055 4.266009330749512 8.776398658752441 C 4.228462219238281 8.794330596923828 4.187379360198975 8.803637504577637 4.145770072937012 8.803637504577637 C 4.104160785675049 8.803637504577637 4.063077926635742 8.794330596923828 4.025530815124512 8.776398658752441 C 3.987983703613281 8.758466720581055 3.954923152923584 8.732362747192383 3.928770065307617 8.699999809265137 L 2.768769979476929 7.315000057220459 C 2.706062793731689 7.238220691680908 2.671810626983643 7.142132759094238 2.671810626983643 7.043000221252441 C 2.671810626983643 6.943867683410645 2.706062793731689 6.847779273986816 2.768769979476929 6.770999908447266 C 3.379574060440063 6.068788051605225 4.131803035736084 5.503499984741211 4.976210117340088 5.112143039703369 C 5.820617198944092 4.720786094665527 6.738160610198975 4.512186050415039 7.668770313262939 4.5 C 8.599499702453613 4.512624740600586 9.517075538635254 4.721620559692383 10.36146450042725 5.113313674926758 C 11.20585346221924 5.505006790161133 11.95802688598633 6.07056999206543 12.56877040863037 6.77299976348877 C 12.63147735595703 6.84977912902832 12.66573047637939 6.945867538452148 12.66573047637939 7.045000076293945 C 12.66573047637939 7.144132614135742 12.63147735595703 7.240220546722412 12.56877040863037 7.316999912261963 L 11.40977096557617 8.699999809265137 C 11.38325977325439 8.732630729675293 11.34990310668945 8.759037971496582 11.31205940246582 8.777355194091797 C 11.27421569824219 8.795672416687012 11.23281002044678 8.805450439453125 11.19077014923096 8.805999755859375 L 11.19077014923096 8.805999755859375 Z M 13.85977077484131 5.624000072479248 C 13.81883335113525 5.623874187469482 13.77841091156006 5.614867687225342 13.74129199981689 5.597603321075439 C 13.70417308807373 5.580338954925537 13.67124271392822 5.555226802825928 13.64477062225342 5.52400016784668 C 12.90781497955322 4.653919219970703 11.99310398101807 3.951717376708984 10.9621467590332 3.464612722396851 C 9.93118953704834 2.977508068084717 8.80788516998291 2.716793537139893 7.667769908905029 2.700000047683716 C 6.527806282043457 2.716221570968628 5.404520988464355 2.976274013519287 4.373409748077393 3.462679862976074 C 3.34229850769043 3.949085712432861 2.427252292633057 4.650574207305908 1.689770102500916 5.519999980926514 C 1.664071559906006 5.553214550018311 1.631107211112976 5.580102443695068 1.593405365943909 5.598601341247559 C 1.555703520774841 5.617100238800049 1.514265775680542 5.626718044281006 1.472270131111145 5.626718044281006 C 1.430274486541748 5.626718044281006 1.388836622238159 5.617100238800049 1.351134777069092 5.598601341247559 C 1.313432931900024 5.580102443695068 1.280468583106995 5.553214550018311 1.254770040512085 5.519999980926514 L 0.09477010369300842 4.131999969482422 C 0.03342462703585625 4.055379390716553 -9.367506770274758e-17 3.960152864456177 0 3.861999988555908 C -1.457167719820518e-16 3.76384711265564 0.03342462703585625 3.668620586395264 0.09477010369300842 3.592000007629395 C 1.025538802146912 2.485098838806152 2.18357515335083 1.591421365737915 3.490261554718018 0.9716381430625916 C 4.796947956085205 0.3518549799919128 6.221692085266113 0.0204766783863306 7.667769908905029 0 C 9.113386154174805 0.02064345590770245 10.53763484954834 0.3521116375923157 11.84381103515625 0.9718981981277466 C 13.14998722076416 1.591684818267822 14.30750560760498 2.485276699066162 15.23777103424072 3.592000007629395 C 15.29911613464355 3.668620586395264 15.33254051208496 3.76384711265564 15.33254051208496 3.861999988555908 C 15.33254051208496 3.960152864456177 15.29911613464355 4.055379390716553 15.23777103424072 4.131999969482422 L 14.07977104187012 5.514999866485596 C 14.05344295501709 5.548232078552246 14.02003192901611 5.575171947479248 13.98197269439697 5.593855381011963 C 13.94391345977783 5.612538814544678 13.90216541290283 5.622495651245117 13.85977077484131 5.623000144958496 L 13.85977077484131 5.624000072479248 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_eydtws =
//     '<svg viewBox="289.1 18.3 17.0 12.7" ><path transform="translate(289.11, 18.34)" d="M 16.00326156616211 12.66699981689453 L 15.00326061248779 12.66699981689453 C 14.71422386169434 12.63979339599609 14.44744110107422 12.50013160705566 14.2603931427002 12.27810573577881 C 14.07334518432617 12.05607986450195 13.98100280761719 11.76945972442627 14.00326061248779 11.47999954223633 L 14.00326061248779 1.187000036239624 C 13.98100280761719 0.8975398540496826 14.07334518432617 0.6109204292297363 14.2603931427002 0.3888942897319794 C 14.44744110107422 0.1668681800365448 14.71422386169434 0.02720663137733936 15.00326061248779 1.665334536937735e-16 L 16.00326156616211 0 C 16.29229927062988 0.02720663137733936 16.55908012390137 0.1668681800365448 16.74612808227539 0.3888942897319794 C 16.93317604064941 0.6109204292297363 17.02552032470703 0.8975398540496826 17.00326156616211 1.187000036239624 L 17.00326156616211 11.47900009155273 C 17.02579498291016 11.76862525939941 16.9335765838623 12.05550098419189 16.74650192260742 12.27774715423584 C 16.55942726135254 12.49999332427979 16.2924861907959 12.63979625701904 16.00326156616211 12.66699981689453 L 16.00326156616211 12.66699981689453 Z M 11.33626079559326 12.66699981689453 L 10.33626079559326 12.66699981689453 C 10.0472240447998 12.63979339599609 9.780441284179688 12.50013160705566 9.593393325805664 12.27810573577881 C 9.406345367431641 12.05607986450195 9.314002990722656 11.76945972442627 9.336260795593262 11.47999954223633 L 9.336260795593262 3.959000110626221 C 9.314002990722656 3.669539928436279 9.406345367431641 3.382920503616333 9.593393325805664 3.160894393920898 C 9.780441284179688 2.938868284225464 10.0472240447998 2.799206733703613 10.33626079559326 2.772000074386597 L 11.33626079559326 2.772000074386597 C 11.62529754638672 2.799206733703613 11.89207935333252 2.938868284225464 12.07912731170654 3.160894393920898 C 12.26617527008057 3.382920503616333 12.35851860046387 3.669539928436279 12.33626079559326 3.959000110626221 L 12.33626079559326 11.47999954223633 C 12.35853099822998 11.76930236816406 12.26632404327393 12.05578422546387 12.07948589324951 12.27778244018555 C 11.8926477432251 12.49978065490723 11.62611675262451 12.63954734802246 11.33726024627686 12.66699981689453 L 11.33626079559326 12.66699981689453 Z M 6.669260501861572 12.66699981689453 L 5.669260501861572 12.66699981689453 C 5.380223274230957 12.63979339599609 5.113441467285156 12.50013160705566 4.926393508911133 12.27810573577881 C 4.739345550537109 12.05607986450195 4.647002696990967 11.76945972442627 4.669260501861572 11.47999954223633 L 4.669260501861572 6.729000091552734 C 4.647002696990967 6.439539909362793 4.739345550537109 6.152920722961426 4.926393508911133 5.930894374847412 C 5.113441467285156 5.708868026733398 5.380223274230957 5.569206237792969 5.669260501861572 5.541999816894531 L 6.669260501861572 5.541999816894531 C 6.958297729492188 5.569206237792969 7.225079536437988 5.708868026733398 7.412127494812012 5.930894374847412 C 7.599175453186035 6.152920722961426 7.691518306732178 6.439539909362793 7.669260501861572 6.729000091552734 L 7.669260501861572 11.47999954223633 C 7.691518306732178 11.76945972442627 7.599175453186035 12.05607986450195 7.412127494812012 12.27810573577881 C 7.225079536437988 12.50013160705566 6.958297729492188 12.63979339599609 6.669260501861572 12.66699981689453 L 6.669260501861572 12.66699981689453 Z M 2.003260612487793 12.66699981689453 L 1.003260731697083 12.66699981689453 C 0.7142237424850464 12.63979339599609 0.4474418163299561 12.50013160705566 0.2603936791419983 12.27810573577881 C 0.07334555685520172 12.05607986450195 -0.01899724081158638 11.76945972442627 0.003260678611695766 11.47999954223633 L 0.003260678611695766 9.100000381469727 C -0.01791370287537575 8.811094284057617 0.07489818334579468 8.525383949279785 0.2618142068386078 8.304075241088867 C 0.4487302303314209 8.082766532897949 0.7148842811584473 7.943460941314697 1.003260731697083 7.915999889373779 L 2.003260612487793 7.915999889373779 C 2.291636943817139 7.943460941314697 2.557790994644165 8.082766532897949 2.744707107543945 8.304075241088867 C 2.931623220443726 8.525383949279785 3.024435043334961 8.811094284057617 3.003260612487793 9.100000381469727 L 3.003260612487793 11.47500038146973 C 3.026895523071289 11.76528453826904 2.935181379318237 12.05318927764893 2.747995376586914 12.2763147354126 C 2.560809373855591 12.49944019317627 2.293233633041382 12.63980960845947 2.003260612487793 12.66699981689453 L 2.003260612487793 12.66699981689453 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_rwn8iy =
//     '<svg viewBox="0.0 0.0 375.0 44.0" ><path  d="M 0 0 L 375 0 L 375 44 L 0 44 L 0 0 Z" fill="#212529" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_8ykicy =
//     '<svg viewBox="17.0 58.0 10.0 20.0" ><path transform="translate(17.0, 58.0)" d="M 10 0 L 0 10 L 10 20" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="bevel" /></svg>';
// const String _svg_46jblu =
//     '<svg viewBox="338.0 291.0 20.0 20.0" ><path transform="translate(338.0, 291.0)" d="M 20 10 C 20 15.52284812927246 15.52284812927246 20 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 C 15.52284812927246 0 20 4.477152347564697 20 10 Z" fill="none" stroke="#818181" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_j5xczi =
//     '<svg viewBox="338.8 291.8 18.5 18.5" ><path transform="translate(338.75, 291.75)" d="M 18.5 9.25 C 18.5 14.35863399505615 14.35863399505615 18.5 9.25 18.5 C 4.141366004943848 18.5 0 14.35863399505615 0 9.25 C 0 4.141366004943848 4.141366004943848 0 9.25 0 C 14.35863399505615 0 18.5 4.141366004943848 18.5 9.25 Z" fill="none" stroke="#818181" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_im2nen =
//     '<svg viewBox="16.0 324.5 343.0 1.0" ><path transform="translate(16.0, 324.5)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_1i4kuo =
//     '<svg viewBox="338.0 342.0 20.0 20.0" ><path transform="translate(338.0, 342.0)" d="M 20 10 C 20 15.52284812927246 15.52284812927246 20 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 C 15.52284812927246 0 20 4.477152347564697 20 10 Z" fill="none" stroke="#818181" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_wkyzsu =
//     '<svg viewBox="338.8 342.8 18.5 18.5" ><path transform="translate(338.75, 342.75)" d="M 18.5 9.25 C 18.5 14.35863399505615 14.35863399505615 18.5 9.25 18.5 C 4.141366004943848 18.5 0 14.35863399505615 0 9.25 C 0 4.141366004943848 4.141366004943848 0 9.25 0 C 14.35863399505615 0 18.5 4.141366004943848 18.5 9.25 Z" fill="none" stroke="#818181" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_zehxj3 =
//     '<svg viewBox="16.0 375.5 343.0 1.0" ><path transform="translate(16.0, 375.5)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_i199tk =
//     '<svg viewBox="338.0 393.0 20.0 20.0" ><path transform="translate(338.0, 393.0)" d="M 20 10 C 20 15.52284812927246 15.52284812927246 20 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 C 15.52284812927246 0 20 4.477152347564697 20 10 Z" fill="none" stroke="#818181" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_xnqki =
//     '<svg viewBox="338.8 393.8 18.5 18.5" ><path transform="translate(338.75, 393.75)" d="M 18.5 9.25 C 18.5 14.35863399505615 14.35863399505615 18.5 9.25 18.5 C 4.141366004943848 18.5 0 14.35863399505615 0 9.25 C 0 4.141366004943848 4.141366004943848 0 9.25 0 C 14.35863399505615 0 18.5 4.141366004943848 18.5 9.25 Z" fill="none" stroke="#818181" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_j56w1t =
//     '<svg viewBox="16.0 426.5 343.0 1.0" ><path transform="translate(16.0, 426.5)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_2crlxd =
//     '<svg viewBox="16.0 477.5 343.0 1.0" ><path transform="translate(16.0, 477.5)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_em5ddr =
//     '<svg viewBox="16.0 527.0 343.0 1.0" ><path transform="translate(16.0, 527.0)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_i1aoov =
//     '<svg viewBox="16.0 576.0 343.0 1.0" ><path transform="translate(16.0, 576.0)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_l5fy9r =
//     '<svg viewBox="16.0 625.0 343.0 1.0" ><path transform="translate(16.0, 625.0)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_2u64e9 =
//     '<svg viewBox="338.0 444.0 20.0 20.0" ><path transform="translate(338.0, 444.0)" d="M 10 1.413226629259141e-29 C 11.97781276702881 -3.33066907387547e-15 13.91121101379395 0.5864897966384888 15.55570220947266 1.685303926467896 C 17.20019340515137 2.784118175506592 18.48192024230957 4.34590482711792 19.23879623413086 6.173165798187256 C 19.99567222595215 8.00042724609375 20.19370651245117 10.01109313964844 19.80785369873047 11.95090293884277 C 19.42200088500977 13.89071273803711 18.4695930480957 15.67254257202148 17.07106781005859 17.07106781005859 C 15.67254257202148 18.4695930480957 13.89071273803711 19.42200088500977 11.95090293884277 19.80785369873047 C 10.01109313964844 20.19370651245117 8.00042724609375 19.99567222595215 6.173165798187256 19.23879623413086 C 4.34590482711792 18.48192024230957 2.784118175506592 17.20019340515137 1.685303926467896 15.55570220947266 C 0.5864897966384888 13.91121101379395 7.216449660063518e-16 11.97781276702881 0 10 C 0 7.347835063934326 1.053568363189697 4.804296016693115 2.928932189941406 2.928932189941406 C 4.804296016693115 1.053568363189697 7.347835063934326 3.108624468950438e-15 10 1.332267629550188e-15 L 10 1.413226629259141e-29 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_ra9wpx =
//     '<svg viewBox="338.0 444.0 20.0 20.0" ><path transform="translate(338.0, 444.0)" d="M 10 1.5 C 5.313079833984375 1.5 1.5 5.313079833984375 1.5 10 C 1.5 14.68692016601562 5.313079833984375 18.5 10 18.5 C 14.68692016601562 18.5 18.5 14.68692016601562 18.5 10 C 18.5 5.313079833984375 14.68692016601562 1.5 10 1.5 Z M 10 0 C 15.52285003662109 0 20 4.477149963378906 20 10 C 20 15.52285003662109 15.52285003662109 20 10 20 C 4.477149963378906 20 0 15.52285003662109 0 10 C 0 4.477149963378906 4.477149963378906 0 10 0 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_h8w6wf =
//     '<svg viewBox="345.0 451.0 6.0 6.0" ><path transform="translate(345.0, 451.0)" d="M 6 3 C 6 4.656854152679443 4.656854152679443 6 3 6 C 1.343145728111267 6 0 4.656854152679443 0 3 C 0 1.343145728111267 1.343145728111267 0 3 0 C 4.656854152679443 0 6 1.343145728111267 6 3 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_okl9kv =
//     '<svg viewBox="16.0 674.0 343.0 1.0" ><path transform="translate(16.0, 674.0)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_3l2kyl =
//     '<svg viewBox="342.4 261.5 16.0 8.0" ><path transform="translate(342.39, 261.5)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#e5e5e6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
// const String _svg_qwujuj =
//     '<svg viewBox="351.0 495.0 8.0 16.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 351.0, 511.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
// const String _svg_rz9lza =
//     '<svg viewBox="351.0 544.0 8.0 16.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 351.0, 560.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
// const String _svg_sv2gcw =
//     '<svg viewBox="351.0 593.0 8.0 16.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 351.0, 609.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
// const String _svg_u2rlt1 =
//     '<svg viewBox="17.0 188.0 342.0 48.0" ><path transform="translate(17.0, 188.0)" d="M 7.976676464080811 0 L 334.0233154296875 0 C 338.4287109375 0 342 3.581721782684326 342 8 L 342 40 C 342 44.41827774047852 338.4287109375 48 334.0233154296875 48 L 7.976676464080811 48 C 3.571279525756836 48 0 44.41827774047852 0 40 L 0 8 C 0 3.581721782684326 3.571279525756836 0 7.976676464080811 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qhuzq5 =
    '<svg viewBox="331.0 204.0 11.0 15.8" ><path transform="translate(331.0, 204.0)" d="M 10.23786640167236 2.713183403015137 C 9.266834259033203 1.053786873817444 7.5420823097229 0.03999645635485649 5.624111652374268 0.00125327380374074 C 5.542236804962158 -0.0004177579830866307 5.459830760955811 -0.0004177579830866307 5.37792444229126 0.00125327380374074 C 3.459985017776489 0.03999645635485649 1.735233068466187 1.053786873817444 0.7641696929931641 2.713183403015137 C -0.2283937186002731 4.409342288970947 -0.2555499076843262 6.446762561798096 0.6915134787559509 8.163314819335938 L 4.659111022949219 15.3545389175415 C 4.660892486572266 15.35772609710693 4.662673473358154 15.36091232299805 4.664516925811768 15.36406898498535 C 4.839079856872559 15.66451454162598 5.151799201965332 15.8438720703125 5.501080989837646 15.8438720703125 C 5.85033130645752 15.8438720703125 6.163049697875977 15.66448402404785 6.337581157684326 15.36406898498535 C 6.339424610137939 15.36091232299805 6.341206073760986 15.35772609710693 6.342987537384033 15.3545389175415 L 10.31058502197266 8.163314819335938 C 11.25758647918701 6.446762561798096 11.23042964935303 4.409342288970947 10.23786640167236 2.713183403015137 L 10.23786640167236 2.713183403015137 Z M 5.501018047332764 7.179263114929199 C 4.260360717773438 7.179263114929199 3.251015901565552 6.179769515991211 3.251015901565552 4.951220989227295 C 3.251015901565552 3.7226722240448 4.260360717773438 2.723178386688232 5.501018047332764 2.723178386688232 C 6.74167537689209 2.723178386688232 7.751019954681396 3.7226722240448 7.751019954681396 4.951220989227295 C 7.751019954681396 6.179769515991211 6.741706848144531 7.179263114929199 5.501018047332764 7.179263114929199 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_rsne85 =
//     '<svg viewBox="351.0 642.0 8.0 16.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 351.0, 658.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_3wu8kj =
    '<svg viewBox="16.0 118.0 11.0 15.8" ><path transform="translate(16.0, 118.0)" d="M 10.23786640167236 2.713183403015137 C 9.266834259033203 1.053786873817444 7.5420823097229 0.03999645635485649 5.624111652374268 0.00125327380374074 C 5.542236804962158 -0.0004177579830866307 5.459830760955811 -0.0004177579830866307 5.37792444229126 0.00125327380374074 C 3.459985017776489 0.03999645635485649 1.735233068466187 1.053786873817444 0.7641696929931641 2.713183403015137 C -0.2283937186002731 4.409342288970947 -0.2555499076843262 6.446762561798096 0.6915134787559509 8.163314819335938 L 4.659111022949219 15.3545389175415 C 4.660892486572266 15.35772609710693 4.662673473358154 15.36091232299805 4.664516925811768 15.36406898498535 C 4.839079856872559 15.66451454162598 5.151799201965332 15.8438720703125 5.501080989837646 15.8438720703125 C 5.85033130645752 15.8438720703125 6.163049697875977 15.66448402404785 6.337581157684326 15.36406898498535 C 6.339424610137939 15.36091232299805 6.341206073760986 15.35772609710693 6.342987537384033 15.3545389175415 L 10.31058502197266 8.163314819335938 C 11.25758647918701 6.446762561798096 11.23042964935303 4.409342288970947 10.23786640167236 2.713183403015137 L 10.23786640167236 2.713183403015137 Z M 5.501018047332764 7.179263114929199 C 4.260360717773438 7.179263114929199 3.251015901565552 6.179769515991211 3.251015901565552 4.951220989227295 C 3.251015901565552 3.7226722240448 4.260360717773438 2.723178386688232 5.501018047332764 2.723178386688232 C 6.74167537689209 2.723178386688232 7.751019954681396 3.7226722240448 7.751019954681396 4.951220989227295 C 7.751019954681396 6.179769515991211 6.741706848144531 7.179263114929199 5.501018047332764 7.179263114929199 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
//const String _svg_hafds1 =
//     '<svg viewBox="16.0 172.0 343.0 1.0" ><path transform="translate(16.0, 172.0)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_oaegl4 =
//     '<svg viewBox="16.0 730.0 343.0 48.0" ><path transform="translate(16.0, 730.0)" d="M 8 0 L 335 0 C 337.1217346191406 1.110223024625157e-15 339.1565551757812 0.8428548574447632 340.6568603515625 2.343145847320557 C 342.1571655273438 3.843436717987061 343 5.878268241882324 343 8 L 343 40 C 343 42.12173080444336 342.1571655273438 44.15656280517578 340.6568603515625 45.65685272216797 C 339.1565551757812 47.15714263916016 337.1217346191406 48 335 48 L 8 48 C 5.878268241882324 48 3.843436717987061 47.15714263916016 2.343145847320557 45.65685272216797 C 0.8428548574447632 44.15656280517578 1.165734175856414e-15 42.12173080444336 0 40 L 0 8 C 3.885780586188048e-16 5.878268241882324 0.8428548574447632 3.843436717987061 2.343145847320557 2.343145847320557 C 3.843436717987061 0.8428548574447632 5.878268241882324 1.998401444325282e-15 8 0 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_1r78ot =
//     '<svg viewBox="338.0 115.0 20.0 20.0" ><path transform="translate(338.0, 115.0)" d="M 10 1.413226629259141e-29 C 11.97781276702881 -3.33066907387547e-15 13.91121101379395 0.5864897966384888 15.55570220947266 1.685303926467896 C 17.20019340515137 2.784118175506592 18.48192024230957 4.34590482711792 19.23879623413086 6.173165798187256 C 19.99567222595215 8.00042724609375 20.19370651245117 10.01109313964844 19.80785369873047 11.95090293884277 C 19.42200088500977 13.89071273803711 18.4695930480957 15.67254257202148 17.07106781005859 17.07106781005859 C 15.67254257202148 18.4695930480957 13.89071273803711 19.42200088500977 11.95090293884277 19.80785369873047 C 10.01109313964844 20.19370651245117 8.00042724609375 19.99567222595215 6.173165798187256 19.23879623413086 C 4.34590482711792 18.48192024230957 2.784118175506592 17.20019340515137 1.685303926467896 15.55570220947266 C 0.5864897966384888 13.91121101379395 7.216449660063518e-16 11.97781276702881 0 10 C 0 7.347835063934326 1.053568363189697 4.804296016693115 2.928932189941406 2.928932189941406 C 4.804296016693115 1.053568363189697 7.347835063934326 3.108624468950438e-15 10 1.332267629550188e-15 L 10 1.413226629259141e-29 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_62u3r =
//     '<svg viewBox="338.0 115.0 20.0 20.0" ><path transform="translate(338.0, 115.0)" d="M 10 1.5 C 5.313079833984375 1.5 1.5 5.313079833984375 1.5 10 C 1.5 14.68692016601562 5.313079833984375 18.5 10 18.5 C 14.68692016601562 18.5 18.5 14.68692016601562 18.5 10 C 18.5 5.313079833984375 14.68692016601562 1.5 10 1.5 Z M 10 0 C 15.52285003662109 0 20 4.477149963378906 20 10 C 20 15.52285003662109 15.52285003662109 20 10 20 C 4.477149963378906 20 0 15.52285003662109 0 10 C 0 4.477149963378906 4.477149963378906 0 10 0 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_790jfx =
//     '<svg viewBox="345.0 122.0 6.0 6.0" ><path transform="translate(345.0, 122.0)" d="M 6 3 C 6 4.656854152679443 4.656854152679443 6 3 6 C 1.343145728111267 6 0 4.656854152679443 0 3 C 0 1.343145728111267 1.343145728111267 0 3 0 C 4.656854152679443 0 6 1.343145728111267 6 3 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String dotString =
    '<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10 1.5C5.31308 1.5 1.5 5.31308 1.5 10C1.5 14.6869 5.31308 18.5 10 18.5C14.6869 18.5 18.5 14.6869 18.5 10C18.5 5.31308 14.6869 1.5 10 1.5ZM10 0C15.5229 0 20 4.47715 20 10C20 15.5229 15.5229 20 10 20C4.47715 20 0 15.5229 0 10C0 4.47715 4.47715 0 10 0Z" fill="#FD7B38"/><path d="M10 13C11.6569 13 13 11.6569 13 10C13 8.34315 11.6569 7 10 7C8.34315 7 7 8.34315 7 10C7 11.6569 8.34315 13 10 13Z" fill="#FD7B38"/></svg>';
