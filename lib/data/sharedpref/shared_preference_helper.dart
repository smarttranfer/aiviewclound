import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

@Singleton()
class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> savePeer(String peer) async {
    return _sharedPreference.setString(Preferences.peer, peer);
  }

  Future<String?> get getPeer async {
    return _sharedPreference.getString(Preferences.peer);
  }

  Future<String?> get getUserInfo async {
    return _sharedPreference.getString(Preferences.userInfo);
  }

  Future<bool> saveUserInfo(String userInfo) async {
    return _sharedPreference.setString(Preferences.userInfo, userInfo);
  }

  Future<bool> saveLoginName(String login) async {
    return _sharedPreference.setString(Preferences.username, login);
  }

  Future<String?> get getLoginName async {
    return _sharedPreference.getString(Preferences.username);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  Future<void> clearAll() {
    return _sharedPreference.clear();
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
