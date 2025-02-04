import 'package:domain/data_source_action/get_repo_pull_requests_remote_source_action.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_repo_pull_requests_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetRepoPullRequestsRemoteSourceAction extends Mock implements GetRepoPullRequestsRemoteSourceAction {}

void main() {
  group(
    'GetRepoPullRequestsUsecase',
    () {
      const fallbackGetRepoPullRequestsRequest = GetRepoPullRequestsRequest(
        owner: '',
        pageNumber: 0,
        pageSize: 0,
        repo: '',
      );

      const fallbackRepoPullRequest = RepoPullRequest(
        id: 0,
        title: 'title',
        user: User(
          id: 1,
          login: 'login',
          avatarUrl: 'avatarUrl',
        ),
      );

      late MockGetRepoPullRequestsRemoteSourceAction mockGetRepoPullRequestsRemoteSourceAction;
      late GetRepoPullRequestsUsecase getRepoPullRequestsUsecase;

      setUpAll(
        () {
          registerFallbackValue(fallbackGetRepoPullRequestsRequest);
          registerFallbackValue(fallbackRepoPullRequest);
        },
      );

      setUp(
        () {
          mockGetRepoPullRequestsRemoteSourceAction = MockGetRepoPullRequestsRemoteSourceAction();
          getRepoPullRequestsUsecase = GetRepoPullRequestsUsecase(
            getRepoPullRequestsRemoteSourceAction: mockGetRepoPullRequestsRemoteSourceAction,
          );
        },
      );

      test(
        'should return fatal failure when responseCode is null',
        () async {
          when(
            () => mockGetRepoPullRequestsRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.left(const ErrorDetail.backend()),
          );

          final result = await getRepoPullRequestsUsecase.execute(param: fallbackGetRepoPullRequestsRequest).run();

          result.match(
            (l) => expect(l, GetRepoPullRequestsFailure.fatal),
            (r) => throw r,
          );
        },
      );

      test(
        'should return fatal failure when underlying action returns fatal',
        () async {
          when(
            () => mockGetRepoPullRequestsRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.left(const ErrorDetail.fatal()),
          );

          final result = await getRepoPullRequestsUsecase.execute(param: fallbackGetRepoPullRequestsRequest).run();

          result.match(
            (l) => expect(l, GetRepoPullRequestsFailure.fatal),
            (r) => throw r,
          );
        },
      );

      test(
        'should return right when underlying action returns right',
        () async {
          when(
            () => mockGetRepoPullRequestsRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.right([fallbackRepoPullRequest]),
          );

          final result = await getRepoPullRequestsUsecase.execute(param: fallbackGetRepoPullRequestsRequest).run();

          result.match(
            (l) => throw l,
            (r) => expect(r, [fallbackRepoPullRequest]),
          );
        },
      );
    },
  );
}
