import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/model/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/mapper/repo_pull_request_remote_to_domain_mapper.dart';
import 'package:remote/mapper/user_remote_to_domain_mapper.dart';
import 'package:remote/models/repo_pull_request_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

class MockUserRemoteToDomainMapper extends Mock implements UserRemoteToDomainMapper {}

void main() {
  group(
    'RepoPullRequestRemoteToDomainMapper',
    () {
      late RepoPullRequestRemoteToDomainMapper repoPullRequestRemoteToDomainMapper;
      late MockUserRemoteToDomainMapper mockUserRemoteToDomainMapper;

      setUp(
        () {
          mockUserRemoteToDomainMapper = MockUserRemoteToDomainMapper();
          repoPullRequestRemoteToDomainMapper = RepoPullRequestRemoteToDomainMapper(
            userRemoteToDomainMapper: mockUserRemoteToDomainMapper,
          );
        },
      );

      test(
        'should correctly map remote',
        () {
          const userRemote = UserRemoteModel(
            id: 2,
            login: 'login',
            avatarUrl: 'avatarUrl',
          );
          const remote = RepoPullRequestRemoteModel(
            id: 123,
            title: 'title',
            user: userRemote,
          );

          const user = User(
            id: 2,
            login: 'login',
            avatarUrl: 'avatarUrl',
          );
          const expectedResult = RepoPullRequest(
            id: 123,
            title: 'title',
            user: user,
          );

          when(
            () => mockUserRemoteToDomainMapper.map(userRemote),
          ).thenReturn(user);

          final result = repoPullRequestRemoteToDomainMapper.map(remote);

          expect(result, expectedResult);
        },
      );
    },
  );
}
