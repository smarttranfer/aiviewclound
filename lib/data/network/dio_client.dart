import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class DioClient {
  // dio instance
  final Dio _dio;
  // injecting dio instance
  DioClient(this._dio) {
    if (this._dio == null) {}
  }

  // void setHeader() {
  //   options.headers.putIfAbsent('Authorization', () => userToken.token);
  // }
  Dio get client {
    return this._dio;
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (options == null) {
        options = new Options(
            receiveTimeout: 10 * 1000, // 10 seconds
            sendTimeout: 10 * 1000);
      } else {
        options.receiveTimeout = 10 * 1000;
        options.sendTimeout = 10 * 1000;
      }
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (options == null) {
        options = new Options(
            receiveTimeout: 10 * 1000, // 10 seconds
            sendTimeout: 10 * 1000);
      } else {
        options.receiveTimeout = 10 * 1000;
        options.sendTimeout = 10 * 1000;
      }
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (options == null) {
        options = new Options(
            receiveTimeout: 10 * 1000, // 10 seconds
            sendTimeout: 10 * 1000);
      } else {
        options.receiveTimeout = 10 * 1000;
        options.sendTimeout = 10 * 1000;
      }
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (options == null) {
        options = new Options(
            receiveTimeout: 10 * 1000, // 10 seconds
            sendTimeout: 10 * 1000);
      } else {
        options.receiveTimeout = 10 * 1000;
        options.sendTimeout = 10 * 1000;
      }
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
