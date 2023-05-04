api() {
  return """
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants.dart';

enum ConnectionStatus { loading, error, done }

class Api {
  Dio _dio() {
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer \$apiToken'
    };

    final dio = Dio(BaseOptions(
      headers: headers,
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 422) {
          // your http status code
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    ));

    //if debug mode show logger
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: false,
      ));
    }
    return dio;
  }

  get(String url,
      {Map<String, dynamic>? params,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) {
    _dio().get('\$baseUrl\$url', queryParameters: params).then((response) {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (onSuccess != null) onSuccess(response.data);
      } else {
        if (onError != null) onError(response.data['message']);
      }
    }).onError((DioError error, stackTrace) {
      if (error.response != null) {
        final message = error.response!.statusMessage;
        if (onError != null) onError(message);
      } else {
        if (onError != null) onError(error.message);
      }
    });
  }

  post(String url, dynamic params,
      {Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError,
      bool isUpload = false}) {
    _dio()
        .post(
      '\$baseUrl\$url',
      data: params,
    )
        .then((response) {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (onSuccess != null) onSuccess(response.data);
      } else {
        if (onError != null) onError(response.data['message']);
      }
    }).onError((DioError error, stackTrace) {
      if (error.response != null) {
        final message = error.response!.statusMessage;

        if (onError != null) onError(message);
      } else {
        if (onError != null) onError(error.message);
      }
    });
  }

  delete(String url,
      {Map<String, String>? params,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) {
    _dio().delete('\$baseUrl\$url').then((response) {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (onSuccess != null) onSuccess(response.data);
      } else {
        if (onError != null) onError(response.data['message']);
      }
    }).onError((DioError error, stackTrace) {
      if (error.response != null) {
        final message = error.response!.statusMessage;

        if (onError != null) onError(message);
      } else {
        if (onError != null) onError(error.message);
      }
    });
  }
}

""";
}
