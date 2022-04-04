import 'dart:async';

import 'package:aiviewcloud/data/repository.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/data/user_repository.dart';
import 'package:aiviewcloud/di/components/injection.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'global_store.g.dart';

@Injectable()
class GlobalStore = _GlobalStore with _$GlobalStore;

abstract class _GlobalStore with Store {
  final String TAG = "_GlobalStore";

  // repository instance
  final Repository _repository;
  final UserStore _userStore = UserStore(getIt<UserRepository>());
  // store for handling errors
  late Timer _timer;
  // store variables:-----------------------------------------------------------
  @observable
  String selectedDrawer = "";

  @observable
  int countdown = 300;

  // getters:-------------------------------------------------------------------

  // constructor:---------------------------------------------------------------
  _GlobalStore(Repository repository) : this._repository = repository {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  void setRoute(String route) {
    this.selectedDrawer = route;
  }

  @action
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (countdown == 0) {
          String? username =
              await FlutterKeychain.get(key: Preferences.username);
          String? password =
              await FlutterKeychain.get(key: Preferences.password);
          _userStore.refreshToken({
            "UserName": username,
            "Password": password,
          });
          countdown = 300;
        } else {
          countdown--;
        }
      },
    );
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    if (_userStore.isLoggedIn) {
      startTimer();
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
