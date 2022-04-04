import 'package:aiviewcloud/data/camera_repository.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:aiviewcloud/models/region/region.dart';
import 'package:aiviewcloud/stores/error/error_store.dart';
import 'package:aiviewcloud/utils/dio/dio_error_util.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'camerap2p_store.g.dart';

@Injectable()
class CameraP2PStore = _CameraP2PStore with _$CameraP2PStore;

abstract class _CameraP2PStore with Store {
  // repository instance
  final CameraP2PRepository _cameraP2PRepository;

  // bool to check if current Camera is logged in

  final ErrorStore errorStore = ErrorStore();

  final List<Region> listRegionRes = [];

  @observable
  ObservableList<Region> regionList = new ObservableList<Region>.of([]);

  @observable
  ObservableList<CameraP2P> cameraP2PList =
      new ObservableList<CameraP2P>.of([]);

  @observable
  ObservableList<CameraP2P?> selectedCamera =
      new ObservableList<CameraP2P?>.of([]);

  @observable
  ObservableList<CameraP2P?> camOnView =
      new ObservableList<CameraP2P?>.of([null]);

  ObservableList<CameraP2P?> tempOfCamOnView =
      new ObservableList<CameraP2P?>.of([null]);

  @observable
  CameraP2P? selectFromDeviceManagement;

  @observable
  int? count = 0;

  @computed
  bool get isFilter => keyRegionGuid.isNotEmpty;

  @observable
  bool isOpenPU = false;

  // constructor:---------------------------------------------------------------
  _CameraP2PStore(CameraP2PRepository cameraP2PRepository)
      : this._cameraP2PRepository = cameraP2PRepository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  static ObservableFuture<Map<String, dynamic>?> emptyRespone =
      ObservableFuture.value(null);

  static ObservableFuture response = ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableList<Region> selectedFilterItems = ObservableList<Region>.of([]);

  // Region selectedFilterItems = Region(
  //   objectGuid: '',
  //   regionName: '',
  //   regionId: 0,
  //   parentId: 0,
  //   level: 0,
  // );

  @observable
  int currentPage = 1;

  @observable
  int currentViewPage = 0;

  @observable
  int pageSize = 30;

  @observable
  int selectedIndex = 0;

  @observable
  String stringPageNumber = '0/0';

  @observable
  String keyRegionGuid = "";

  // @observable
  // ObservableFuture<LoginObject?> loginFuture = emptyLoginResponse;

  // @observable
  // ObservableFuture<Camera?> registerFuture = emplyRegisterRespone;

  @observable
  ObservableFuture<Map<String, dynamic>?> stringFuture = emptyRespone;

  @observable
  ObservableFuture responseFuture = response;

  // @computed
  // bool get isLoading => loginFuture.status == FutureStatus.pending;

  // @computed
  // bool get registerLoading => registerFuture.status == FutureStatus.pending;

  @computed
  bool get loading => responseFuture.status == FutureStatus.pending;

  @computed
  bool get stringResponseloading => stringFuture.status == FutureStatus.pending;

  // @computed
  // void observerSelectFilter(String selected) {
  //   this.selectedFilterItems = selected;
  // }

  // actions:-------------------------------------------------------------------

  List<int> get listRegionId =>
      selectedFilterItems.map((element) => element.regionId).toList();

  @action
  bool checkSelect(Region selected) {
    return listRegionId.contains(selected.regionId);
  }

  @action
  void observerSelectFilter(Region selected) {
    if (!listRegionId.contains(selected.regionId)) {
      selectedFilterItems.add(selected);
    }
    createListKey();
  }

  @action
  void unselectFilter(Region selected) {
    if (listRegionId.contains(selected.regionId)) {
      selectedFilterItems.remove(selected);
    }
    createListKey();
  }

  @action
  void selectChildrenFilter(int parentId, List<Region> children) {
    children.forEach((element) {
      if (element.parentId == parentId) {
        observerSelectFilter(element);
        if (children.isNotEmpty) {
          List<Region> list = [];
          this.regionList.forEach((element1) {
            if (element1.level! - 1 == children.first.level) {
              list.add(element1);
            }
          });
          children.forEach((element1) {
            selectChildrenFilter(element1.regionId, list);
          });
        }
      }
    });
  }

