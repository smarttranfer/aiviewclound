import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/data/user_repository.dart';
import 'package:aiviewcloud/models/country/continent.dart';
import 'package:aiviewcloud/models/country/continent_list.dart';
import 'package:aiviewcloud/models/country/country.dart';
import 'package:aiviewcloud/models/country/country_list.dart';
import 'package:aiviewcloud/models/login/login.dart';
import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:aiviewcloud/models/user/user.dart';
import 'package:aiviewcloud/models/user_token/user_token.dart';
import 'package:aiviewcloud/stores/error/error_store.dart';
import 'package:aiviewcloud/utils/device/connect_mqtt.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import '../form/form_store.dart';

part 'user_store.g.dart';

@Injectable()
class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final UserRepository _userRepository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();
  MqttClientService mqttClientServices = MqttClientService();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  @observable
  bool isLoggedIn = false;

  @observable
  bool isSendOffer = false;

  @observable
  EnvMode mode = EnvMode.qa;

  @observable
  User? user;

  Peer? peer;

  UserToken? userToken;

  @observable
  Country? selectedCountry;

  @observable
  List<dynamic>? iceServer;

  @observable
  CountryList? countryList = CountryList(coutries: []);

  @observable
  ContientList? contientList;

  @observable
  ObservableList<Contient>? continents;

  // constructor:---------------------------------------------------------------
  _UserStore(UserRepository userRepository)
      : this._userRepository = userRepository {
    // setting up disposers
    _setupDisposers();
    print('123123');
    _userRepository.isLoggedIn.then((value) async {
      print('456456');
      if (value != null) {
        Map<String, dynamic> user = json.decode(value.trim());
        this.user = User.fromJson(user);
        this.setIsLogin(true);

        String? peerString = await _userRepository.getPeer;

        if (peerString != null) {
          Map<String, dynamic> peer = json.decode(peerString.trim());
          this.peer = Peer.fromJson(peer);
        }
        if (this.user != null && this.peer != null) {
          await this.getIceServer();
        }
        String? authToken = await _userRepository.authToken;
        if (authToken != null) {
          Map<String, dynamic> userToken = json.decode(authToken.trim());
          this.userToken = UserToken.fromJson(userToken);
        }
      } else {
        this.user = null;
        this.isLoggedIn = false;
      }
    });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  void initMode() async {
    Endpoints.mode = EnvMode.production;
    this.mode = EnvMode.production;
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<LoginObject?> emptyLoginResponse =
      ObservableFuture.value(null);

  static ObservableFuture<User?> emplyRegisterRespone =
      ObservableFuture.value(null);

  static ObservableFuture<Map<String, dynamic>?> emptyRespone =
      ObservableFuture.value(null);

  static ObservableFuture response = ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  bool loginLoading = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> stringFuture = emptyRespone;

  @observable
  ObservableFuture responseFuture = response;

  @computed
  bool get registerLoading => stringFuture.status == FutureStatus.pending;

  @computed
  bool get loading => responseFuture.status == FutureStatus.pending;

  @computed
  bool get stringResponseloading => stringFuture.status == FutureStatus.pending;

  @computed
  UserRepository get getRepo => _userRepository;

  // actions:-------------------------------------------------------------------
  @action
  Future login(Map<String, dynamic> data) async {
    try {
      this.loginLoading = true;
      final resp = await _userRepository.login(data);
      this.loginLoading = false;
      await FlutterKeychain.put(
          key: Preferences.username, value: data['UserName']);
      await FlutterKeychain.put(
          key: Preferences.password, value: data['Password']);

      this.user = resp.user;
      this.peer = resp.peer;
      this.userToken = resp.userToken;
      mqttClientServices.init(this.peer!);

      _userRepository.saveIsLoggedIn(json.encode(resp.user).toString());
      _userRepository.savePeer(json.encode(resp.peer).toString());
      _userRepository.saveToken(json.encode(resp.userToken).toString());
      this.isLoggedIn = true;
      this.success = true;
      if (this.user != null && this.peer != null) {
        await this.getIceServer();
      }
    } catch (e) {
      print(e);
      this.loginLoading = false;
      this.isLoggedIn = false;
      this.success = false;

      throw e;
    }
  }

  @action
  Future refreshToken(Map<String, dynamic> data) async {
    try {
      final resp = await _userRepository.login(data);
      await FlutterKeychain.put(
          key: Preferences.username, value: data['UserName']);
      await FlutterKeychain.put(
          key: Preferences.password, value: data['Password']);

      this.user = resp.user;
      this.peer = resp.peer;
      this.userToken = resp.userToken;
      _userRepository.saveIsLoggedIn(json.encode(resp.user).toString());
      _userRepository.savePeer(json.encode(resp.peer).toString());
      _userRepository.saveToken(json.encode(resp.userToken).toString());
      this.isLoggedIn = true;
      this.success = true;
      if (this.user != null && this.peer != null) {
        await this.getIceServer();
      }
    } catch (e) {
      print(e);
      this.loginLoading = false;
      this.isLoggedIn = false;
      this.success = false;

      throw e;
    }
  }

  @action
  Future logout() async {
    try {
      // _userRepository.clearStore();
      _userRepository.saveIsLoggedIn("");
      _userRepository.savePeer("");
      _userRepository.saveToken("");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await FlutterKeychain.clear();
      prefs.setString(Preferences.username, this.user?.userName ?? '');
      this.user = null;
      this.userToken = null;
      this.peer = null;
      this.isLoggedIn = false;
    } catch (e) {
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    }
  }

  @action
  Future getIceServer() async {
    Timer timer;
    try {
      String username = Endpoints.getClientId;
      String? password = this.peer!.targetAuth!.data!.client!.clientCredential;
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      try {
        List<dynamic> iceServer = await _userRepository.getIceServer(basicAuth);
        this.iceServer = iceServer;
      } on DioError catch (e) {
        if (e.response!.statusCode == 401) {
          await refreshClientCredential();
          // Timer.periodic(new Duration(seconds: 2), (timer) async {
          //   await refreshClientCredential();
          // });
        }
      }
    } catch (e) {
      throw e;
    }
  }

  @action
  Future refreshClientCredential() async {
    try {
      Map<String, dynamic> data = {'clientId': Endpoints.getClientId};
      try {
        Client client = await _userRepository.refreshClientCredential(data);
        this.peer!.targetAuth!.data!.client = client;
        await getIceServer();
      } catch (e) {
        print(e);
      }
    } catch (e) {
      throw e;
    }
  }

  @action
  void setIsLogin(isLogin) {
    this.isLoggedIn = isLogin;
  }

  @action
  Future setEnvMode() async {
    this.mode = this.mode == EnvMode.qa ? EnvMode.production : EnvMode.qa;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('EnvMode', this.mode.toString());
  }

  @action
  void setIsSendOffer(isSend) {
    this.isSendOffer = isSend;
  }

  @action
  Future phoneRegister(Map<String, dynamic> data) async {
    final future = _userRepository.phoneRegister(data);
    stringFuture = ObservableFuture(future);
    return await future.then((user) {
      return user;
    }).catchError((e) {
      this.isLoggedIn = false;
      this.success = false;
      errorStore.errorMessage = e;
      throw e;
    });
  }

  @action
  Future confirmCode(Map<String, dynamic> data) async {
    final future = _userRepository.confirmCode(data);
    stringFuture = ObservableFuture(future);
    await future.then((user) async {
      if (user['isOk']) {
        this.success = true;
      } else {
        this.success = false;
        errorStore.errorMessage = user['Object'];
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future changeFullName(Map<String, dynamic> data) async {
    final future = _userRepository.changeFullName(data);
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      if (user['isOk']) {
        await getProfileUser();
        this.success = true;
        return user;
      } else {
        this.success = false;
        errorStore.errorMessage = user['Object'];
        return user;
      }
    }).catchError((e) {
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future changeAvatar(File file) async {
    final future = _userRepository.changeAvatar(file);
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      if (user['isOk']) {
        await getProfileUser();
        this.success = true;
        return user;
      } else {
        this.success = false;
        errorStore.errorMessage = user['Object'];
        return user;
      }
    }).catchError((e) {
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future getProfileUser() async {
    final future = _userRepository.getProfileUser();
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      print('========user: ${jsonEncode(user)}====');
      if (user['isOk']) {
        this.user = User.fromJson(user['Object']);
        _userRepository.saveIsLoggedIn(json.encode(this.user).toString());
        print('========${this.user?.urlAvatar}====');
        this.success = true;
        return user;
      } else {
        this.success = false;
        errorStore.errorMessage = user['Object'];
        return user;
      }
    }).catchError((e) {
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future changePassword(Map<String, dynamic> data) async {
    final future = _userRepository.changePassword(data);
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      return user;
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future createRecoverPassword(Map<String, dynamic> data) async {
    final future = _userRepository.createRecoverPassword(data);
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      return user;
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future confirmOTPRecoverPassword(Map<String, dynamic> data) async {
    final future = _userRepository.confirmOTPRecoverPassword(data);
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      return user;
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future resendOTPRecoverPassword(Map<String, dynamic> data) async {
    final future = _userRepository.resendOTPRecoverPassword(data);
    stringFuture = ObservableFuture(future);
    return await future.then((user) async {
      return user;
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future recoverChangePass(Map<String, dynamic> data) async {
    final future = _userRepository.recoverChangePass(data);
    stringFuture = ObservableFuture(future);
    await future.then((user) async {
      if (user['isOk']) {
        this.success = true;
      } else {
        this.success = false;
        errorStore.errorMessage = user['Object'];
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future getCountry(Map<String, dynamic> params) async {
    final future = _userRepository.getCountry(params);
    responseFuture = ObservableFuture(future);
    return await future.then((contryList) async {
      this.countryList = contryList;
      return contryList;
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  @action
  Future searchCountry(Map<String, dynamic> params) async {
    final future = _userRepository.searchCountry(params);
    responseFuture = ObservableFuture(future);
    return await future.then((contryList) async {
      this.countryList = contryList;
      return contryList;
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  @action
  Future getContinents() async {
    final future = _userRepository.getContinents();
    responseFuture = ObservableFuture(future);
    await future.then((contryList) async {
      this.continents = contryList.continents;
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  @action
  Future getDetailCountryByCode(String code) async {
    final future = _userRepository.getDetailCountryByCode(code);
    responseFuture = ObservableFuture(future);
    return await future.then((conntry) {
      return conntry;
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  @action
  void onSelectedCountry(Country country) {
    this.selectedCountry = country;
  }

  @action
  void reset() {
    this.success = false;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
