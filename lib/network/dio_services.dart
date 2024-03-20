import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_app_new/network/url_services.dart';

class dioService {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: UrlService.baseUrl,
      receiveTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
    ),
  );

  Future<Object?> get<T>({
    required String path,
    required T Function(dynamic data) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    // menggeck koneksi
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect == true) {
      try {
        _client.interceptors.add(LogInterceptor());
        final response = await _client.get(
          path,
          options: Options(
            headers: headers,
          ),
          queryParameters: queryParameters,
        );

        response.statusCode;

        // return onSuccess(response.data);
        if (response.statusCode == 200) {
          return onSuccess(response.data);
        } else {
          return onError(response.data);
        }
      } on DioError catch (e) {
        if (e.type == DioExceptionType.badResponse) {
          print('Masuk bad response');
          return onError(e.type);
        } else if (e.type == DioExceptionType.connectionTimeout) {
          return 'Timeout sending API';
          print('Timeout sending API');
        } else {
          print('selaiin bad response dan timeout, ${e.type.toString()}');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('tidak ada koneksi internet');
    }
  }

  Future<Object?> post<T>({
    required String path,
    required T Function(dynamic data) onSuccess,
    required T Function(dynamic error) onError,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
  }) async {
    final connect = await InternetConnectionChecker().hasConnection;

    if (connect == true) {
      try {
        _client.interceptors.add(LogInterceptor());
        final response = await _client.post(
          path,
          options: Options(
            headers: headers,
          ),
          data: body,
        );

        return onSuccess(response.data);
      } on DioError catch (e) {
        if (e.type == DioExceptionType.badResponse) {
          print('Masuk bad response');

          return onError(e.response?.data);
        } else if (e.type == DioExceptionType.connectionTimeout) {
          print('Timeout sending API');
        } else {
          print('selaiin bad response dan timeout, ${e.type.toString()}');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('tidak ada koneksi internet');
    }
  }

  Future<Object?> put<T>({
    required String path,
    required T Function(dynamic data) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> body,
  }) async {
    final connect = await InternetConnectionChecker().hasConnection;

    if (connect == true) {
      try {
        final response = await _client.put(
          path,
          data: body,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );

        return onSuccess(response.data);
      } on DioError catch (e) {
        if (e.type == DioExceptionType.badResponse) {
          print('Masuk bad response');
        } else if (e.type == DioExceptionType.connectionTimeout) {
          print('Timeout sending API');
        } else {
          print('selaiin bad response dan timeout, ${e.type.toString()}');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('tidak ada koneksi internet');
    }
  }

  Future<Object?> delete<T>({
    required String path,
    required T Function(dynamic data) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final connect = await InternetConnectionChecker().hasConnection;

    if (connect == true) {
      try {
        final response = await _client.delete(
          path,
          options: Options(
            headers: headers,
          ),
          queryParameters: queryParameters,
          data: body,
        );

        return onSuccess(response.data);
      } on DioError catch (e) {
        if (e.type == DioExceptionType.badResponse) {
          print('Masuk bad response');
        } else if (e.type == DioExceptionType.connectionTimeout) {
          print('Timeout sending API');
        } else {
          print('selaiin bad response dan timeout, ${e.type.toString()}');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('tidak ada koneksi internet');
    }
  }
}
