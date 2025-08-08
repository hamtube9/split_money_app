import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:split_money/extension/context.dart';
import 'package:split_money/main.dart';
import 'package:split_money/route/app_path.dart';
import 'package:split_money/utils/app_exceptions.dart';
import 'package:split_money/utils/logger_intercepter.dart';

import '../commons/alert_dialog.dart';
import '../utils/shared_preference.dart';
import 'dependency_injection.dart';

class DioClient {
  // Time out duration 20s
  static const int timeOutDuration = 20000;

  static final Dio _dio = Dio();

  static final Dio _dioFormData = Dio();
  static String baseUrl = "";
  static String api = "";
  static String fullApi = "";

  /// Init Dio client
  static Future<Dio> initService() async {
    await getIt.isReady<SharedPreferencesService>();
    final sPref = getIt<SharedPreferencesService>();
    final token = await sPref.token;

    /// Get URL from .env
    // baseUrl = dotenv.get('BASE_URL');
    // api = dotenv.get('API_URL');
    baseUrl = "";
    api = "";
    fullApi = "$baseUrl$api";

    _dio
      ..options.baseUrl = fullApi
      ..options.connectTimeout = const Duration(milliseconds: timeOutDuration)
      ..options.receiveTimeout = const Duration(milliseconds: timeOutDuration)
      ..options.headers = {
        "Content-Type": "application/json",
        "Accept": "*/*",
      };

    _dioFormData
      ..options.baseUrl = fullApi
      ..options.connectTimeout = const Duration(milliseconds: timeOutDuration)
      ..options.receiveTimeout = const Duration(milliseconds: timeOutDuration)
      ..options.headers = {
        "Accept": "application/json",
      };
    if (kDebugMode) {
      _dio.interceptors.add(CustomLogInterceptor());
      _dioFormData.interceptors.add(CustomLogInterceptor());
    }

    /// Set Token when not empty
    if (token != null && token.isNotEmpty) {
      DioClient.setToken(token);
    }

    return _dio;
  }

  /// Set Token User
  static void setToken(String token) {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _dioFormData.options.headers['Authorization'] = "Bearer $token";
  }

  /// Set language for get Data
  static void setLocale(String countryCode) {
    _dio.options.headers['Accept-Language'] = countryCode;
    _dioFormData.options.headers['Accept-Language'] = countryCode;
  }

  /// Clear Token
  static void logOut() {
    _dio.interceptors.clear();
    _dio.options.headers.remove('Authorization');

    _dioFormData.interceptors.clear();
    _dioFormData.options.headers.remove('Authorization');
  }

  //GET
  Future<dynamic> get(String api) async {
    try {
      var response = await _dio.get(fullApi + api);
      return _processResponse(response);
    } on DioException catch (e) {
      _catchDioException(e);
    }
  }

  // DELETE
  Future<dynamic> delete(String api, {dynamic payloads}) async {
    try {
      var response = await _dio.delete(fullApi + api, data: payloads);
      return _processResponse(response);
    } on DioException catch (e) {
      _catchDioException(e);
    }
  }

  //POST
  Future<dynamic> post(String api, dynamic payloadObj) async {
    var payload = payloadObj;
    if (payloadObj is! FormData) {
      payload = json.encode(payloadObj);
    }
    try {
      var response = await _dio.post(fullApi + api, data: payload);
      return _processResponse(response);
    } on DioException catch (e) {
      _catchDioException(e);
    }
  }

  //POST WITH FORM-DATA
  Future<dynamic> postFormData(String api, dynamic payloadObj) async {
    try {
      final dio = _dioFormData
        ..options.contentType = Headers.formUrlEncodedContentType;
      var response = await dio.post(fullApi + api, data: payloadObj);
      return _processResponse(response);
    } on DioException catch (e) {
      _catchDioException(e);
    }
  }

  //POST - MultiPart
  Future<dynamic> postMultiPart(
      String api, FormData formData, Function(int, int) onSendProgress,
      {CancelToken? cancelToken}) async {
    try {
      var response = await _dio.post(fullApi + api,
          data: formData,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken);
      return _processResponse(response);
    } on DioException catch (e) {
      _catchDioException(e);
    }
  }

  // OTHER
  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 406:
        return response.data;
      case 413:
        throw FileTooLargeException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }

  //PUT
  Future<dynamic> put(String api, dynamic payloadObj) async {
    var payload = payloadObj;
    if (payloadObj is! FormData) {
      payload = json.encode(payloadObj);
    }
    try {
      var response = await _dio
          .put(fullApi + api, data: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on DioException catch (e) {
      _catchDioException(e);
    }
  }

  /// Check Authorization
  void _checkUnauthorized(DioException e) async {
    var context = navigatorKey.currentState!.overlay!.context;
    /// Authentication Error
    if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
      /// Check Token is Empty or not
      var token = await getIt<SharedPreferencesService>().token;
      /// If Token not null then Token is Expire
      if (token != null && token.isNotEmpty) {
        /// If Session Expire then user must re-login
        AlertPopup(
            title: 'Error',
            msg: 'Token Expired',
            declinedText: 'Login',
            declinedAction: () async {
              DioClient.logOut();
              await getIt.get<SharedPreferencesService>().logOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppPaths.splash, (_) => false);
            }).showAlertPopup(context);
        return;
      }
    }
    /// Show Error
    AlertPopup(
        title: 'Error',
        msg: e.response?.data['error_message'],
        declinedText: 'Close',
        declinedAction: () async {
          context.pop();
        }).showAlertPopup(context);
  }

  void _catchDioException(DioException e) {
    if (DioExceptionType.receiveTimeout == e.type) {
      throw ApiNotRespondingException('API not responded in time', api);
    } else if (DioExceptionType.sendTimeout == e.type) {
      throw FetchDataException('No Internet connection', api);
    } else if (DioExceptionType.cancel == e.type) {
      // 4xx 5xx response
      // throw exception...
      throw NotFoundException('${e.response?.data['message']}', api);
    } else if (DioExceptionType.badResponse == e.type) {
      _checkUnauthorized(e);
    } else if (DioExceptionType.unknown == e.type) {
      if ((e.message ?? "").contains('SocketException')) {
        throw 'No internet connection';
      } else if ((e.message ?? "").contains('Unhandled Exception')) {
        throw NotFoundException('Not found exception', api);
      }
    } else if (DioExceptionType.cancel == e.type) {
      throw CancelRequestException('Cancel Request', api);
    } else {
      throw Exception("Problem connecting to the server. Please try again.");
    }
  }
}
