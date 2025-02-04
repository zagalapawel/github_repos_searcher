import 'package:domain/model/pull_request_state.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/data_source_action/get_repo_pull_requests_remote_source_action_impl.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repo_pull_requests_request_remote_model.dart';
import 'package:remote/models/repo_pull_request_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';
import 'package:test/test.dart';

class MockReposRestApi extends Mock implements ReposRestApi {}

class MockErrorConverter extends Mock implements ErrorConverter {}

class MockToRemoteMapper extends Mock
    implements Mapper<GetRepoPullRequestsRequest, GetRepoPullRequestsRequestRemoteModel> {}

class MockToDomainMapper extends Mock implements Mapper<RepoPullRequestRemoteModel, RepoPullRequest> {}

class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  group(
    'GetRepoPullRequestsRemoteSourceActionImpl',
    () {
      const fallbackGetRepoPullRequestsRequest = GetRepoPullRequestsRequest(
        owner: 'owner',
        pageNumber: 1,
        pageSize: 1,
        repo: 'repo',
        state: PullRequestState.open,
      );

      const fallbackGetRepoPullRequestsRequestRemoteModel = GetRepoPullRequestsRequestRemoteModel(
        owner: 'owner',
        pageNumber: 1,
        pageSize: 1,
        repo: 'repo',
        state: 'open',
      );

      const fallbackRepoPullRequestRemoteModel = RepoPullRequestRemoteModel(
        id: 123,
        title: 'title',
        user: UserRemoteModel(
          id: 2,
          login: 'login',
          avatarUrl: 'avatarUrl',
        ),
      );

      const fallbackRepoPullRequest = RepoPullRequest(
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
      late GetRepoPullRequestsRemoteSourceActionImpl getRepoPullRequestsRemoteSourceActionImpl;

      setUpAll(
        () {
          registerFallbackValue(fallbackGetRepoPullRequestsRequest);
          registerFallbackValue(fallbackGetRepoPullRequestsRequestRemoteModel);
          registerFallbackValue(fallbackRepoPullRequestRemoteModel);
          registerFallbackValue(fallbackRepoPullRequest);
          registerFallbackValue(FakeStackTrace());
        },
      );

      setUp(
        () {
          mockReposRestApi = MockReposRestApi();
          mockErrorConverter = MockErrorConverter();
          mockToRemoteMapper = MockToRemoteMapper();
          mockToDomainMapper = MockToDomainMapper();
          getRepoPullRequestsRemoteSourceActionImpl = GetRepoPullRequestsRemoteSourceActionImpl(
            reposRestApi: mockReposRestApi,
            errorConverter: mockErrorConverter,
            getRepoPullRequestsRequestToRemoteMapper: mockToRemoteMapper,
            repoPullRequestRemoteToDomainMapper: mockToDomainMapper,
          );
        },
      );

      test(
        'should return ErrorDetail.fatal when an exception occurs',
        () async {
          when(
            () => mockToRemoteMapper.map(any()),
          ).thenReturn(
            fallbackGetRepoPullRequestsRequestRemoteModel,
          );
          when(
            () => mockReposRestApi.getRepoPullRequests(
              fallbackGetRepoPullRequestsRequestRemoteModel.owner,
              fallbackGetRepoPullRequestsRequestRemoteModel.repo,
              fallbackGetRepoPullRequestsRequestRemoteModel.state,
              fallbackGetRepoPullRequestsRequestRemoteModel.pageNumber,
              fallbackGetRepoPullRequestsRequestRemoteModel.pageSize,
            ),
          ).thenThrow(
            Exception(),
          );
          when(
            () => mockErrorConverter.handleRemoteError(any(), any()),
          ).thenReturn(
            const ErrorDetail.fatal(),
          );

          final result =
              await getRepoPullRequestsRemoteSourceActionImpl.execute(fallbackGetRepoPullRequestsRequest).run();

          result.match(
            (l) => expect(l, const ErrorDetail.fatal()),
            (r) => throw r,
          );
        },
      );

      test(
        'should return a RepoPullRequest when there is no error',
        () async {
          when(
            () => mockToRemoteMapper.map(any()),
          ).thenReturn(
            fallbackGetRepoPullRequestsRequestRemoteModel,
          );

          when(
            () => mockReposRestApi.getRepoPullRequests(
              fallbackGetRepoPullRequestsRequestRemoteModel.owner,
              fallbackGetRepoPullRequestsRequestRemoteModel.repo,
              fallbackGetRepoPullRequestsRequestRemoteModel.state,
              fallbackGetRepoPullRequestsRequestRemoteModel.pageNumber,
              fallbackGetRepoPullRequestsRequestRemoteModel.pageSize,
            ),
          ).thenAnswer(
            (_) async => [fallbackRepoPullRequestRemoteModel],
          );

          when(
            () => mockToDomainMapper.map(fallbackRepoPullRequestRemoteModel),
          ).thenReturn(
            fallbackRepoPullRequest,
          );

          final result =
              await getRepoPullRequestsRemoteSourceActionImpl.execute(fallbackGetRepoPullRequestsRequest).run();

          result.match(
            (l) => throw l,
            (r) => expect(r, [fallbackRepoPullRequest]),
          );

          verify(() => mockToRemoteMapper.map(fallbackGetRepoPullRequestsRequest)).called(1);
          verifyNoMoreInteractions(mockToRemoteMapper);
          verify(() => mockReposRestApi.getRepoPullRequests(
                fallbackGetRepoPullRequestsRequestRemoteModel.owner,
                fallbackGetRepoPullRequestsRequestRemoteModel.repo,
                fallbackGetRepoPullRequestsRequestRemoteModel.state,
                fallbackGetRepoPullRequestsRequestRemoteModel.pageNumber,
                fallbackGetRepoPullRequestsRequestRemoteModel.pageSize,
              )).called(1);
          verifyNoMoreInteractions(mockReposRestApi);
          verify(() => mockToDomainMapper.map(fallbackRepoPullRequestRemoteModel)).called(1);
          verifyNoMoreInteractions(mockToDomainMapper);
        },
      );
    },
  );
}
