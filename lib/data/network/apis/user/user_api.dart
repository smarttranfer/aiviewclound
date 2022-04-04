import 'dart:async';
import 'dart:io';

import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/network/dio_client.dart';
import 'package:aiviewcloud/data/network/rest_client.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/models/country/continent_list.dart';
import 'package:aiviewcloud/models/country/country.dart';
import 'package:aiviewcloud/models/country/country_list.dart';
import 'package:aiviewcloud/models/login/login.dart';
import 'package:aiviewcloud/models/peer/peer.dart' as Peer;
import 'package:aiviewcloud/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
class UserApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UserApi(this._dioClient, this._restClient);

  /// Returns list of User in response
  Future<User> getUserInfo(String address, String body) async {
    try {
      final res = await _dioClient.post(
        address + '/api/Device',
        data: body,
      );
      return User.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<User> emailRegister(String email, String password) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserRegister/RegisterUser',
        data: {
          "UserRegisterHistory": {
            "Email": email,
            "Mobile": "",
            "Password": password,
            "ConfirmPassword": password,
            "CountriesCode": "VI",
            "UserIDCreate": 1
          }
        },
      );
      return User.fromJson(res['Object']);
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> confirmCode(Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserRegister/ConfirmOTPCode',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> createRecoverPassword(
      Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserRegister/RecoverPassword',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> confirmOTPRecoverPassword(
      Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserRegister/ConfirmOTPRecoverPassword',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> resendOTPRecoverPassword(
      Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserRegister/ResendOTPRecoverPassword',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> changeFullName(Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserDetails/ChangeFullName',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> changeAvatar(File file) async {
    try {
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: file.path),
      });
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserDetails/ChangeAvatar',
        data: formData,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getProfileUser() async {
    try {
      final res = await _dioClient
          .get(Endpoints.getUrlEndPoint + 'AppUserDetails/GetUserInfo');
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserDetails/ChangePassword',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> recoverChangePass(
      Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(
        Endpoints.getUrlEndPoint + 'AppUserRegister/RecoverChangePass',
        data: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> phoneRegister(Map<String, dynamic> data) async {
    final res = await _dioClient.post(
      Endpoints.getUrlEndPoint + 'AppUserRegister/RegisterUser',
      data: data,
    );
    try {
      if (res["isOk"]) {
        return res['Object'];
      } else {
        throw res['Object'];
      }
    } catch (e) {
      print("e $e");
      throw res['Object'];
    }
  }

  Future<CountryList> getCountryList(Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getUrlEndPoint +
              'AppRegion/GetListCountriesByContinentsCode',
          queryParameters: params);
      return CountryList.fromJson(res['Object']);
    } catch (e) {
      throw e;
    }
  }

  Future<CountryList> seachCountry(Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getUrlEndPoint + 'AppRegion/GetOneCountriesByName',
          queryParameters: params);
      return CountryList.fromJson(res['Object']);
    } catch (e) {
      throw e;
    }
  }

  Future<ContientList> getContinentList() async {
    try {
      final res = await _dioClient.get(
        Endpoints.getUrlEndPoint + 'AppRegion/GetListContinents',
      );
      return ContientList.fromJson(res['Object']);
    } catch (e) {
      throw e;
    }
  }

  Future<Country> getDetailCountryByCode(String code) async {
    try {
      final res = await _dioClient.get(
        Endpoints.getUrlEndPoint + 'AppRegion/GetOneCountriesByCode',
        queryParameters: {'Code': code},
      );
      return Country.fromJson(res['Object']);
    } catch (e) {
      throw e;
    }
  }

  /// sample api call with default rest client
  Future<LoginObject> login(Map<String, dynamic> data) async {
    final res = await _dioClient
        .post(Endpoints.getUrlEndPoint + 'AppUserRegister/Login', data: data);
    try {
      if (res['Object']['User'] != null) {
        var resp = LoginObject.fromJson(res['Object']);
        if (resp.userToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(Preferences.auth_token, resp.userToken!.token!);
          _dioClient.client.options.headers['Authorization'] =
              resp.userToken?.token;
        }

        return resp;
      }
      return res;
    } catch (e) {
      print('login error from api $e');
      throw res;
    }
  }

  Future<List<dynamic>> getIceServer(String data) async {
    return await _dioClient.get(
        Endpoints.getP2PUrlEndPoint + 'server/resource/ices',
        options: Options(headers: {'Authorization': data}));
  }

  Future<Peer.Client> refreshClientCredential(Map<String, dynamic> data) async {
    final res = await _dioClient.get(
        Endpoints.getUrlEndPoint + 'AppUserDetails/GetClientCredential',
        queryParameters: data);
    try {
      Peer.Client resp = Peer.Client.fromJson(res['Object']['data']);
      return resp;
    } catch (e) {
      print('login error from ice server $e');
      throw res;
    }
  }
}
