import 'package:remote/models/get_repos_request_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'GetReposRequestRemoteModel',
    () {
      const model = GetReposRequestRemoteModel(
        pageNumber: 1,
        pageSize: 1,
        queryText: 'queryText',
      );

      final jsonMap = <String, dynamic>{
        'pageNumber': 1,
        'pageSize': 1,
        'queryText': 'queryText',
      };

      test(
        'should create model from json',
        () {
          final result = GetReposRequestRemoteModel.fromJson(jsonMap);

          expect(result, model);
        },
      );

      test(
        'should create json from model',
        () {
          final result = model.toJson();

          expect(result, jsonMap);
        },
      );
    },
  );
}
