import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/constants/strings.dart';
import 'package:aiviewcloud/models/country/country.dart';
import 'package:aiviewcloud/models/country/country_list.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/device/debound.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/button_widget.dart';
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

class BottomSheetFindCountry extends StatefulWidget {
  BottomSheetFindCountry({Key? key}) : super(key: key);

  @override
  _BottomSheetFindCountryState createState() => _BottomSheetFindCountryState();
}

class _BottomSheetFindCountryState extends State<BottomSheetFindCountry> {
  TextEditingController _searcController = TextEditingController();

  late int expandIndex = -1;
  late int lastIndex = -1;
  late String selectedCountryCode = "";
  Country? selectedCountry;
  late CountryList countryArr = new CountryList(coutries: []);
  final _debouncer = Debouncer(milliseconds: 500);
  bool showSearch = false;
  late UserStore _store;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
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
      if (_store.user != null) {
        setState(() {
          selectedCountryCode = _store.user!.country!.code!;
          selectedCountry = new Country(
              code: _store.user!.country!.code,
              name: _store.user!.country!.name,
              fullName: _store.user!.country!.fullName);
        });
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
        selectedCountryCode = first.isoCountryCode!;
        selectedCountry = new Country(
            code: first.isoCountryCode,
            name: first.country,
            fullName: first.country);
      });
    }
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    print(serviceEnabled);
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
    print(_store.user!.countriesCode);

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
                  child: SvgPicture.string(
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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                ),
              ),
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
                                                Text(
                                              selectedCountry?.name ??
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'located_country'),
                                              style: TextStyle(
                                                fontFamily: 'SF Pro Display',
                                                fontSize: 17,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4.h),
                                            child: Text(
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
                                  child: SvgPicture.string(
                                    _svg_qhuzq5,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
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
                          SMEButton(
                              onPress: () {
                                try {
                                  _store.onSelectedCountry(selectedCountry!);
                                  Navigator.pop(context);
                                } catch (error) {
                                  _showErrorMessage(AppLocalizations.of(context)
                                      .translate('not_select_country'));
                                }
                              },
                              title: AppLocalizations.of(context)
                                  .translate('done'))
                        ],
                      ))),
            ]));
  }
}

