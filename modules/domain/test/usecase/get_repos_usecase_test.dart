import 'package:domain/data_source_action/get_repos_remote_source_action.dart';
import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/usecase/get_repos_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetReposRemoteSourceAction extends Mock implements GetReposRemoteSourceAction {}

void main() {
  group(
    'GetReposUsecase',
    () {
      const fallbackGetReposRequest = GetReposRequest(
        pageNumber: 0,
        queryText: '',
        pageSize: 1,
      );

      const fallbackGetReposResponse = GetReposResponse(
        totalCount: 0,
        items: [],
      );

      late MockGetReposRemoteSourceAction mockGetReposRemoteSourceAction;
      late GetReposUsecase getReposUsecase;

      setUpAll(
        () {
          registerFallbackValue(fallbackGetReposRequest);
          registerFallbackValue(fallbackGetReposResponse);
        },
      );

      setUp(
        () {
          mockGetReposRemoteSourceAction = MockGetReposRemoteSourceAction();
          getReposUsecase = GetReposUsecase(
            getReposRemoteSourceAction: mockGetReposRemoteSourceAction,
          );
        },
      );

      test(
        'should return fatal failure when responseCode is null',
        () async {
          when(
            () => mockGetReposRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.left(const ErrorDetail.backend()),
          );

          final result = await getReposUsecase.execute(param: fallbackGetReposRequest).run();

          result.match(
            (l) => expect(l, GetReposFailure.fatal),
            (r) => throw r,
          );
        },
      );

      test(
        'should return fatal failure when underlying action returns fatal',
        () async {
          when(
            () => mockGetReposRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.left(const ErrorDetail.fatal()),
          );

          final result = await getReposUsecase.execute(param: fallbackGetReposRequest).run();

          result.match(
            (l) => expect(l, GetReposFailure.fatal),
            (r) => throw r,
          );
        },
      );

      test(
        'should return right when underlying action returns right',
        () async {
          when(
            () => mockGetReposRemoteSourceAction.execute(any()),
          ).thenReturn(
            TaskEither.right(fallbackGetReposResponse),
          );

          final result = await getReposUsecase.execute(param: fallbackGetReposRequest).run();

          result.match(
            (l) => throw l,
            (r) => expect(r, fallbackGetReposResponse),
          );
        },
      );
    },
  );
}
