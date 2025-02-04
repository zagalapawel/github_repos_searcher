import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Repo',
    () {
      const model = Repo(
        name: 'name',
        id: 1,
        description: 'description',
        owner: User(
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
          'avatarUrl': 'avatarUrl',
          'id': 123,
          'login': 'login',
        },
        'topics': ['topic'],
      };

      test(
        'should create model from json',
        () {
          final result = Repo.fromJson(jsonMap);

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
