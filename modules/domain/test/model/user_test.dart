import 'package:domain/model/user.dart';
import 'package:test/test.dart';

void main() {
  group(
    'User',
    () {
      const model = User(
        avatarUrl: 'avatarUrl',
        id: 123,
        login: 'login',
      );

      final jsonMap = <String, dynamic>{
        'avatarUrl': 'avatarUrl',
        'id': 123,
        'login': 'login',
      };

      test(
        'should create model from json',
        () {
          final result = User.fromJson(jsonMap);

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
