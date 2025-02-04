import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';

void main() {
  group(
    'RepoDetailsArgument',
    () {
      const model = RepoDetailsArgument(
        repo: Repo(
          name: 'name',
          id: 1,
          description: 'description',
          owner: User(
            avatarUrl: 'avatarUrl',
            id: 123,
            login: 'login',
          ),
          topics: ['topic'],
        ),
      );

      final jsonMap = <String, dynamic>{
        'repo': {
          'name': 'name',
          'id': 1,
          'description': 'description',
          'owner': {
            'avatarUrl': 'avatarUrl',
            'id': 123,
            'login': 'login',
          },
          'topics': ['topic'],
        },
      };

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
