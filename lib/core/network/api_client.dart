import 'package:dio/dio.dart';
import 'package:prosnap/core/network/auth_interceptor.dart';
import 'error_interceptor.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.yourdomain.com/",
        connectTimeout: const Duration(seconds: 200),
        receiveTimeout: const Duration(seconds: 200),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
      LogInterceptor(
        requestUrl: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    ]);
  }
}
