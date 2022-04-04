import 'dart:async';

import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/network/dio_client.dart';
import 'package:aiviewcloud/data/network/rest_client.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class CameraP2PApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CameraP2PApi(this._dioClient, this._restClient);

  /// Returns list of CameraP2P in response
  Future<CameraP2P> getCameraP2PInfo(String address, String body) async {
    try {
      final res = await _dioClient.post(
        address + '/api/Device',
        data: body,
      );
      return CameraP2P.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getCameraList(
      Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getUrlEndPoint + 'AppCamera/GetList',
          queryParameters: params);
      return res['Object'];
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> addCamera(Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.post(
          Endpoints.getUrlEndPoint + 'AppCamera/RegisterCamera',
          data: params);
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getIceServerInfo(
      Map<String, dynamic> headersParams) async {
    try {
      Options options = new Options(headers: headersParams);
      final res = await _dioClient.get(
          Endpoints.getP2PUrlEndPoint + 'server/resource/ices',
          options: options);
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> checkStatusCamera(
      Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getUrlEndPoint + 'AppCamera/CheckStatusCam',
          queryParameters: params);
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> createChannel(
      Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getP2PUrlEndPoint + '/client/channel/create',
          queryParameters: params);
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getDetailsByCameraGuid(
      Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getUrlEndPoint + 'AppCamera/GetDetailsByCameraGuid',
          queryParameters: params);
      return res['Object'];
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> updateCamera(Map<String, dynamic> params) async {
    try {
      final res = await _dioClient.post(
          Endpoints.getUrlEndPoint + 'AppCamera/UpdateCameraName',
          data: params);
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getRegionList() async {
    try {
      final res = await _dioClient.get(
        Endpoints.getUrlEndPoint + 'AppCamera/GetListRegion',
      );
      return res['Object'];
    } catch (e) {
      throw e;
    }
  }
}
