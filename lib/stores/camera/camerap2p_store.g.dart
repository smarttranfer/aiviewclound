// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camerap2p_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CameraP2PStore on _CameraP2PStore, Store {
  Computed<bool>? _$isFilterComputed;

  @override
  bool get isFilter =>
      (_$isFilterComputed ??= Computed<bool>(() => super.isFilter,
              name: '_CameraP2PStore.isFilter'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_CameraP2PStore.loading'))
      .value;
  Computed<bool>? _$stringResponseloadingComputed;

  @override
  bool get stringResponseloading => (_$stringResponseloadingComputed ??=
          Computed<bool>(() => super.stringResponseloading,
              name: '_CameraP2PStore.stringResponseloading'))
      .value;

  final _$regionListAtom = Atom(name: '_CameraP2PStore.regionList');

  @override
  ObservableList<Region> get regionList {
    _$regionListAtom.reportRead();
    return super.regionList;
  }

  @override
  set regionList(ObservableList<Region> value) {
    _$regionListAtom.reportWrite(value, super.regionList, () {
      super.regionList = value;
    });
  }

  final _$cameraP2PListAtom = Atom(name: '_CameraP2PStore.cameraP2PList');

  @override
  ObservableList<CameraP2P> get cameraP2PList {
    _$cameraP2PListAtom.reportRead();
    return super.cameraP2PList;
  }

  @override
  set cameraP2PList(ObservableList<CameraP2P> value) {
    _$cameraP2PListAtom.reportWrite(value, super.cameraP2PList, () {
      super.cameraP2PList = value;
    });
  }

  final _$selectedCameraAtom = Atom(name: '_CameraP2PStore.selectedCamera');

  @override
  ObservableList<CameraP2P?> get selectedCamera {
    _$selectedCameraAtom.reportRead();
    return super.selectedCamera;
  }

  @override
  set selectedCamera(ObservableList<CameraP2P?> value) {
    _$selectedCameraAtom.reportWrite(value, super.selectedCamera, () {
      super.selectedCamera = value;
    });
  }

  final _$camOnViewAtom = Atom(name: '_CameraP2PStore.camOnView');

  @override
  ObservableList<CameraP2P?> get camOnView {
    _$camOnViewAtom.reportRead();
    return super.camOnView;
  }

  @override
  set camOnView(ObservableList<CameraP2P?> value) {
    _$camOnViewAtom.reportWrite(value, super.camOnView, () {
      super.camOnView = value;
    });
  }

  final _$selectFromDeviceManagementAtom =
      Atom(name: '_CameraP2PStore.selectFromDeviceManagement');

  @override
  CameraP2P? get selectFromDeviceManagement {
    _$selectFromDeviceManagementAtom.reportRead();
    return super.selectFromDeviceManagement;
  }

  @override
  set selectFromDeviceManagement(CameraP2P? value) {
    _$selectFromDeviceManagementAtom
        .reportWrite(value, super.selectFromDeviceManagement, () {
      super.selectFromDeviceManagement = value;
    });
  }

  final _$countAtom = Atom(name: '_CameraP2PStore.count');

  @override
  int? get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int? value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  final _$isOpenPUAtom = Atom(name: '_CameraP2PStore.isOpenPU');

  @override
  bool get isOpenPU {
    _$isOpenPUAtom.reportRead();
    return super.isOpenPU;
  }

  @override
  set isOpenPU(bool value) {
    _$isOpenPUAtom.reportWrite(value, super.isOpenPU, () {
      super.isOpenPU = value;
    });
  }

  final _$successAtom = Atom(name: '_CameraP2PStore.success');

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

  final _$selectedFilterItemsAtom =
      Atom(name: '_CameraP2PStore.selectedFilterItems');

  @override
  ObservableList<Region> get selectedFilterItems {
    _$selectedFilterItemsAtom.reportRead();
    return super.selectedFilterItems;
  }

  @override
  set selectedFilterItems(ObservableList<Region> value) {
    _$selectedFilterItemsAtom.reportWrite(value, super.selectedFilterItems, () {
      super.selectedFilterItems = value;
    });
  }

  final _$currentPageAtom = Atom(name: '_CameraP2PStore.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$currentViewPageAtom = Atom(name: '_CameraP2PStore.currentViewPage');

  @override
  int get currentViewPage {
    _$currentViewPageAtom.reportRead();
    return super.currentViewPage;
  }

  @override
  set currentViewPage(int value) {
    _$currentViewPageAtom.reportWrite(value, super.currentViewPage, () {
      super.currentViewPage = value;
    });
  }

  final _$pageSizeAtom = Atom(name: '_CameraP2PStore.pageSize');

  @override
  int get pageSize {
    _$pageSizeAtom.reportRead();
    return super.pageSize;
  }

  @override
  set pageSize(int value) {
    _$pageSizeAtom.reportWrite(value, super.pageSize, () {
      super.pageSize = value;
    });
  }

  final _$selectedIndexAtom = Atom(name: '_CameraP2PStore.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$stringPageNumberAtom = Atom(name: '_CameraP2PStore.stringPageNumber');

  @override
  String get stringPageNumber {
    _$stringPageNumberAtom.reportRead();
    return super.stringPageNumber;
  }

  @override
  set stringPageNumber(String value) {
    _$stringPageNumberAtom.reportWrite(value, super.stringPageNumber, () {
      super.stringPageNumber = value;
    });
  }

  final _$keyRegionGuidAtom = Atom(name: '_CameraP2PStore.keyRegionGuid');

  @override
  String get keyRegionGuid {
    _$keyRegionGuidAtom.reportRead();
    return super.keyRegionGuid;
  }

  @override
  set keyRegionGuid(String value) {
    _$keyRegionGuidAtom.reportWrite(value, super.keyRegionGuid, () {
      super.keyRegionGuid = value;
    });
  }

  final _$stringFutureAtom = Atom(name: '_CameraP2PStore.stringFuture');

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

  final _$responseFutureAtom = Atom(name: '_CameraP2PStore.responseFuture');

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

  final _$selectFatherFilterAsyncAction =
      AsyncAction('_CameraP2PStore.selectFatherFilter');

  @override
  Future<void> selectFatherFilter(
      {required List<Region> thisRegions,
      required List<Region> parentRegion,
      required Region region}) {
    return _$selectFatherFilterAsyncAction.run(() => super.selectFatherFilter(
        thisRegions: thisRegions, parentRegion: parentRegion, region: region));
  }

  final _$getCameraListAsyncAction =
      AsyncAction('_CameraP2PStore.getCameraList');

  @override
  Future<dynamic> getCameraList(Map<String, dynamic> params,
      {bool isLoadMore = false,
      String keyName = '',
      String keyRegionGuid = ''}) {
    return _$getCameraListAsyncAction.run(() => super.getCameraList(params,
        isLoadMore: isLoadMore,
        keyName: keyName,
        keyRegionGuid: keyRegionGuid));
  }

  final _$refreshAsyncAction = AsyncAction('_CameraP2PStore.refresh');

  @override
  Future<dynamic> refresh({String keyName = '', String keyRegionGuid = ''}) {
    return _$refreshAsyncAction.run(
        () => super.refresh(keyName: keyName, keyRegionGuid: keyRegionGuid));
  }

  final _$addMoreCameraAsyncAction =
      AsyncAction('_CameraP2PStore.addMoreCamera');

  @override
  Future<dynamic> addMoreCamera(List<CameraP2P> selectedCam) {
    return _$addMoreCameraAsyncAction
        .run(() => super.addMoreCamera(selectedCam));
  }

  final _$onSelectCameraOnViewAsyncAction =
      AsyncAction('_CameraP2PStore.onSelectCameraOnView');

  @override
  Future<dynamic> onSelectCameraOnView(int index) {
    return _$onSelectCameraOnViewAsyncAction
        .run(() => super.onSelectCameraOnView(index));
  }

  final _$addCameraAsyncAction = AsyncAction('_CameraP2PStore.addCamera');

  @override
  Future<dynamic> addCamera(List<CameraP2P> selectedCam) {
    return _$addCameraAsyncAction.run(() => super.addCamera(selectedCam));
  }

  final _$onSwitchModeAsyncAction = AsyncAction('_CameraP2PStore.onSwitchMode');

  @override
  Future<dynamic> onSwitchMode(int mode, int index) {
    return _$onSwitchModeAsyncAction.run(() => super.onSwitchMode(mode, index));
  }

  final _$onNextPageAsyncAction = AsyncAction('_CameraP2PStore.onNextPage');

  @override
  Future<dynamic> onNextPage(int page, int mode) {
    return _$onNextPageAsyncAction.run(() => super.onNextPage(page, mode));
  }

  final _$onPreviousPageAsyncAction =
      AsyncAction('_CameraP2PStore.onPreviousPage');

  @override
  Future<dynamic> onPreviousPage(int page, int mode) {
    return _$onPreviousPageAsyncAction
        .run(() => super.onPreviousPage(page, mode));
  }

  final _$removeCameraAsyncAction = AsyncAction('_CameraP2PStore.removeCamera');

  @override
  Future<dynamic> removeCamera(CameraP2P selectedCam) {
    return _$removeCameraAsyncAction.run(() => super.removeCamera(selectedCam));
  }

  final _$removeCameraAtIndexAsyncAction =
      AsyncAction('_CameraP2PStore.removeCameraAtIndex');

  @override
  Future<dynamic> removeCameraAtIndex(int index) {
    return _$removeCameraAtIndexAsyncAction
        .run(() => super.removeCameraAtIndex(index));
  }

  final _$removeAllCameraAsyncAction =
      AsyncAction('_CameraP2PStore.removeAllCamera');

  @override
  Future<dynamic> removeAllCamera() {
    return _$removeAllCameraAsyncAction.run(() => super.removeAllCamera());
  }

  final _$saveTempCameraOnViewAsyncAction =
      AsyncAction('_CameraP2PStore.saveTempCameraOnView');

  @override
  Future<dynamic> saveTempCameraOnView() {
    return _$saveTempCameraOnViewAsyncAction
        .run(() => super.saveTempCameraOnView());
  }

  final _$clearTempCameraAsyncAction =
      AsyncAction('_CameraP2PStore.clearTempCamera');

  @override
  Future<dynamic> clearTempCamera() {
    return _$clearTempCameraAsyncAction.run(() => super.clearTempCamera());
  }

  final _$removeManyCameraAsyncAction =
      AsyncAction('_CameraP2PStore.removeManyCamera');

  @override
  Future<dynamic> removeManyCamera(List<CameraP2P?> selectedCam) {
    return _$removeManyCameraAsyncAction
        .run(() => super.removeManyCamera(selectedCam));
  }

  final _$addCameraToEmptySlotAsyncAction =
      AsyncAction('_CameraP2PStore.addCameraToEmptySlot');

  @override
  Future<dynamic> addCameraToEmptySlot(int removeIndex, CameraP2P cameraToAdd) {
    return _$addCameraToEmptySlotAsyncAction
        .run(() => super.addCameraToEmptySlot(removeIndex, cameraToAdd));
  }

  final _$addCameraToViewAsyncAction =
      AsyncAction('_CameraP2PStore.addCameraToView');

  @override
  Future<dynamic> addCameraToView(CameraP2P cameraToAdd) {
    return _$addCameraToViewAsyncAction
        .run(() => super.addCameraToView(cameraToAdd));
  }

  final _$clearCameraAsyncAction = AsyncAction('_CameraP2PStore.clearCamera');

  @override
  Future<dynamic> clearCamera() {
    return _$clearCameraAsyncAction.run(() => super.clearCamera());
  }

  final _$clearSelectedCameraAsyncAction =
      AsyncAction('_CameraP2PStore.clearSelectedCamera');

  @override
  Future<dynamic> clearSelectedCamera() {
    return _$clearSelectedCameraAsyncAction
        .run(() => super.clearSelectedCamera());
  }

  final _$addDeviceAsyncAction = AsyncAction('_CameraP2PStore.addDevice');

  @override
  Future<dynamic> addDevice(Map<String, dynamic> params) {
    return _$addDeviceAsyncAction.run(() => super.addDevice(params));
  }

  final _$getIceServerInfoAsyncAction =
      AsyncAction('_CameraP2PStore.getIceServerInfo');

  @override
  Future<dynamic> getIceServerInfo(Map<String, dynamic> params) {
    return _$getIceServerInfoAsyncAction
        .run(() => super.getIceServerInfo(params));
  }

  final _$checkDeviceStatusAsyncAction =
      AsyncAction('_CameraP2PStore.checkDeviceStatus');

  @override
  Future<dynamic> checkDeviceStatus(Map<String, dynamic> params) {
    return _$checkDeviceStatusAsyncAction
        .run(() => super.checkDeviceStatus(params));
  }

  final _$getDetailsByCameraGuidAsyncAction =
      AsyncAction('_CameraP2PStore.getDetailsByCameraGuid');

  @override
  Future<dynamic> getDetailsByCameraGuid(String objectGuid) {
    return _$getDetailsByCameraGuidAsyncAction
        .run(() => super.getDetailsByCameraGuid(objectGuid));
  }

  final _$updateCameraAsyncAction = AsyncAction('_CameraP2PStore.updateCamera');

  @override
  Future<dynamic> updateCamera(
      {required String objectGuid,
      required String cameraName,
      required int? objectId}) {
    return _$updateCameraAsyncAction.run(() => super.updateCamera(
        objectGuid: objectGuid, cameraName: cameraName, objectId: objectId));
  }

  final _$getRegionListAsyncAction =
      AsyncAction('_CameraP2PStore.getRegionList');

  @override
  Future<dynamic> getRegionList() {
    return _$getRegionListAsyncAction.run(() => super.getRegionList());
  }

  final _$_CameraP2PStoreActionController =
      ActionController(name: '_CameraP2PStore');

  @override
  bool checkSelect(Region selected) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.checkSelect');
    try {
      return super.checkSelect(selected);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void observerSelectFilter(Region selected) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.observerSelectFilter');
    try {
      return super.observerSelectFilter(selected);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unselectFilter(Region selected) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.unselectFilter');
    try {
      return super.unselectFilter(selected);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectChildrenFilter(int parentId, List<Region> children) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.selectChildrenFilter');
    try {
      return super.selectChildrenFilter(parentId, children);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unSelectChildrenFilter(int parentId, List<Region> children) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.unSelectChildrenFilter');
    try {
      return super.unSelectChildrenFilter(parentId, children);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unselectParent(int parentId, List<Region> parents) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.unselectParent');
    try {
      return super.unselectParent(parentId, parents);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createListKey() {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.createListKey');
    try {
      return super.createListKey();
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic popFilter() {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.popFilter');
    try {
      return super.popFilter();
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openFilterPU() {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.openFilterPU');
    try {
      return super.openFilterPU();
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancelFilter() {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.cancelFilter');
    try {
      return super.cancelFilter();
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectDeviceByEye(CameraP2P? cameraP2P) {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.selectDeviceByEye');
    try {
      return super.selectDeviceByEye(cameraP2P);
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCameraList() {
    final _$actionInfo = _$_CameraP2PStoreActionController.startAction(
        name: '_CameraP2PStore.clearCameraList');
    try {
      return super.clearCameraList();
    } finally {
      _$_CameraP2PStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
regionList: ${regionList},
cameraP2PList: ${cameraP2PList},
selectedCamera: ${selectedCamera},
camOnView: ${camOnView},
selectFromDeviceManagement: ${selectFromDeviceManagement},
count: ${count},
isOpenPU: ${isOpenPU},
success: ${success},
selectedFilterItems: ${selectedFilterItems},
currentPage: ${currentPage},
currentViewPage: ${currentViewPage},
pageSize: ${pageSize},
selectedIndex: ${selectedIndex},
stringPageNumber: ${stringPageNumber},
keyRegionGuid: ${keyRegionGuid},
stringFuture: ${stringFuture},
responseFuture: ${responseFuture},
isFilter: ${isFilter},
loading: ${loading},
stringResponseloading: ${stringResponseloading}
    ''';
  }
}
