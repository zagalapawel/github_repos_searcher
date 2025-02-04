import 'package:remote/models/error/error_object.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ErrorObject',
    () {
      final errorObject = ErrorObject(
        status: '403',
        message: 'message',
      );

      final jsonMap = <String, dynamic>{
        'status': '403',
        'message': 'message',
      };

      test(
        'should create error object from json',
        () async {
          final result = ErrorObject.fromJson(jsonMap);

          expect(result, errorObject);
        },
      );

      test(
        'should create json from error object',
        () async {
          final result = errorObject.toJson();

          expect(result, jsonMap);
        },
      );
    },
  );
}
