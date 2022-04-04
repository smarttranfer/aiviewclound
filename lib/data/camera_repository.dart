import 'dart:async';

import 'package:aiviewcloud/data/sharedpref/shared_preference_helper.dart';


import 'network/apis/camerap2p/camerap2p_api.dart';

class CameraP2PRepository {
  final CameraP2PApi _cameraP2PApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  CameraP2PRepository(this._cameraP2PApi, this._sharedPrefsHelper);

  Future<Map<String, dynamic>> getCameraP2pList(
      Map<String, dynamic> params) async {
    return await _cameraP2PApi.getCameraList(params).then((list) {
      return list;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> addCamera(Map<String, dynamic> params) async {
    return await _cameraP2PApi.addCamera(params).then((resp) {
      return resp;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> getIceServerInfo(
      Map<String, dynamic> params) async {
    return await _cameraP2PApi.getIceServerInfo(params).then((resp) {
      return resp;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> checkStatusCamera(
      Map<String, dynamic> params) async {
    return await _cameraP2PApi.checkStatusCamera(params).then((resp) {
      return resp;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> getDetailsByCameraGuid(
      Map<String, dynamic> params) async {
    return await _cameraP2PApi.getDetailsByCameraGuid(params).then((resp) {
      return resp;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> updateCamera(Map<String, dynamic> params) async {
    return await _cameraP2PApi.updateCamera(params).then((resp) {
      return resp;
    }).catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> getRegionList() async {
    return await _cameraP2PApi.getRegionList().then((list) {
      return list;
    }).catchError((error) => throw error);
  }
}
