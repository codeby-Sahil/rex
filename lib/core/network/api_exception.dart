abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class NoInternetException extends AppException {
  const NoInternetException()
    : super(message: "No internet connection. Please try again.");
}

class ApiException extends AppException {
  const ApiException({required super.message, super.statusCode});
}
