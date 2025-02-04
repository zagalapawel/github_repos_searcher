import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_repo_pull_requests_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_pull_requests/bloc/repo_details_pull_requests_bloc.dart';
import 'package:presentation/widgets/my_paged_list.dart';

class MockGetRepoPullRequestsUsecase extends Mock implements GetRepoPullRequestsUsecase {}

void main() {
  group(
    'RepoDetailsPullRequestsBloc',
    () {
      late MockGetRepoPullRequestsUsecase mockGetRepoPullRequestsUsecase;
      late RepoDetailsPullRequestsBloc bloc;
      late RepoDetailsPullRequestsState initialState;

      final owner = User(
        id: 1,
        login: 'login',
        avatarUrl: 'avatarUrl',
      );

      final repo = Repo(
        id: 1,
        name: 'name',
        owner: owner,
        topics: [],
      );

      final argument = RepoDetailsArgument(
        repo: repo,
      );

      setUp(
        () {
          mockGetRepoPullRequestsUsecase = MockGetRepoPullRequestsUsecase();
          bloc = RepoDetailsPullRequestsBloc(
            argument: argument,
            getRepoPullRequestsUsecase: mockGetRepoPullRequestsUsecase,
          );

          initialState = RepoDetailsPullRequestsState.initial(argument: argument).copyWith(
            argument: argument,
            pagingController: MyPagingController<RepoPullRequest>(),
          );
        },
      );

      final firstPageRequest = GetRepoPullRequestsRequest(
        pageNumber: 1,
        owner: owner.login,
        repo: repo.name,
        pageSize: 40,
      );

      final secondPageRequest = GetRepoPullRequestsRequest(
        pageNumber: 2,
        owner: owner.login,
        repo: repo.name,
        pageSize: 40,
      );

      final getRepoPullRequestsResponse = [
        RepoPullRequest(
            id: 1,
            title: 'title',
            user: User(
              id: 1,
              login: 'login',
              avatarUrl: 'avatarUrl',
            )),
      ];

      final getRepoPullRequestsResponse2 = List.generate(
        50,
        (index) => RepoPullRequest(
          id: index,
          title: 'title',
          user: User(
            id: index + 100,
            login: 'login',
            avatarUrl: 'avatarUrl',
          ),
        ),
      );

      blocTest<RepoDetailsPullRequestsBloc, RepoDetailsPullRequestsState>(
        'on RepoDetailsPullRequestsEvent.onPullRequestsRequested emits update of type and pagingController '
        'when getting repos returns error',
        setUp: () => when(
          () => mockGetRepoPullRequestsUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.left(GetRepoPullRequestsFailure.fatal),
        ),
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const RepoDetailsPullRequestsEvent.onPullRequestsRequested()),
        expect: () => [
          isA<RepoDetailsPullRequestsState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.loading,
              ),
          isA<RepoDetailsPullRequestsState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.error,
              ),
        ],
      );

      blocTest<RepoDetailsPullRequestsBloc, RepoDetailsPullRequestsState>(
        'on RepoDetailsPullRequestsEvent.onPullRequestsRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 1 and list length = 1',
        setUp: () => when(
          () => mockGetRepoPullRequestsUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.right(getRepoPullRequestsResponse),
        ),
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const RepoDetailsPullRequestsEvent.onPullRequestsRequested()),
        expect: () => [
          isA<RepoDetailsPullRequestsState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.loading,
              ),
          isA<RepoDetailsPullRequestsState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.loaded,
              ),
        ],
      );

      blocTest<RepoDetailsPullRequestsBloc, RepoDetailsPullRequestsState>(
        'on RepoDetailsPullRequestsEvent.onPullRequestsRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 1 and list length = 50',
        setUp: () => when(
          () => mockGetRepoPullRequestsUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.right(getRepoPullRequestsResponse2),
        ),
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const RepoDetailsPullRequestsEvent.onPullRequestsRequested()),
        expect: () => [
          isA<RepoDetailsPullRequestsState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.loading,
              ),
          isA<RepoDetailsPullRequestsState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.loaded,
              ),
        ],
      );

      blocTest<RepoDetailsPullRequestsBloc, RepoDetailsPullRequestsState>(
        'on RepoDetailsPullRequestsEvent.onPullRequestsRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 2 and list length = 1',
        setUp: () => when(
          () => mockGetRepoPullRequestsUsecase.execute(param: secondPageRequest),
        ).thenAnswer((_) => TaskEither.right(getRepoPullRequestsResponse)),
        build: () => bloc,
        seed: () => initialState.copyWith(type: StateType.loaded),
        act: (bloc) => bloc.add(const RepoDetailsPullRequestsEvent.onPullRequestsRequested(page: 2)),
        expect: () => [
          initialState.copyWith(
            type: StateType.loading,
          ),
          initialState.copyWith(
            type: StateType.loaded,
          ),
        ],
      );
    },
  );
}
