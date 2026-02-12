import 'dart:math';

import 'package:dio/dio.dart';
import 'package:prosnap/core/global/globals.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d("[${options.method}] -> ${options.uri}");

    if (options.data != null) {
      logger.d("${options.data}");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(response.data);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse) {
      logger.d(err.response?.data);
    } else {
      logger.e(err);
    }

    handler.next(err);
  }
}
