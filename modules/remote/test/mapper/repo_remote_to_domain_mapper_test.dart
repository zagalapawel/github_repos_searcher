import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/mapper/user_remote_to_domain_mapper.dart';
import 'package:remote/mapper/repo_remote_to_domain_mapper.dart';
import 'package:remote/models/repo_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

class MockUserRemoteToDomainMapper extends Mock implements UserRemoteToDomainMapper {}

void main() {
  group(
    'RepoRemoteToDomainMapper',
    () {
      late RepoRemoteToDomainMapper repoRemoteToDomainMapper;
      late MockUserRemoteToDomainMapper mockUserRemoteToDomainMapper;

      setUp(
        () {
          mockUserRemoteToDomainMapper = MockUserRemoteToDomainMapper();
          repoRemoteToDomainMapper = RepoRemoteToDomainMapper(
            userToDomainMapper: mockUserRemoteToDomainMapper,
          );
        },
      );

      test(
        'should correctly map response',
        () {
          const userRemote = UserRemoteModel(
            avatarUrl: 'avatarUrl',
            id: 123,
            login: 'login',
          );
          const response = RepoRemoteModel(
            id: 1,
            name: 'name',
            owner: userRemote,
            topics: ['topic'],
          );

          const user = User(
            avatarUrl: 'avatarUrl',
            id: 123,
            login: 'login',
          );
          const expectedResult = Repo(
            id: 1,
            name: 'name',
            owner: user,
            topics: ['topic'],
          );

          when(
            () => mockUserRemoteToDomainMapper.map(userRemote),
          ).thenReturn(user);

          final result = repoRemoteToDomainMapper.map(response);

          expect(result, expectedResult);
        },
      );
    },
  );
}
