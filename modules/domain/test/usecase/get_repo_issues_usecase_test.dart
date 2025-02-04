import 'package:domain/data_source_action/get_repo_issues_remote_source_action.dart';
import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_repo_issues_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetRepoIssuesRemoteSourceAction extends Mock implements GetRepoIssuesRemoteSourceAction {}

void main() {
  group(
    'GetRepoIssuesUsecase',
    () {
      const fallbackGetRepoIssuesRequest = GetRepoIssuesRequest(
        owner: '',
        pageNumber: 0,
        pageSize: 0,
        repo: '',
      );

      const fallbackRepoIssue = RepoIssue(
        id: 0,
        title: 'title',
        user: User(
          id: 1,
          login: 'login',
          avatarUrl: 'avatarUrl',
        ),
      );

      late MockGetRepoIssuesRemoteSourceAction mockGetRepoIssuesRemoteSourceAction;
      late GetRepoIssuesUsecase getRepoIssuesUsecase;

      setUpAll(
        () {
          registerFallbackValue(fallbackGetRepoIssuesRequest);
          registerFallbackValue(fallbackRepoIssue);
        },
      );

      setUp(
        () {
          mockGetRepoIssuesRemoteSourceAction = MockGetRepoIssuesRemoteSourceAction();
          getRepoIssuesUsecase = GetRepoIssuesUsecase(
            getRepoIssuesRemoteSourceAction: mockGetRepoIssuesRemoteSourceAction,
          );
        },
      );

      test(
        'should return fatal failure when responseCode is null',
        () async {
          when(
            () => mockGetRepoIssuesRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.left(const ErrorDetail.backend()),
          );

          final result = await getRepoIssuesUsecase.execute(param: fallbackGetRepoIssuesRequest).run();

          result.match(
            (l) => expect(l, GetRepoIssuesFailure.fatal),
            (r) => throw r,
          );
        },
      );

      test(
        'should return fatal failure when underlying action returns fatal',
        () async {
          when(
            () => mockGetRepoIssuesRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.left(const ErrorDetail.fatal()),
          );

          final result = await getRepoIssuesUsecase.execute(param: fallbackGetRepoIssuesRequest).run();

          result.match(
            (l) => expect(l, GetRepoIssuesFailure.fatal),
            (r) => throw r,
          );
        },
      );

      test(
        'should return right when underlying action returns right',
        () async {
          when(
            () => mockGetRepoIssuesRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.right([fallbackRepoIssue]),
          );

          final result = await getRepoIssuesUsecase.execute(param: fallbackGetRepoIssuesRequest).run();

          result.match(
            (l) => throw l,
            (r) => expect(r, [fallbackRepoIssue]),
          );
        },
      );
    },
  );
}