  @action
  Future<void> selectFatherFilter(
      {required List<Region> thisRegions,
      required List<Region> parentRegion,
      required Region region}) async {
    var list = keyRegionGuid.split(";");
    bool check = true;
    thisRegions.forEach((element) {
      print(list.contains(element.objectGuid));
      if (!list.contains(element.objectGuid)) {
        check = false;
      }
    });
    if (check) {
      Region parent = parentRegion
          .firstWhere((element) => element.regionId == region.parentId);
      observerSelectFilter(parent);
    } else {
      return;
    }
  }

  @action
  void unSelectChildrenFilter(int parentId, List<Region> children) {
    children.forEach((element) {
      if (element.parentId == parentId) {
        unselectFilter(element);
        if (children.isNotEmpty) {
          List<Region> list = [];
          this.regionList.forEach((element1) {
            if (element1.level! - 1 == children.first.level) {
              list.add(element1);
            }
          });
          children.forEach((element1) {
            unSelectChildrenFilter(element1.regionId, list);
          });
        }
      }
    });
  }

  @action
  void unselectParent(int parentId, List<Region> parents) {
    parents.forEach((element) {
      if (element.regionId == parentId) {
        unselectFilter(element);
      }
    });
  }

  @action
  void createListKey() {
    if (this.selectedFilterItems.isEmpty) {
      keyRegionGuid = '';
    }
    if (this.selectedFilterItems.length == 1) {
      this.keyRegionGuid = this.selectedFilterItems.first.objectGuid;
    }
    if (this.selectedFilterItems.length > 1) {
      this.keyRegionGuid = this.selectedFilterItems.first.objectGuid;
      for (int i = 1; i < this.selectedFilterItems.length; i++) {
        this.keyRegionGuid += ";${this.selectedFilterItems[i].objectGuid}";
      }
    }
  }

  @action
  popFilter() {
    this.isOpenPU = false;
  }

  @action
  void openFilterPU() {
    this.isOpenPU = true;
  }

  @action
  cancelFilter() {
    this.isOpenPU = false;
    this.selectedFilterItems.clear();
    createListKey();
  }

  @action
  void selectDeviceByEye(CameraP2P? cameraP2P) {
    this.selectFromDeviceManagement = cameraP2P;
  }

  @action
  Future getCameraList(Map<String, dynamic> params,
      {bool isLoadMore = false,
      String keyName = '',
      String keyRegionGuid = ''}) async {
    final future = _cameraP2PRepository.getCameraP2pList({
      ...params,
      "CurrentPage": this.currentPage,
      "PageSize": this.pageSize,
      "KeyName": keyName,
      "KeyRegionGuid": keyRegionGuid,
    });
    responseFuture = ObservableFuture(future);
    await future.then((cameraP2PList) async {
      ObservableList<CameraP2P> list = ObservableList<CameraP2P>.of(
          cameraP2PList["listCamera"]
              .map<CameraP2P>((cameraP2P) => CameraP2P.fromJson(cameraP2P))
              .toList());
      if (list.length > 0) {
        this.currentPage++;
        this.cameraP2PList.addAll(list);
      }

      // this.removeManyCamera(selectedCamera);
      this.count = cameraP2PList["Count"];
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      print('error when fetching camera $e');
      throw e;
    });
  }

  @action
  Future refresh({String keyName = '', String keyRegionGuid = ''}) async {
    final future = _cameraP2PRepository.getCameraP2pList({
      "CurrentPage": 1,
      "PageSize": this.pageSize,
      "KeyName": keyName,
      "KeyRegionGuid": keyRegionGuid,
    });
    currentPage = 2;
    responseFuture = ObservableFuture(future);
    await future.then((cameraP2PList) async {
      this.cameraP2PList = ObservableList<CameraP2P>.of(
          cameraP2PList["listCamera"]
              .map<CameraP2P>((cameraP2P) => CameraP2P.fromJson(cameraP2P))
              .toList());

      // this.removeManyCamera(selectedCamera);
      this.count = cameraP2PList["Count"];
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      throw e;
    });
  }

