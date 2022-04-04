// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DeviceStore on _DeviceStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_DeviceStore.loading'))
      .value;

  final _$fetchDevicesFutureAtom =
      Atom(name: '_DeviceStore.fetchDevicesFuture');

  @override
  ObservableFuture<LanCamera?> get fetchDevicesFuture {
    _$fetchDevicesFutureAtom.reportRead();
    return super.fetchDevicesFuture;
  }

  @override
  set fetchDevicesFuture(ObservableFuture<LanCamera?> value) {
    _$fetchDevicesFutureAtom.reportWrite(value, super.fetchDevicesFuture, () {
      super.fetchDevicesFuture = value;
    });
  }

  final _$cameraAtom = Atom(name: '_DeviceStore.camera');

  @override
  LanCamera? get camera {
    _$cameraAtom.reportRead();
    return super.camera;
  }

  @override
  set camera(LanCamera? value) {
    _$cameraAtom.reportWrite(value, super.camera, () {
      super.camera = value;
    });
  }

  final _$successAtom = Atom(name: '_DeviceStore.success');

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

  final _$getCameraAsyncAction = AsyncAction('_DeviceStore.getCamera');

  @override
  Future<LanCamera> getCamera(String? address, String body) {
    return _$getCameraAsyncAction.run(() => super.getCamera(address, body));
  }

  final _$sendCommandAsyncAction = AsyncAction('_DeviceStore.sendCommand');

  @override
  Future<LanCamera> sendCommand(String? address, String body) {
    return _$sendCommandAsyncAction.run(() => super.sendCommand(address, body));
  }

  final _$addCameraAsyncAction = AsyncAction('_DeviceStore.addCamera');

  @override
  Future<dynamic> addCamera(String? address, String body) {
    return _$addCameraAsyncAction.run(() => super.addCamera(address, body));
  }

  @override
  String toString() {
    return '''
fetchDevicesFuture: ${fetchDevicesFuture},
camera: ${camera},
success: ${success},
loading: ${loading}
    ''';
  }
}
