import 'dart:convert';

import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../error/exceptions.dart';

/// Thin wrapper around [Dio] for the `AppController` backend.
///
/// Every endpoint is a POST with the secret code sent as the form field `key`.
/// Responses are JSON objects; a body like `{"error": "..."}` is an error.
class ApiClient {
  ApiClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: AppConfig.apiBaseUrl,
              connectTimeout: AppConfig.connectTimeout,
              receiveTimeout: AppConfig.receiveTimeout,
              contentType: Headers.formUrlEncodedContentType,
              responseType: ResponseType.plain,
            ),
          );

  final Dio _dio;

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post<String>(
        path,
        data: {'key': AppConfig.apiKey, ...?body},
      );
      return _decode(response.data, response.statusCode);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Map<String, dynamic> _decode(String? raw, int? statusCode) {
    if (raw == null || raw.trim().isEmpty) {
      throw ServerException('Empty response', statusCode: statusCode);
    }
    final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      throw ServerException(
        'Invalid response from server',
        statusCode: statusCode,
      );
    }
    if (decoded is! Map) {
      throw ServerException(
        'Unexpected response format',
        statusCode: statusCode,
      );
    }
    final map = Map<String, dynamic>.from(decoded);
    if (map['error'] != null) {
      throw ServerException(map['error'].toString(), statusCode: statusCode);
    }
    return map;
  }

  Exception _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        return ServerException(
          'Server error (${e.response?.statusCode})',
          statusCode: e.response?.statusCode,
        );
      default:
        return ServerException(e.message ?? 'Request failed');
    }
  }
}
