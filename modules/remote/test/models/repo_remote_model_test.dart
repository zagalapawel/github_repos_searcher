import 'package:remote/models/repo_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'RepoRemoteModel',
    () {
      const model = RepoRemoteModel(
        name: 'name',
        id: 1,
        description: 'description',
        owner: UserRemoteModel(
          avatarUrl: 'avatarUrl',
          id: 123,
          login: 'login',
        ),
        topics: ['topic'],
      );

      final jsonMap = <String, dynamic>{
        'name': 'name',
        'id': 1,
        'description': 'description',
        'owner': {
          'avatar_url': 'avatarUrl',
          'id': 123,
          'login': 'login',
        },
        'topics': ['topic'],
      };

      test(
        'should create model from json',
        () {
          final result = RepoRemoteModel.fromJson(jsonMap);

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
