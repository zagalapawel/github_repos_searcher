import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'UserRemoteModel',
    () {
      const model = UserRemoteModel(
        avatarUrl: 'avatarUrl',
        id: 123,
        login: 'login',
      );

      final jsonMap = <String, dynamic>{
        'avatar_url': 'avatarUrl',
        'id': 123,
        'login': 'login',
      };

      test(
        'should create model from json',
        () {
          final result = UserRemoteModel.fromJson(jsonMap);

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
