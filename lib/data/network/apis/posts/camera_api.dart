import 'dart:async';
import 'dart:io';

import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/network/dio_client.dart';
import 'package:aiviewcloud/data/network/rest_client.dart';
import 'package:aiviewcloud/models/camera/camera_lan.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class CameraApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CameraApi(this._dioClient, this._restClient);

  /// Returns list of Camera in response
  Future<LanCamera> getCameraInfo(String address, String body) async {
    try {
      final res = await _dioClient.post(
        address + '/api/Device',
        data: body,
      );
      return LanCamera.fromJson(
          res['Envelope']['Body']['GetDeviceInformationResponse']);
    } catch (e) {
      throw e;
    }
  }

  Future<LanCamera> sendCommand(String address, String body) async {
    try {
      final res = await _dioClient.post(
        address + '/api/PTZConfiguration',
        data: body,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<CamerasList> getCameras() {
//
//    return _restClient
//        .get(Endpoints.getCameras)
//        .then((dynamic res) => CamerasList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