const String_svg_o2muup =
    '<svg viewBox="331.4 19.0 22.0 11.3" ><path transform="translate(331.45, 19.0)" d="M 2.66700005531311 0 L 19.33300018310547 0 C 20.80594444274902 0 22 1.194056630134583 22 2.66700005531311 L 22 8.666000366210938 C 22 10.13894367218018 20.80594444274902 11.33300018310547 19.33300018310547 11.33300018310547 L 2.66700005531311 11.33300018310547 C 1.194056630134583 11.33300018310547 0 10.13894367218018 0 8.666000366210938 L 0 2.66700005531311 C 0 1.194056630134583 1.194056630134583 0 2.66700005531311 0 Z" fill="#ffffff" fill-opacity="0.35" stroke="none" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qhuzq5 =
    '<svg viewBox="331.0 204.0 11.0 15.8" ><path transform="translate(331.0, 204.0)" d="M 10.23786640167236 2.713183403015137 C 9.266834259033203 1.053786873817444 7.5420823097229 0.03999645635485649 5.624111652374268 0.00125327380374074 C 5.542236804962158 -0.0004177579830866307 5.459830760955811 -0.0004177579830866307 5.37792444229126 0.00125327380374074 C 3.459985017776489 0.03999645635485649 1.735233068466187 1.053786873817444 0.7641696929931641 2.713183403015137 C -0.2283937186002731 4.409342288970947 -0.2555499076843262 6.446762561798096 0.6915134787559509 8.163314819335938 L 4.659111022949219 15.3545389175415 C 4.660892486572266 15.35772609710693 4.662673473358154 15.36091232299805 4.664516925811768 15.36406898498535 C 4.839079856872559 15.66451454162598 5.151799201965332 15.8438720703125 5.501080989837646 15.8438720703125 C 5.85033130645752 15.8438720703125 6.163049697875977 15.66448402404785 6.337581157684326 15.36406898498535 C 6.339424610137939 15.36091232299805 6.341206073760986 15.35772609710693 6.342987537384033 15.3545389175415 L 10.31058502197266 8.163314819335938 C 11.25758647918701 6.446762561798096 11.23042964935303 4.409342288970947 10.23786640167236 2.713183403015137 L 10.23786640167236 2.713183403015137 Z M 5.501018047332764 7.179263114929199 C 4.260360717773438 7.179263114929199 3.251015901565552 6.179769515991211 3.251015901565552 4.951220989227295 C 3.251015901565552 3.7226722240448 4.260360717773438 2.723178386688232 5.501018047332764 2.723178386688232 C 6.74167537689209 2.723178386688232 7.751019954681396 3.7226722240448 7.751019954681396 4.951220989227295 C 7.751019954681396 6.179769515991211 6.741706848144531 7.179263114929199 5.501018047332764 7.179263114929199 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3wu8kj =
    '<svg viewBox="16.0 118.0 11.0 15.8" ><path transform="translate(16.0, 118.0)" d="M 10.23786640167236 2.713183403015137 C 9.266834259033203 1.053786873817444 7.5420823097229 0.03999645635485649 5.624111652374268 0.00125327380374074 C 5.542236804962158 -0.0004177579830866307 5.459830760955811 -0.0004177579830866307 5.37792444229126 0.00125327380374074 C 3.459985017776489 0.03999645635485649 1.735233068466187 1.053786873817444 0.7641696929931641 2.713183403015137 C -0.2283937186002731 4.409342288970947 -0.2555499076843262 6.446762561798096 0.6915134787559509 8.163314819335938 L 4.659111022949219 15.3545389175415 C 4.660892486572266 15.35772609710693 4.662673473358154 15.36091232299805 4.664516925811768 15.36406898498535 C 4.839079856872559 15.66451454162598 5.151799201965332 15.8438720703125 5.501080989837646 15.8438720703125 C 5.85033130645752 15.8438720703125 6.163049697875977 15.66448402404785 6.337581157684326 15.36406898498535 C 6.339424610137939 15.36091232299805 6.341206073760986 15.35772609710693 6.342987537384033 15.3545389175415 L 10.31058502197266 8.163314819335938 C 11.25758647918701 6.446762561798096 11.23042964935303 4.409342288970947 10.23786640167236 2.713183403015137 L 10.23786640167236 2.713183403015137 Z M 5.501018047332764 7.179263114929199 C 4.260360717773438 7.179263114929199 3.251015901565552 6.179769515991211 3.251015901565552 4.951220989227295 C 3.251015901565552 3.7226722240448 4.260360717773438 2.723178386688232 5.501018047332764 2.723178386688232 C 6.74167537689209 2.723178386688232 7.751019954681396 3.7226722240448 7.751019954681396 4.951220989227295 C 7.751019954681396 6.179769515991211 6.741706848144531 7.179263114929199 5.501018047332764 7.179263114929199 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String dotString =
    '<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10 1.5C5.31308 1.5 1.5 5.31308 1.5 10C1.5 14.6869 5.31308 18.5 10 18.5C14.6869 18.5 18.5 14.6869 18.5 10C18.5 5.31308 14.6869 1.5 10 1.5ZM10 0C15.5229 0 20 4.47715 20 10C20 15.5229 15.5229 20 10 20C4.47715 20 0 15.5229 0 10C0 4.47715 4.47715 0 10 0Z" fill="#FD7B38"/><path d="M10 13C11.6569 13 13 11.6569 13 10C13 8.34315 11.6569 7 10 7C8.34315 7 7 8.34315 7 10C7 11.6569 8.34315 13 10 13Z" fill="#FD7B38"/></svg>';
