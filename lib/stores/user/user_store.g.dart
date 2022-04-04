// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$registerLoadingComputed;

  @override
  bool get registerLoading =>
      (_$registerLoadingComputed ??= Computed<bool>(() => super.registerLoading,
              name: '_UserStore.registerLoading'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_UserStore.loading'))
      .value;
  Computed<bool>? _$stringResponseloadingComputed;

  @override
  bool get stringResponseloading => (_$stringResponseloadingComputed ??=
          Computed<bool>(() => super.stringResponseloading,
              name: '_UserStore.stringResponseloading'))
      .value;
  Computed<UserRepository>? _$getRepoComputed;

  @override
  UserRepository get getRepo =>
      (_$getRepoComputed ??= Computed<UserRepository>(() => super.getRepo,
              name: '_UserStore.getRepo'))
          .value;

  final _$isLoggedInAtom = Atom(name: '_UserStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$isSendOfferAtom = Atom(name: '_UserStore.isSendOffer');

  @override
  bool get isSendOffer {
    _$isSendOfferAtom.reportRead();
    return super.isSendOffer;
  }

  @override
  set isSendOffer(bool value) {
    _$isSendOfferAtom.reportWrite(value, super.isSendOffer, () {
      super.isSendOffer = value;
    });
  }

  final _$modeAtom = Atom(name: '_UserStore.mode');

  @override
  EnvMode get mode {
    _$modeAtom.reportRead();
    return super.mode;
  }

  @override
  set mode(EnvMode value) {
    _$modeAtom.reportWrite(value, super.mode, () {
      super.mode = value;
    });
  }

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$selectedCountryAtom = Atom(name: '_UserStore.selectedCountry');

  @override
  Country? get selectedCountry {
    _$selectedCountryAtom.reportRead();
    return super.selectedCountry;
  }

  @override
  set selectedCountry(Country? value) {
    _$selectedCountryAtom.reportWrite(value, super.selectedCountry, () {
      super.selectedCountry = value;
    });
  }

  final _$iceServerAtom = Atom(name: '_UserStore.iceServer');

  @override
  List<dynamic>? get iceServer {
    _$iceServerAtom.reportRead();
    return super.iceServer;
  }

  @override
  set iceServer(List<dynamic>? value) {
    _$iceServerAtom.reportWrite(value, super.iceServer, () {
      super.iceServer = value;
    });
  }

  final _$countryListAtom = Atom(name: '_UserStore.countryList');

  @override
  CountryList? get countryList {
    _$countryListAtom.reportRead();
    return super.countryList;
  }

  @override
  set countryList(CountryList? value) {
    _$countryListAtom.reportWrite(value, super.countryList, () {
      super.countryList = value;
    });
  }

  final _$contientListAtom = Atom(name: '_UserStore.contientList');

  @override
  ContientList? get contientList {
    _$contientListAtom.reportRead();
    return super.contientList;
  }

  @override
  set contientList(ContientList? value) {
    _$contientListAtom.reportWrite(value, super.contientList, () {
      super.contientList = value;
    });
  }

  final _$continentsAtom = Atom(name: '_UserStore.continents');

  @override
  ObservableList<Contient>? get continents {
    _$continentsAtom.reportRead();
    return super.continents;
  }

  @override
  set continents(ObservableList<Contient>? value) {
    _$continentsAtom.reportWrite(value, super.continents, () {
      super.continents = value;
    });
  }

  final _$successAtom = Atom(name: '_UserStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$loginLoadingAtom = Atom(name: '_UserStore.loginLoading');

  @override
  bool get loginLoading {
    _$loginLoadingAtom.reportRead();
    return super.loginLoading;
  }

  @override
  set loginLoading(bool value) {
    _$loginLoadingAtom.reportWrite(value, super.loginLoading, () {
      super.loginLoading = value;
    });
  }

  final _$stringFutureAtom = Atom(name: '_UserStore.stringFuture');

  @override
  ObservableFuture<Map<String, dynamic>?> get stringFuture {
    _$stringFutureAtom.reportRead();
    return super.stringFuture;
  }

  @override
  set stringFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$stringFutureAtom.reportWrite(value, super.stringFuture, () {
      super.stringFuture = value;
    });
  }

  final _$responseFutureAtom = Atom(name: '_UserStore.responseFuture');

  @override
  ObservableFuture<dynamic> get responseFuture {
    _$responseFutureAtom.reportRead();
    return super.responseFuture;
  }

  @override
  set responseFuture(ObservableFuture<dynamic> value) {
    _$responseFutureAtom.reportWrite(value, super.responseFuture, () {
      super.responseFuture = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(Map<String, dynamic> data) {
    return _$loginAsyncAction.run(() => super.login(data));
  }

  final _$refreshTokenAsyncAction = AsyncAction('_UserStore.refreshToken');

  @override
  Future<dynamic> refreshToken(Map<String, dynamic> data) {
    return _$refreshTokenAsyncAction.run(() => super.refreshToken(data));
  }

  final _$logoutAsyncAction = AsyncAction('_UserStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getIceServerAsyncAction = AsyncAction('_UserStore.getIceServer');

  @override
  Future<dynamic> getIceServer() {
    return _$getIceServerAsyncAction.run(() => super.getIceServer());
  }

  final _$refreshClientCredentialAsyncAction =
      AsyncAction('_UserStore.refreshClientCredential');

  @override
  Future<dynamic> refreshClientCredential() {
    return _$refreshClientCredentialAsyncAction
        .run(() => super.refreshClientCredential());
  }

  final _$setEnvModeAsyncAction = AsyncAction('_UserStore.setEnvMode');

  @override
  Future<dynamic> setEnvMode() {
    return _$setEnvModeAsyncAction.run(() => super.setEnvMode());
  }

  final _$phoneRegisterAsyncAction = AsyncAction('_UserStore.phoneRegister');

  @override
  Future<dynamic> phoneRegister(Map<String, dynamic> data) {
    return _$phoneRegisterAsyncAction.run(() => super.phoneRegister(data));
  }

  final _$confirmCodeAsyncAction = AsyncAction('_UserStore.confirmCode');

  @override
  Future<dynamic> confirmCode(Map<String, dynamic> data) {
    return _$confirmCodeAsyncAction.run(() => super.confirmCode(data));
  }

  final _$changeFullNameAsyncAction = AsyncAction('_UserStore.changeFullName');

  @override
  Future<dynamic> changeFullName(Map<String, dynamic> data) {
    return _$changeFullNameAsyncAction.run(() => super.changeFullName(data));
  }

  final _$changeAvatarAsyncAction = AsyncAction('_UserStore.changeAvatar');

  @override
  Future<dynamic> changeAvatar(File file) {
    return _$changeAvatarAsyncAction.run(() => super.changeAvatar(file));
  }

  final _$getProfileUserAsyncAction = AsyncAction('_UserStore.getProfileUser');

  @override
  Future<dynamic> getProfileUser() {
    return _$getProfileUserAsyncAction.run(() => super.getProfileUser());
  }

  final _$changePasswordAsyncAction = AsyncAction('_UserStore.changePassword');

  @override
  Future<dynamic> changePassword(Map<String, dynamic> data) {
    return _$changePasswordAsyncAction.run(() => super.changePassword(data));
  }

  final _$createRecoverPasswordAsyncAction =
      AsyncAction('_UserStore.createRecoverPassword');

  @override
  Future<dynamic> createRecoverPassword(Map<String, dynamic> data) {
    return _$createRecoverPasswordAsyncAction
        .run(() => super.createRecoverPassword(data));
  }

  final _$confirmOTPRecoverPasswordAsyncAction =
      AsyncAction('_UserStore.confirmOTPRecoverPassword');

  @override
  Future<dynamic> confirmOTPRecoverPassword(Map<String, dynamic> data) {
    return _$confirmOTPRecoverPasswordAsyncAction
        .run(() => super.confirmOTPRecoverPassword(data));
  }

  final _$resendOTPRecoverPasswordAsyncAction =
      AsyncAction('_UserStore.resendOTPRecoverPassword');

  @override
  Future<dynamic> resendOTPRecoverPassword(Map<String, dynamic> data) {
    return _$resendOTPRecoverPasswordAsyncAction
        .run(() => super.resendOTPRecoverPassword(data));
  }

  final _$recoverChangePassAsyncAction =
      AsyncAction('_UserStore.recoverChangePass');

  @override
  Future<dynamic> recoverChangePass(Map<String, dynamic> data) {
    return _$recoverChangePassAsyncAction
        .run(() => super.recoverChangePass(data));
  }

  final _$getCountryAsyncAction = AsyncAction('_UserStore.getCountry');

  @override
  Future<dynamic> getCountry(Map<String, dynamic> params) {
    return _$getCountryAsyncAction.run(() => super.getCountry(params));
  }

  final _$searchCountryAsyncAction = AsyncAction('_UserStore.searchCountry');

  @override
  Future<dynamic> searchCountry(Map<String, dynamic> params) {
    return _$searchCountryAsyncAction.run(() => super.searchCountry(params));
  }

  final _$getContinentsAsyncAction = AsyncAction('_UserStore.getContinents');

  @override
  Future<dynamic> getContinents() {
    return _$getContinentsAsyncAction.run(() => super.getContinents());
  }

  final _$getDetailCountryByCodeAsyncAction =
      AsyncAction('_UserStore.getDetailCountryByCode');

  @override
  Future<dynamic> getDetailCountryByCode(String code) {
    return _$getDetailCountryByCodeAsyncAction
        .run(() => super.getDetailCountryByCode(code));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setIsLogin(dynamic isLogin) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setIsLogin');
    try {
      return super.setIsLogin(isLogin);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsSendOffer(dynamic isSend) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setIsSendOffer');
    try {
      return super.setIsSendOffer(isSend);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectedCountry(Country country) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.onSelectedCountry');
    try {
      return super.onSelectedCountry(country);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.reset');
    try {
      return super.reset();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isSendOffer: ${isSendOffer},
mode: ${mode},
user: ${user},
selectedCountry: ${selectedCountry},
iceServer: ${iceServer},
countryList: ${countryList},
contientList: ${contientList},
continents: ${continents},
success: ${success},
loginLoading: ${loginLoading},
stringFuture: ${stringFuture},
responseFuture: ${responseFuture},
registerLoading: ${registerLoading},
loading: ${loading},
stringResponseloading: ${stringResponseloading},
getRepo: ${getRepo}
    ''';
  }
}