  @action
  Future addMoreCamera(List<CameraP2P> selectedCam) async {
    this.selectedCamera.addAll(selectedCam);
  }

  @action
  Future onSelectCameraOnView(int index) async {
    this.camOnView[this.selectedIndex]!.selected = false;
    this.camOnView[index]!.selected = true;
    this.selectedIndex = index;
  }

  @action
  Future addCamera(List<CameraP2P> selectedCam) async {
    // selectedCam[0].selected = true;
    this.selectedCamera.addAll(selectedCam);
    if (this.camOnView[0] == null)
      this.camOnView = ObservableList.of([selectedCam[0]]);
    // this.stringPageNumber =
    //     (this.selectedCamera.length == 0 ? 0 : this.currentViewPage + 1)
    //             .toString() +
    //         '/' +
    //         (this.selectedCamera.length / pageSize).ceil().toString();
    // this.camOnView = ObservableList.of([0, 1, 2, 3].map((e) =>
    //     e <= this.selectedCamera.length - 1 ? this.selectedCamera[e] : null));
    // for (var i = 0; i < camOnView.length; i++) {
    //   if (this.camOnView[i] != null) {
    //     this.camOnView[i]!.selected = false;
    //   }
    // }
    // this.camOnView[0]!.selected = true;
  }

  @action
  Future onSwitchMode(int mode, int index) async {
    this.selectedIndex = 0;
    this.camOnView = new ObservableList<CameraP2P?>.of([null]);
    await Future.delayed(Duration(milliseconds: 300));

    if (mode == 1) {
      int indexInCamList = 4 * this.currentViewPage + index;
      this.currentViewPage = indexInCamList;
      this.camOnView = ObservableList.of([this.selectedCamera[indexInCamList]]);
    } else {
      int indexInCamList = this.currentViewPage;
      this.currentViewPage = (indexInCamList / 4).floor();
      int startIndex = 4 * this.currentViewPage;
      int endIndex =
          4 * this.currentViewPage + 4 > this.selectedCamera.length - 1
              ? this.selectedCamera.length - 1
              : 4 * this.currentViewPage + 3;
      this.camOnView = ObservableList.of([0, 1, 2, 3].map((e) =>
          e <= endIndex - startIndex
              ? this.selectedCamera[startIndex + e]
              : null));
      for (var i = 0; i < camOnView.length; i++) {
        if (this.camOnView[i] != null) {
          this.camOnView[i]!.selected = false;
        }
      }
      this.camOnView[indexInCamList % 4]!.selected = true;
    }
  }

  @action
  Future onNextPage(int page, int mode) async {
    if (page == this.currentViewPage) return;
    this.currentViewPage = page;

    this.camOnView = new ObservableList<CameraP2P?>.of([null]);
    await Future.delayed(Duration(milliseconds: 300));
    this.camOnView = ObservableList.of([this.selectedCamera[page]]);
    // for (var i = 0; i < 4; i++) {
    //   if (this.camOnView[i] != null) {
    //     this.camOnView[i]!.selected = false;
    //   }
    // }
    // this.camOnView[0]!.selected = true;
    // this.selectedIndex = 0;
  }

  @action
  Future onPreviousPage(int page, int mode) async {
    if (page == this.currentViewPage) return;
    this.currentViewPage = page;

    this.camOnView = this.camOnView = new ObservableList<CameraP2P?>.of([null]);
    await Future.delayed(Duration(milliseconds: 300));
    this.camOnView = ObservableList.of([this.selectedCamera[page]]);

    // for (var i = 0; i < 4; i++) {
    //   if (this.camOnView[i] != null) {
    //     this.camOnView[i]!.selected = false;
    //   }
    // }
    // this.camOnView[0]!.selected = true;
    // this.selectedIndex = 0;
  }

