import 'package:dio/dio.dart';
import 'package:domain/model/error_detail.dart';
import 'package:remote/models/error/error_object.dart';

class ErrorConverter {
  const ErrorConverter();

  ErrorDetail? convert<BodyType>(Object? error) {
    if (error == null) {
      return null;
    }

    if (error is! DioException) {
      return const ErrorDetail.fatal();
    }

    final data = error.response?.data;

    if (data == null || data is! Map<String, dynamic>) {
      return const ErrorDetail.fatal();
    }

    try {
      final errorObject = ErrorObject.fromJson((data));
      return ErrorDetail.backend(
        status: errorObject.status,
        message: errorObject.message,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return const ErrorDetail.fatal();
    }
  }

  ErrorDetail handleRemoteError(Object error, StackTrace stackTrace) {
    if (error is DioException && error.type == DioExceptionType.badResponse) {
      return convert(error) ?? const ErrorDetail.fatal();
    }
    return ErrorDetail.fatal(throwable: error, stackTrace: stackTrace);
  }
}
