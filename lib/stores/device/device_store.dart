import 'package:aiviewcloud/data/repository.dart';
import 'package:aiviewcloud/models/camera/camera_lan.dart';
import 'package:aiviewcloud/stores/error/error_store.dart';
import 'package:aiviewcloud/utils/dio/dio_error_util.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'device_store.g.dart';

@Injectable()
class DeviceStore = _DeviceStore with _$DeviceStore;

abstract class _DeviceStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _DeviceStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<LanCamera?> emptyDeviceResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<LanCamera?> fetchDevicesFuture =
      ObservableFuture<LanCamera?>(emptyDeviceResponse);

  @observable
  LanCamera? camera;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchDevicesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<LanCamera> getCamera(String? address, String body) async {
    final future = _repository.getCameraInfo(address!, body);
    fetchDevicesFuture = ObservableFuture(future);

    return future.then((camera) {
      return camera;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error, "");
    });
  }

  @action
  Future<LanCamera> sendCommand(String? address, String body) async {
    final future = _repository.sendCommand(address!, body);
    fetchDevicesFuture = ObservableFuture(future);

    return future.then((camera) {
      return camera;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error, "");
    });
  }

  @action
  Future addCamera(String? address, String body) async {
    final future = _repository.getCameraInfo(address!, body);
    fetchDevicesFuture = ObservableFuture(future);

    future.then((camera) {
      print(camera);

      this.camera = camera;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error, "");
    });
  }
}
