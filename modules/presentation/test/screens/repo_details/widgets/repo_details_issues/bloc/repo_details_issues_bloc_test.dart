import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_repo_issues_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_issues/bloc/repo_details_issues_bloc.dart';
import 'package:presentation/widgets/my_paged_list.dart';

class MockGetRepoIssuesUsecase extends Mock implements GetRepoIssuesUsecase {}

void main() {
  group(
    'RepoDetailsIssuesBloc',
    () {
      late MockGetRepoIssuesUsecase mockGetRepoIssuesUsecase;
      late RepoDetailsIssuesBloc bloc;
      late RepoDetailsIssuesState initialState;

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
          mockGetRepoIssuesUsecase = MockGetRepoIssuesUsecase();
          bloc = RepoDetailsIssuesBloc(
            argument: argument,
            getRepoIssuesUsecase: mockGetRepoIssuesUsecase,
          );

          initialState = RepoDetailsIssuesState.initial(argument: argument).copyWith(
            argument: argument,
            pagingController: MyPagingController<RepoIssue>(),
          );
        },
      );

      final firstPageRequest = GetRepoIssuesRequest(
        pageNumber: 1,
        owner: owner.login,
        repo: repo.name,
        pageSize: 40,
      );

      final secondPageRequest = GetRepoIssuesRequest(
        pageNumber: 2,
        owner: owner.login,
        repo: repo.name,
        pageSize: 40,
      );

      final getRepoIssuesResponse = [
        RepoIssue(
            id: 1,
            title: 'title',
            user: User(
              id: 1,
              login: 'login',
              avatarUrl: 'avatarUrl',
            )),
      ];

      final getRepoIssuesResponse2 = List.generate(
        50,
        (index) => RepoIssue(
          id: index,
          title: 'title',
          user: User(
            id: index + 100,
            login: 'login',
            avatarUrl: 'avatarUrl',
          ),
        ),
      );

      blocTest<RepoDetailsIssuesBloc, RepoDetailsIssuesState>(
        'on RepoDetailsIssuesEvent.onIssuesRequested emits update of type and pagingController '
        'when getting repos returns error',
        setUp: () => when(
          () => mockGetRepoIssuesUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.left(GetRepoIssuesFailure.fatal),
        ),
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const RepoDetailsIssuesEvent.onIssuesRequested()),
        expect: () => [
          isA<RepoDetailsIssuesState>()
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
          isA<RepoDetailsIssuesState>()
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

      blocTest<RepoDetailsIssuesBloc, RepoDetailsIssuesState>(
        'on RepoDetailsIssuesEvent.onIssuesRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 1 and list length = 1',
        setUp: () => when(
          () => mockGetRepoIssuesUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.right(getRepoIssuesResponse),
        ),
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const RepoDetailsIssuesEvent.onIssuesRequested()),
        expect: () => [
          isA<RepoDetailsIssuesState>()
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
          isA<RepoDetailsIssuesState>()
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

      blocTest<RepoDetailsIssuesBloc, RepoDetailsIssuesState>(
        'on RepoDetailsIssuesEvent.onIssuesRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 1 and list length = 50',
        setUp: () => when(
          () => mockGetRepoIssuesUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.right(getRepoIssuesResponse2),
        ),
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const RepoDetailsIssuesEvent.onIssuesRequested()),
        expect: () => [
          isA<RepoDetailsIssuesState>()
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
          isA<RepoDetailsIssuesState>()
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

      blocTest<RepoDetailsIssuesBloc, RepoDetailsIssuesState>(
        'on RepoDetailsIssuesEvent.onIssuesRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 2 and list length = 1',
        setUp: () => when(
          () => mockGetRepoIssuesUsecase.execute(param: secondPageRequest),
        ).thenAnswer((_) => TaskEither.right(getRepoIssuesResponse)),
        build: () => bloc,
        seed: () => initialState.copyWith(type: StateType.loaded),
        act: (bloc) => bloc.add(const RepoDetailsIssuesEvent.onIssuesRequested(page: 2)),
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
