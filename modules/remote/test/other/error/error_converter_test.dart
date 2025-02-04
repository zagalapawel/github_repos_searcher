import 'package:dio/dio.dart';
import 'package:domain/model/error_detail.dart';
import 'package:remote/other/error/error_converter.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Given correct error with data provided it returns ErrorDetail',
    () {
      const converter = ErrorConverter();

      final requestOptions = RequestOptions(path: 'path');
      final error = DioException(
        requestOptions: requestOptions,
        response: Response(
          requestOptions: requestOptions,
          data: {
            'status': '404',
            'message': 'Not Found',
          },
        ),
      );

      final result = converter.convert(error);

      expect(
        result,
        const ErrorDetail.backend(
          status: '404',
          message: 'Not Found',
        ),
      );
    },
  );

  test(
    'Given null error provided it returns null',
    () {
      const converter = ErrorConverter();

      final result = converter.convert(null);

      expect(
        result,
        null,
      );
    },
  );

  test(
    'Given not map json error data provided it returns ErrorDetail.fatal',
    () {
      const converter = ErrorConverter();

      final result = converter.convert(10);

      expect(
        result,
        const ErrorDetail.fatal(),
      );
    },
  );

  test(
    'Given not DioException type error and stack trace then function handleRemoteError returns ErrorDetail.fatal',
    () {
      const converter = ErrorConverter();
      final stackTrace = StackTrace.fromString('stackTraceString');

      final result = converter.handleRemoteError(10, stackTrace);

      expect(
        result,
        ErrorDetail.fatal(throwable: 10, stackTrace: stackTrace),
      );
    },
  );

  test(
    'Given DioException type error and stack trace then function handleRemoteError returns ErrorDetail.fatal',
    () {
      const converter = ErrorConverter();
      final dioException = DioException(
        requestOptions: RequestOptions(path: 'path'),
        type: DioExceptionType.badResponse,
      );
      final stackTrace = StackTrace.fromString('stackTraceString');

      final result = converter.handleRemoteError(dioException, stackTrace);

      expect(
        result,
        const ErrorDetail.fatal(),
      );
    },
  );
}
