import 'package:dio/dio.dart';

import '../constants/app_config.dart';

/// Simple wrapper around [Dio] so buyers have
/// a single place to customize headers, interceptors,
/// logging, error handling, etc.
class ApiClient {
  ApiClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (AppConfig.apiKey.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${AppConfig.apiKey}';
          }
          handler.next(options);
        },
      ),
    );
  }

  final Dio _dio;

  Dio get client => _dio;
}

