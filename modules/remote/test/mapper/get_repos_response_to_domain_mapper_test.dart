import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/mapper/get_repos_response_to_domain_mapper.dart';
import 'package:remote/mapper/repo_remote_to_domain_mapper.dart';
import 'package:remote/models/get_repos_response_remote_model.dart';
import 'package:remote/models/repo_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:test/test.dart';

class MockRepoRemoteToDomainMapper extends Mock implements RepoRemoteToDomainMapper {}

void main() {
  group(
    'GetReposResponseToDomainMapper',
    () {
      late GetReposResponseToDomainMapper getReposResponseToDomainMapper;
      late MockRepoRemoteToDomainMapper mockRepoRemoteToDomainMapper;

      setUp(
        () {
          mockRepoRemoteToDomainMapper = MockRepoRemoteToDomainMapper();
          getReposResponseToDomainMapper = GetReposResponseToDomainMapper(
            repoRemoteToDomainMapper: mockRepoRemoteToDomainMapper,
          );
        },
      );

      test(
        'should correctly map response',
        () {
          const repoRemote = RepoRemoteModel(
            id: 1,
            name: 'name',
            owner: UserRemoteModel(
              avatarUrl: 'avatarUrl',
              id: 123,
              login: 'login',
            ),
            topics: ['topic'],
          );
          const response = GetReposResponseRemoteModel(
            totalCount: 1,
            items: [repoRemote],
          );

          const repo = Repo(
            id: 1,
            name: 'name',
            owner: User(
              avatarUrl: 'avatarUrl',
              id: 123,
              login: 'login',
            ),
            topics: ['topic'],
          );
          const expectedResult = GetReposResponse(
            totalCount: 1,
            items: [repo],
          );

          when(
            () => mockRepoRemoteToDomainMapper.map(repoRemote),
          ).thenReturn(repo);

          final result = getReposResponseToDomainMapper.map(response);

          expect(result, expectedResult);
        },
      );
    },
  );
}
