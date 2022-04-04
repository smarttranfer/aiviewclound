import 'dart:async';
import 'dart:io';

import 'package:aiviewcloud/data/network/apis/user/user_api.dart';
import 'package:aiviewcloud/data/sharedpref/shared_preference_helper.dart';
import 'package:aiviewcloud/models/country/continent_list.dart';
import 'package:aiviewcloud/models/country/country.dart';
import 'package:aiviewcloud/models/country/country_list.dart';
import 'package:aiviewcloud/models/login/login.dart';
import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:aiviewcloud/models/user/user.dart';

class UserRepository {
  // api objects
  // api objects
  final UserApi _userApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepository(this._userApi, this._sharedPrefsHelper);

  Future<CountryList> getCountry(Map<String, dynamic> params) async {
    return await _userApi.getCountryList(params).then((country) {
      return country;
    }).catchError((error) => throw error);
  }

  Future<CountryList> searchCountry(Map<String, dynamic> params) async {
    return await _userApi.seachCountry(params).then((country) {
      return country;
    }).catchError((error) => throw error);
  }

  Future<ContientList> getContinents() async {
    return await _userApi.getContinentList().then((country) {
      return country;
    }).catchError((error) => throw error);
  }

  Future<Country> getDetailCountryByCode(String code) async {
    return await _userApi.getDetailCountryByCode(code).then((country) {
      return country;
    }).catchError((error) => throw error);
  }

  Future<User> registerEmail(String email, String password) async {
    return await _userApi.emailRegister(email, password).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> createRecoverPassword(
      Map<String, dynamic> data) async {
    return await _userApi.createRecoverPassword(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> confirmOTPRecoverPassword(
      Map<String, dynamic> data) async {
    return await _userApi.confirmOTPRecoverPassword(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> resendOTPRecoverPassword(
      Map<String, dynamic> data) async {
    return await _userApi.resendOTPRecoverPassword(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    return await _userApi.changePassword(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> changeFullName(Map<String, dynamic> data) async {
    return await _userApi.changeFullName(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> changeAvatar(File file) async {
    return await _userApi.changeAvatar(file).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> getProfileUser() async {
    return await _userApi.getProfileUser().then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> recoverChangePass(
      Map<String, dynamic> data) async {
    return await _userApi.recoverChangePass(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> confirmCode(Map<String, dynamic> data) async {
    return await _userApi.confirmCode(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> phoneRegister(Map<String, dynamic> data) async {
    return await _userApi.phoneRegister(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  // Login:---------------------------------------------------------------------
  Future<LoginObject> login(Map<String, dynamic> data) async {
    return await _userApi.login(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<List<dynamic>> getIceServer(String basicAuth) async {
    return await _userApi.getIceServer(basicAuth).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<Client> refreshClientCredential(Map<String, dynamic> data) async {
    return await _userApi.refreshClientCredential(data).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<void> saveIsLoggedIn(String value) =>
      _sharedPrefsHelper.saveUserInfo(value);

  Future<void> saveToken(String value) =>
      _sharedPrefsHelper.saveAuthToken(value);

  Future<void> savePeer(String value) => _sharedPrefsHelper.savePeer(value);

  Future<String?> get isLoggedIn => _sharedPrefsHelper.getUserInfo;

  Future<String?> get getPeer => _sharedPrefsHelper.getPeer;

  Future<String?> get authToken => _sharedPrefsHelper.authToken;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<void> clearStore() => _sharedPrefsHelper.clearAll();

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
