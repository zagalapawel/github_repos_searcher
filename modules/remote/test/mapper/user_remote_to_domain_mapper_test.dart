import 'package:domain/model/user.dart';
import 'package:remote/mapper/user_remote_to_domain_mapper.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'UserRemoteToDomainMapper',
    () {
      late UserRemoteToDomainMapper userRemoteToDomainMapper;

      setUp(
        () => userRemoteToDomainMapper = const UserRemoteToDomainMapper(),
      );

      test(
        'should correctly map response',
        () {
          const response = UserRemoteModel(
            avatarUrl: 'avatarUrl',
            id: 123,
            login: 'login',
          );

          const expectedResult = User(
            avatarUrl: 'avatarUrl',
            id: 123,
            login: 'login',
          );

          final result = userRemoteToDomainMapper.map(response);

          expect(result, expectedResult);
        },
      );
    },
  );
}
