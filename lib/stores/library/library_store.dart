import 'dart:async';
import 'dart:io';
import 'package:aiviewcloud/models/library/media.dart';
import 'package:aiviewcloud/stores/error/error_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:collection/collection.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
// import 'package:image/image.dart' as image;
part 'library_store.g.dart';

@Injectable()
class LibraryStore = _LibraryStore with _$LibraryStore;

abstract class _LibraryStore with Store {
  List<AssetPathEntity> assetPathList = [];
  ErrorStore errorStore = ErrorStore();

  Directory? directory;

  Future<List<FileSystemEntity>>? listFile;

  // store variables:-----------------------------------------------------------

  @observable
  bool isEdit = false;

  @observable
  bool isSelectedAll = false;

  @observable
  ObservableList<AssetEntity> allAssetEntityList =
      ObservableList<AssetEntity>.of([]);

  @observable
  ObservableList<Media> mediaList = ObservableList<Media>.of([]);

  @observable
  ObservableList<AssetEntity> selectedAssetEntityList =
      ObservableList<AssetEntity>.of([]);

  // actions:-------------------------------------------------------------------

  @action
  Future<void> getMediaList(UserStore userStore) async {
    await getStorageDirectory(userStore).then((value) => dirContents(value));
    await getListAssetEntity();
    await groupMediaByDate();
  }

  @action
  Future<void> groupMediaByDate() async {
    mediaList.clear();
    final groups = groupBy(allAssetEntityList, (AssetEntity e) {
      return DateTime(
        DateTime.fromMillisecondsSinceEpoch(e.createDtSecond!).year,
        DateTime.fromMillisecondsSinceEpoch(e.createDtSecond!).month,
        DateTime.fromMillisecondsSinceEpoch(e.createDtSecond!).day,
      );
    });
    for (var date in groups.keys.toList()) {
      mediaList.add(Media(
          createdTime: date, listMedia: groups[date] as List<AssetEntity>));
    }
  }

  @action
  void selectMedia(AssetEntity entity) {
    if (selectedAssetEntityList
        .map((element) => element.id)
        .toList()
        .contains(entity.id)) {
      this.selectedAssetEntityList.remove(entity);
    } else {
      this.selectedAssetEntityList.add(entity);
    }
  }

  @action
  void selectAllAssetEntityList() {
    isSelectedAll = true;
    selectedAssetEntityList.clear();
    this.selectedAssetEntityList.addAll(allAssetEntityList);
  }

  @action
  void clearSelectedEntityList() {
    this.selectedAssetEntityList.clear();
    isSelectedAll = false;
  }

  @action
  void edit(bool isEdit) {
    this.isEdit = isEdit;
    if (!isEdit) {
      isSelectedAll = false;
      selectedAssetEntityList.clear();
    }
  }

  @action
  Future<void> downloadSelectedAssetEntities() async {
    /// làm tương tự deleteAAssetEntity
    await Future.wait(selectedAssetEntityList.map((e) async {
      try {
        var file = File(e.relativePath!);
        saveFile(file, e.id.split("/").last);
      } catch (ex) {
        print(ex);
      }
    }));
  }

  @action
  Future<bool> saveAssetEntity(AssetEntity entity) async {
    /// xóa file trong storage rồi các anh cần xóa file từ assetPathList nữa bằng cách check selectedId
    try {
      var file = File(entity.relativePath!);
      saveFile(file, entity.id.split("/").last);

      /// các anh thêm đoạn load lại list sau khi xóa nhé
      return true;
    } catch (e) {
      print("error =============>" + e.toString());
      return false;
    }
  }

  Future<void> saveFile(File file, String name) async {
    await ImageGallerySaver.saveFile(file.path,
        name: name, isReturnPathOfIOS: true);
  }

  @action
  Future<void> deleteSelectedAssetEntities() async {
    /// làm tương tự deleteAAssetEntity
    await Future.wait(selectedAssetEntityList.map((e) async {
      try {
        var file = File(e.relativePath!);
        await file.delete();
        await removeAssetInLocal([e.id]);
        await groupMediaByDate();
      } catch (ex) {}
    }));
  }

  @action
  Future<bool> deleteAAssetEntity(AssetEntity entity) async {
    /// xóa file trong storage rồi các anh cần xóa file từ assetPathList nữa bằng cách check selectedId
    try {
      var file = File(entity.relativePath!);
      print(file.path);
      await file.delete();
      await removeAssetInLocal([entity.id]);
      await groupMediaByDate();

      /// các anh thêm đoạn load lại list sau khi xóa nhé
      return true;
    } catch (e) {
      print("error =============>" + e.toString());
      return false;
    }
  }

  Future<Directory> getStorageDirectory(UserStore userStore) async {
    final Directory _appDocDir;
    if (Platform.isAndroid) {
      _appDocDir =
          (await getExternalStorageDirectory())!; // OR return "/storage/emulated/0/Download";
    } else {
      _appDocDir = await getApplicationDocumentsDirectory();
    }
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/${userStore.user!.objectGuid}/');
    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder;
    } else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder;
    }
  }

  void dirContents(Directory dir) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen((file) => files.add(file),
        // should also register onError
        onDone: () => completer.complete(files));
    listFile = completer.future;
  }

  Future<void> removeAssetInLocal(List<String> selectedIds) async {
    for (String id in selectedIds) {
      selectedAssetEntityList.removeWhere((element) => element.id == id);
      allAssetEntityList.removeWhere((element) => element.id == id);
    }
  }

  Future<void> getListAssetEntity() async {
    assetPathList.clear();
    try {
      List<FileSystemEntity> fileSystem = await listFile ?? [];
      List<AssetEntity> list = await parseSystemFileToAssetEntity(fileSystem);
      allAssetEntityList.addAll(list);
    } catch (ex) {
      print('========= ex $ex');
    }
  }

  Future<List<AssetEntity>> parseSystemFileToAssetEntity(
      List<FileSystemEntity> fileSystem) async {
    List<AssetEntity> list = [];
    await Future.wait(fileSystem.map((e) async {
      if (getFileType(e.path) != 0) {
        int unixTime =
            (await File(e.path).lastModified()).millisecondsSinceEpoch;
        int width = 200;
        int height = 200;
        list.add(
          AssetEntity(
            id: e.path,
            typeInt: getFileType(e.path),
            width: width,
            height: height,
            createDtSecond: unixTime,
            relativePath: e.path,
            modifiedDateSecond: unixTime,
          ),
        );
      }
    }));
    return list;
  }

  int getFileType(String path) {
    String ext = extension(path).toLowerCase();
    if (ext == '.png' || ext == '.jpg' || ext == '.jpeg') {
      return 1;
    }
    if (ext == '.mp4' || ext == '.mov') {
      return 2;
    }
    return 0;
  }
}
