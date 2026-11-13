import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../core/errors/app_exception.dart';

class DioClient {
  final Dio dio;

  DioClient({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: ApiConstants.connectTimeout,
                receiveTimeout: ApiConstants.receiveTimeout,
                headers: {'Content-Type': 'application/json'},
              ),
            );

  /// Converts any Dio failure into an [AppException] the UI can understand.
  static AppException mapError(Object error) {
    if (error is AppException) return error;
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const AppException(
            AppExceptionType.noInternet,
            'No internet connection.',
          );
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const AppException(
            AppExceptionType.timeout,
            'The request timed out. Please try again.',
          );
        case DioExceptionType.badResponse:
          final code = error.response?.statusCode;
          if (code == 404) {
            return AppException(
              AppExceptionType.notFound,
              'Item not found.',
              statusCode: code,
            );
          }
          return AppException(
            AppExceptionType.server,
            'Server error${code != null ? ' ($code)' : ''}.',
            statusCode: code,
          );
        default:
          return AppException(
            AppExceptionType.unknown,
            error.message ?? 'Something went wrong.',
          );
      }
    }
    return AppException(AppExceptionType.unknown, error.toString());
  }
}