  @action
  Future removeCamera(CameraP2P selectedCam) async {
    this.cameraP2PList.remove(selectedCam);
  }

  @action
  void clearCameraList() {
    this.cameraP2PList.clear();
  }

  @action
  Future removeCameraAtIndex(int index) async {
    this.camOnView[index] = null;
  }

  @action
  Future removeAllCamera() async {
    this.currentViewPage = 0;
    this.selectFromDeviceManagement = null;
    this.selectedCamera.clear();
    this.camOnView = new ObservableList<CameraP2P?>.of([null]);
  }

  @action
  Future saveTempCameraOnView() async {
    this.tempOfCamOnView = this.camOnView;
    this.camOnView = this.camOnView = new ObservableList<CameraP2P?>.of([null]);
  }

  @action
  Future clearTempCamera() async {
    this.camOnView = this.tempOfCamOnView;
    this.tempOfCamOnView =
        this.camOnView = new ObservableList<CameraP2P?>.of([null]);
  }

  @action
  Future removeManyCamera(List<CameraP2P?> selectedCam) async {
    selectedCam.forEach((element) {
      if (element != null) {
        this.cameraP2PList.remove(element);
      }
    });
  }

  @action
  Future addCameraToEmptySlot(int removeIndex, CameraP2P cameraToAdd) async {
    this.camOnView = new ObservableList<CameraP2P?>.of([null]);
    await Future.delayed(Duration(milliseconds: 300));
    this.camOnView[0] = cameraToAdd;
  }

  @action
  Future addCameraToView(CameraP2P cameraToAdd) async {
    this.camOnView[0] = cameraToAdd;
  }

  @action
  Future clearCamera() async {
    this.selectedCamera.clear();
    this.camOnView = new ObservableList<CameraP2P?>.of([null]);
  }

  @action
  Future clearSelectedCamera() async {
    this.selectedCamera =
        this.camOnView = new ObservableList<CameraP2P?>.of([null]);
  }

  @action
  Future addDevice(Map<String, dynamic> params) async {
    final future = _cameraP2PRepository.addCamera(params);
    responseFuture = ObservableFuture(future);
    return await future.then((resp) async {
      return resp;
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      throw e;
    });
  }

  @action
  Future getIceServerInfo(Map<String, dynamic> params) async {
    final future = _cameraP2PRepository.getIceServerInfo(params);
    responseFuture = ObservableFuture(future);
    return await future.then((resp) async {
      return resp;
    }).catchError((e) {
      throw e;
    });
  }

  @action
  Future checkDeviceStatus(Map<String, dynamic> params) async {
    final future = _cameraP2PRepository.checkStatusCamera(params);
    responseFuture = ObservableFuture(future);
    return await future.then((resp) async {
      return resp;
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      throw e;
    });
  }

  @action
  Future getDetailsByCameraGuid(String objectGuid) async {
    final future =
        _cameraP2PRepository.getDetailsByCameraGuid({"ObjectGuid": objectGuid});
    responseFuture = ObservableFuture(future);
    return await future.then((resp) async {
      return resp;
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      throw e;
    });
  }

  @action
  Future updateCamera({
    required String objectGuid,
    required String cameraName,
    required int? objectId,
  }) async {
    final future = _cameraP2PRepository.updateCamera({
      "ObjectGuidCamera": objectGuid,
      "CameraName": cameraName,
      if (objectId != null) "ObjectId": objectGuid
    });
    responseFuture = ObservableFuture(future);
    return await future.then((resp) async {
      return resp;
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      throw e;
    });
  }

  @action
  Future getRegionList() async {
    final future = _cameraP2PRepository.getRegionList();
    responseFuture = ObservableFuture(future);
    await future.then((regionList) async {
      this.regionList = ObservableList<Region>.of(regionList["listRegion"]
          .map<Region>((region) => Region.fromJson(region))
          .toList());
    }).catchError((e) {
      errorStore.errorMessage = DioErrorUtil.handleError(e, "");
      throw e;
    });
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
