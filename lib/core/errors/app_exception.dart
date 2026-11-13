enum AppExceptionType { noInternet, timeout, server, notFound, unknown }

class AppException implements Exception {
  final AppExceptionType type;
  final String message;
  final int? statusCode;

  const AppException(this.type, this.message, {this.statusCode});

  @override
  String toString() => 'AppException($type, $statusCode): $message';
}
