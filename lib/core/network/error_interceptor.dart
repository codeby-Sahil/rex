import 'package:dio/dio.dart';
import 'api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 🔹 No Internet
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const NoInternetException(),
        ),
      );
      return;
    }

    // 🔹 Timeout
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const ApiException(
            message: "Connection timeout. Please try again.",
            statusCode: 408,
          ),
        ),
      );
      return;
    }

    // 🔹 If server responded
    if (err.response != null) {
      final data = err.response?.data;

      if (data is Map<String, dynamic>) {
        final int status = data["status"] ?? err.response?.statusCode ?? 500;

        final String message = data["message"] ?? "Something went wrong";

        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: ApiException(message: message, statusCode: status),
          ),
        );
        return;
      }
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: const ApiException(
          message: "Unexpected error occurred",
          statusCode: 500,
        ),
      ),
    );
  }
}
