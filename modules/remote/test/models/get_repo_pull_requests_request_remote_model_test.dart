import 'package:remote/models/get_repo_pull_requests_request_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'GetRepoPullRequestsRequestRemoteModel',
    () {
      const model = GetRepoPullRequestsRequestRemoteModel(
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
          final result = GetRepoPullRequestsRequestRemoteModel.fromJson(jsonMap);

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
