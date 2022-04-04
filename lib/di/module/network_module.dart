import 'dart:convert';

import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/sharedpref/shared_preference_helper.dart';
import 'package:aiviewcloud/models/user_token/user_token.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @factoryMethod
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();
    dio
      ..options.baseUrl = Endpoints.getUrlEndPoint
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            if (dio.options.headers['Authorization'] == null) {
              String? token = await sharedPrefHelper.authToken;
              if (token == null) return handler.next(options);
              if (token.length > 10) {
                try {
                  Map<String, dynamic> user = json.decode(token.trim());
                  var userToken = UserToken.fromJson(user);

                  dio.options.headers
                      .putIfAbsent('Authorization', () => userToken.token);
                  options.headers
                      .putIfAbsent('Authorization', () => userToken.token);
                } catch (e) {
                  return handler.next(options);
                }

                // var token = await sharedPrefHelper.authToken;
              }
            } else {
              options.headers.putIfAbsent(
                  'Authorization', () => dio.options.headers['Authorization']);
            }

            return handler.next(options);
          },
          // onResponse: (Response response, ResponseInterceptorHandler handler) {
          //   if (response.data[Object]) print('ressponse ${response.data}');
          // },
        ),
      );

    return dio;
  }
}
