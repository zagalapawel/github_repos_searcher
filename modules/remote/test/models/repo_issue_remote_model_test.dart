import 'package:remote/models/repo_issue_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'RepoIssueRemoteModel',
    () {
      const model = RepoIssueRemoteModel(
        id: 123,
        title: 'title',
        user: UserRemoteModel(
          id: 2,
          login: 'login',
          avatarUrl: 'avatarUrl',
        ),
      );

      final jsonMap = <String, dynamic>{
        'id': 123,
        'title': 'title',
        'user': {
          'id': 2,
          'login': 'login',
          'avatar_url': 'avatarUrl',
        },
      };

      test(
        'should create model from json',
        () {
          final result = RepoIssueRemoteModel.fromJson(jsonMap);

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
