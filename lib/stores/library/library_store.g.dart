// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LibraryStore on _LibraryStore, Store {
  final _$isEditAtom = Atom(name: '_LibraryStore.isEdit');

  @override
  bool get isEdit {
    _$isEditAtom.reportRead();
    return super.isEdit;
  }

  @override
  set isEdit(bool value) {
    _$isEditAtom.reportWrite(value, super.isEdit, () {
      super.isEdit = value;
    });
  }

  final _$isSelectedAllAtom = Atom(name: '_LibraryStore.isSelectedAll');

  @override
  bool get isSelectedAll {
    _$isSelectedAllAtom.reportRead();
    return super.isSelectedAll;
  }

  @override
  set isSelectedAll(bool value) {
    _$isSelectedAllAtom.reportWrite(value, super.isSelectedAll, () {
      super.isSelectedAll = value;
    });
  }

  final _$allAssetEntityListAtom =
      Atom(name: '_LibraryStore.allAssetEntityList');

  @override
  ObservableList<AssetEntity> get allAssetEntityList {
    _$allAssetEntityListAtom.reportRead();
    return super.allAssetEntityList;
  }

  @override
  set allAssetEntityList(ObservableList<AssetEntity> value) {
    _$allAssetEntityListAtom.reportWrite(value, super.allAssetEntityList, () {
      super.allAssetEntityList = value;
    });
  }

  final _$mediaListAtom = Atom(name: '_LibraryStore.mediaList');

  @override
  ObservableList<Media> get mediaList {
    _$mediaListAtom.reportRead();
    return super.mediaList;
  }

  @override
  set mediaList(ObservableList<Media> value) {
    _$mediaListAtom.reportWrite(value, super.mediaList, () {
      super.mediaList = value;
    });
  }

  final _$selectedAssetEntityListAtom =
      Atom(name: '_LibraryStore.selectedAssetEntityList');

  @override
  ObservableList<AssetEntity> get selectedAssetEntityList {
    _$selectedAssetEntityListAtom.reportRead();
    return super.selectedAssetEntityList;
  }

  @override
  set selectedAssetEntityList(ObservableList<AssetEntity> value) {
    _$selectedAssetEntityListAtom
        .reportWrite(value, super.selectedAssetEntityList, () {
      super.selectedAssetEntityList = value;
    });
  }

  final _$getMediaListAsyncAction = AsyncAction('_LibraryStore.getMediaList');

  @override
  Future<void> getMediaList(UserStore userStore) {
    return _$getMediaListAsyncAction.run(() => super.getMediaList(userStore));
  }

  final _$groupMediaByDateAsyncAction =
      AsyncAction('_LibraryStore.groupMediaByDate');

  @override
  Future<void> groupMediaByDate() {
    return _$groupMediaByDateAsyncAction.run(() => super.groupMediaByDate());
  }

  final _$downloadSelectedAssetEntitiesAsyncAction =
      AsyncAction('_LibraryStore.downloadSelectedAssetEntities');

  @override
  Future<void> downloadSelectedAssetEntities() {
    return _$downloadSelectedAssetEntitiesAsyncAction
        .run(() => super.downloadSelectedAssetEntities());
  }

  final _$saveAssetEntityAsyncAction =
      AsyncAction('_LibraryStore.saveAssetEntity');

  @override
  Future<bool> saveAssetEntity(AssetEntity entity) {
    return _$saveAssetEntityAsyncAction
        .run(() => super.saveAssetEntity(entity));
  }

  final _$deleteSelectedAssetEntitiesAsyncAction =
      AsyncAction('_LibraryStore.deleteSelectedAssetEntities');

  @override
  Future<void> deleteSelectedAssetEntities() {
    return _$deleteSelectedAssetEntitiesAsyncAction
        .run(() => super.deleteSelectedAssetEntities());
  }

  final _$deleteAAssetEntityAsyncAction =
      AsyncAction('_LibraryStore.deleteAAssetEntity');

  @override
  Future<bool> deleteAAssetEntity(AssetEntity entity) {
    return _$deleteAAssetEntityAsyncAction
        .run(() => super.deleteAAssetEntity(entity));
  }

  final _$_LibraryStoreActionController =
      ActionController(name: '_LibraryStore');

  @override
  void selectMedia(AssetEntity entity) {
    final _$actionInfo = _$_LibraryStoreActionController.startAction(
        name: '_LibraryStore.selectMedia');
    try {
      return super.selectMedia(entity);
    } finally {
      _$_LibraryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectAllAssetEntityList() {
    final _$actionInfo = _$_LibraryStoreActionController.startAction(
        name: '_LibraryStore.selectAllAssetEntityList');
    try {
      return super.selectAllAssetEntityList();
    } finally {
      _$_LibraryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelectedEntityList() {
    final _$actionInfo = _$_LibraryStoreActionController.startAction(
        name: '_LibraryStore.clearSelectedEntityList');
    try {
      return super.clearSelectedEntityList();
    } finally {
      _$_LibraryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void edit(bool isEdit) {
    final _$actionInfo =
        _$_LibraryStoreActionController.startAction(name: '_LibraryStore.edit');
    try {
      return super.edit(isEdit);
    } finally {
      _$_LibraryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEdit: ${isEdit},
isSelectedAll: ${isSelectedAll},
allAssetEntityList: ${allAssetEntityList},
mediaList: ${mediaList},
selectedAssetEntityList: ${selectedAssetEntityList}
    ''';
  }
}
