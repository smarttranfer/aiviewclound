// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlobalStore on _GlobalStore, Store {
  final _$selectedDrawerAtom = Atom(name: '_GlobalStore.selectedDrawer');

  @override
  String get selectedDrawer {
    _$selectedDrawerAtom.reportRead();
    return super.selectedDrawer;
  }

  @override
  set selectedDrawer(String value) {
    _$selectedDrawerAtom.reportWrite(value, super.selectedDrawer, () {
      super.selectedDrawer = value;
    });
  }

  final _$countdownAtom = Atom(name: '_GlobalStore.countdown');

  @override
  int get countdown {
    _$countdownAtom.reportRead();
    return super.countdown;
  }

  @override
  set countdown(int value) {
    _$countdownAtom.reportWrite(value, super.countdown, () {
      super.countdown = value;
    });
  }

  final _$_GlobalStoreActionController = ActionController(name: '_GlobalStore');

  @override
  void setRoute(String route) {
    final _$actionInfo = _$_GlobalStoreActionController.startAction(
        name: '_GlobalStore.setRoute');
    try {
      return super.setRoute(route);
    } finally {
      _$_GlobalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTimer() {
    final _$actionInfo = _$_GlobalStoreActionController.startAction(
        name: '_GlobalStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_GlobalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDrawer: ${selectedDrawer},
countdown: ${countdown}
    ''';
  }
}
