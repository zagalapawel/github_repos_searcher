import 'package:remote/models/get_repo_issues_request_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'GetRepoIssuesRequestRemoteModel',
    () {
      const model = GetRepoIssuesRequestRemoteModel(
        pageNumber: 1,
        pageSize: 1,
        owner: 'owner',
        repo: 'repo',
        state: 'open',
      );

      final jsonMap = <String, dynamic>{
        'pageNumber': 1,
        'pageSize': 1,
        'owner': 'owner',
        'repo': 'repo',
        'state': 'open',
      };

      test(
        'should create model from json',
        () {
          final result = GetRepoIssuesRequestRemoteModel.fromJson(jsonMap);

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
