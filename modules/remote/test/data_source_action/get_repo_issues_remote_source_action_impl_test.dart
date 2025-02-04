import 'package:domain/model/issue_state.dart';
import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/data_source_action/get_repo_issues_remote_source_action_impl.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repo_issues_request_remote_model.dart';
import 'package:remote/models/repo_issue_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';
import 'package:test/test.dart';

class MockReposRestApi extends Mock implements ReposRestApi {}

class MockErrorConverter extends Mock implements ErrorConverter {}

class MockToRemoteMapper extends Mock implements Mapper<GetRepoIssuesRequest, GetRepoIssuesRequestRemoteModel> {}

class MockToDomainMapper extends Mock implements Mapper<RepoIssueRemoteModel, RepoIssue> {}

class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  group(
    'GetRepoIssuesRemoteSourceActionImpl',
    () {
      const fallbackGetRepoIssuesRequest = GetRepoIssuesRequest(
        owner: 'owner',
        pageNumber: 1,
        pageSize: 1,
        repo: 'repo',
        state: IssueState.open,
      );

      const fallbackGetRepoIssuesRequestRemoteModel = GetRepoIssuesRequestRemoteModel(
        owner: 'owner',
        pageNumber: 1,
        pageSize: 1,
        repo: 'repo',
        state: 'open',
      );

      const fallbackRepoIssueRemoteModel = RepoIssueRemoteModel(
        id: 123,
        title: 'title',
        user: UserRemoteModel(
          id: 2,
          login: 'login',
          avatarUrl: 'avatarUrl',
        ),
      );

      const fallbackRepoIssue = RepoIssue(
        id: 123,
        title: 'title',
        user: User(
          id: 2,
          login: 'login',
          avatarUrl: 'avatarUrl',
        ),
      );

      late MockReposRestApi mockReposRestApi;
      late MockErrorConverter mockErrorConverter;
      late MockToRemoteMapper mockToRemoteMapper;
      late MockToDomainMapper mockToDomainMapper;
      late GetRepoIssuesRemoteSourceActionImpl getRepoIssuesRemoteSourceActionImpl;

      setUpAll(
        () {
          registerFallbackValue(fallbackGetRepoIssuesRequest);
          registerFallbackValue(fallbackGetRepoIssuesRequestRemoteModel);
          registerFallbackValue(fallbackRepoIssueRemoteModel);
          registerFallbackValue(fallbackRepoIssue);
          registerFallbackValue(FakeStackTrace());
        },
      );

      setUp(
        () {
          mockReposRestApi = MockReposRestApi();
          mockErrorConverter = MockErrorConverter();
          mockToRemoteMapper = MockToRemoteMapper();
          mockToDomainMapper = MockToDomainMapper();
          getRepoIssuesRemoteSourceActionImpl = GetRepoIssuesRemoteSourceActionImpl(
            reposRestApi: mockReposRestApi,
            errorConverter: mockErrorConverter,
            getRepoIssuesRequestToRemoteMapper: mockToRemoteMapper,
            repoIssueRemoteToDomainMapper: mockToDomainMapper,
          );
        },
      );

      test(
        'should return ErrorDetail.fatal when an exception occurs',
        () async {
          when(
            () => mockToRemoteMapper.map(any()),
          ).thenReturn(
            fallbackGetRepoIssuesRequestRemoteModel,
          );
          when(
            () => mockReposRestApi.getRepoIssues(
              fallbackGetRepoIssuesRequestRemoteModel.owner,
              fallbackGetRepoIssuesRequestRemoteModel.repo,
              fallbackGetRepoIssuesRequestRemoteModel.state,
              fallbackGetRepoIssuesRequestRemoteModel.pageNumber,
              fallbackGetRepoIssuesRequestRemoteModel.pageSize,
            ),
          ).thenThrow(
            Exception(),
          );
          when(
            () => mockErrorConverter.handleRemoteError(any(), any()),
          ).thenReturn(
            const ErrorDetail.fatal(),
          );

          final result = await getRepoIssuesRemoteSourceActionImpl.execute(fallbackGetRepoIssuesRequest).run();

          result.match(
            (l) => expect(l, const ErrorDetail.fatal()),
            (r) => throw r,
          );
        },
      );

      test(
        'should return a RepoIssue when there is no error',
        () async {
          when(
            () => mockToRemoteMapper.map(any()),
          ).thenReturn(
            fallbackGetRepoIssuesRequestRemoteModel,
          );

          when(
            () => mockReposRestApi.getRepoIssues(
              fallbackGetRepoIssuesRequestRemoteModel.owner,
              fallbackGetRepoIssuesRequestRemoteModel.repo,
              fallbackGetRepoIssuesRequestRemoteModel.state,
              fallbackGetRepoIssuesRequestRemoteModel.pageNumber,
              fallbackGetRepoIssuesRequestRemoteModel.pageSize,
            ),
          ).thenAnswer(
            (_) async => [fallbackRepoIssueRemoteModel],
          );

          when(
            () => mockToDomainMapper.map(fallbackRepoIssueRemoteModel),
          ).thenReturn(
            fallbackRepoIssue,
          );

          final result = await getRepoIssuesRemoteSourceActionImpl.execute(fallbackGetRepoIssuesRequest).run();

          result.match(
            (l) => throw l,
            (r) => expect(r, [fallbackRepoIssue]),
          );

          verify(() => mockToRemoteMapper.map(fallbackGetRepoIssuesRequest)).called(1);
          verifyNoMoreInteractions(mockToRemoteMapper);
          verify(() => mockReposRestApi.getRepoIssues(
                fallbackGetRepoIssuesRequestRemoteModel.owner,
                fallbackGetRepoIssuesRequestRemoteModel.repo,
                fallbackGetRepoIssuesRequestRemoteModel.state,
                fallbackGetRepoIssuesRequestRemoteModel.pageNumber,
                fallbackGetRepoIssuesRequestRemoteModel.pageSize,
              )).called(1);
          verifyNoMoreInteractions(mockReposRestApi);
          verify(() => mockToDomainMapper.map(fallbackRepoIssueRemoteModel)).called(1);
          verifyNoMoreInteractions(mockToDomainMapper);
        },
      );
    },
  );
}
