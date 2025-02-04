import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/mapper/repo_issue_remote_to_domain_mapper.dart';
import 'package:remote/mapper/user_remote_to_domain_mapper.dart';
import 'package:remote/models/repo_issue_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

class MockUserRemoteToDomainMapper extends Mock implements UserRemoteToDomainMapper {}

void main() {
  group(
    'RepoIssueRemoteToDomainMapper',
    () {
      late RepoIssueRemoteToDomainMapper repoIssueRemoteToDomainMapper;
      late MockUserRemoteToDomainMapper mockUserRemoteToDomainMapper;

      setUp(
        () {
          mockUserRemoteToDomainMapper = MockUserRemoteToDomainMapper();
          repoIssueRemoteToDomainMapper = RepoIssueRemoteToDomainMapper(
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
          const remote = RepoIssueRemoteModel(
            id: 123,
            title: 'title',
            user: userRemote,
          );

          const user = User(
            id: 2,
            login: 'login',
            avatarUrl: 'avatarUrl',
          );
          const expectedResult = RepoIssue(
            id: 123,
            title: 'title',
            user: user,
          );

          when(
            () => mockUserRemoteToDomainMapper.map(userRemote),
          ).thenReturn(user);

          final result = repoIssueRemoteToDomainMapper.map(remote);

          expect(result, expectedResult);
        },
      );
    },
  );
}
