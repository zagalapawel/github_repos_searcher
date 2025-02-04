import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_repos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/widgets/my_paged_list.dart';

class MockGetReposUsecase extends Mock implements GetReposUsecase {}

void main() {
  group(
    'HomeBloc',
    () {
      late MockGetReposUsecase mockGetReposUsecase;
      late HomeBloc bloc;
      late HomeState initialState;

      setUp(
        () {
          mockGetReposUsecase = MockGetReposUsecase();
          bloc = HomeBloc(
            getReposUsecase: mockGetReposUsecase,
          );

          initialState = HomeState.initial().copyWith(
            pagingController: MyPagingController<Repo>(),
          );
        },
      );

      final firstPageRequest = GetReposRequest(
        pageNumber: 1,
        queryText: 'value',
        pageSize: 40,
      );

      final secondPageRequest = GetReposRequest(
        pageNumber: 2,
        queryText: 'value',
        pageSize: 40,
      );

      final getReposResponse = GetReposResponse(
        totalCount: 1,
        items: [
          Repo(
            id: 1,
            name: 'name',
            owner: User(
              id: 1,
              login: 'login',
              avatarUrl: 'avatarUrl',
            ),
            topics: [],
          ),
        ],
      );

      final getReposResponse2 = GetReposResponse(
        totalCount: 50,
        items: List.generate(
          50,
          (index) => Repo(
            id: index,
            name: 'name',
            owner: User(
              id: index + 100,
              login: 'login',
              avatarUrl: 'avatarUrl',
            ),
            topics: [],
          ),
        ),
      );

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onSeachChanged emits update of type and searchValue',
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const HomeEvent.onSearchChanged(value: 'value')),
        expect: () => [
          initialState.copyWith(
            type: StateType.loaded,
            searchValue: 'value',
          )
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onSearchCleared emits update of type, searchValue and pagingController',
        build: () => bloc,
        seed: () => initialState.copyWith(searchValue: 'value'),
        act: (bloc) => bloc.add(const HomeEvent.onSearchCleared()),
        expect: () => [
          isA<HomeState>()
              .having(
                (state) => state.pagingController,
                'pagingController',
                isNotNull,
              )
              .having(
                (state) => state.type,
                'type',
                StateType.loaded,
              )
              .having(
                (state) => state.searchValue,
                'searchValue',
                null,
              ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onReposRequested emits nothing '
        'when searchValue is empty',
        build: () => bloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(const HomeEvent.onReposRequested()),
        expect: () => [],
      );

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onReposRequested emits update of type and pagingController '
        'when getting repos returns error',
        setUp: () => when(
          () => mockGetReposUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.left(GetReposFailure.fatal),
        ),
        build: () => bloc,
        seed: () => initialState.copyWith(searchValue: 'value'),
        act: (bloc) => bloc.add(const HomeEvent.onReposRequested()),
        expect: () => [
          isA<HomeState>()
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
          isA<HomeState>()
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

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onReposRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 1 and list length = 1',
        setUp: () => when(
          () => mockGetReposUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.right(getReposResponse),
        ),
        build: () => bloc,
        seed: () => initialState.copyWith(searchValue: 'value'),
        act: (bloc) => bloc.add(const HomeEvent.onReposRequested()),
        expect: () => [
          isA<HomeState>()
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
          isA<HomeState>()
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

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onReposRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 1 and list length = 50',
        setUp: () => when(
          () => mockGetReposUsecase.execute(param: firstPageRequest),
        ).thenAnswer(
          (_) => TaskEither.right(getReposResponse2),
        ),
        build: () => bloc,
        seed: () => initialState.copyWith(searchValue: 'value'),
        act: (bloc) => bloc.add(const HomeEvent.onReposRequested()),
        expect: () => [
          isA<HomeState>()
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
          isA<HomeState>()
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

      blocTest<HomeBloc, HomeState>(
        'on HomeEvent.onReposRequested emits update of type and pagingController '
        'when getting repos returns no error '
        'and pageNumber = 2 and list length = 1',
        setUp: () => when(
          () => mockGetReposUsecase.execute(param: secondPageRequest),
        ).thenAnswer((_) => TaskEither.right(getReposResponse)),
        build: () => bloc,
        seed: () => initialState.copyWith(searchValue: 'value'),
        act: (bloc) => bloc.add(const HomeEvent.onReposRequested(page: 2)),
        expect: () => [
          initialState.copyWith(
            searchValue: 'value',
            type: StateType.loading,
          ),
          initialState.copyWith(
            searchValue: 'value',
            type: StateType.loaded,
          ),
        ],
      );
    },
  );
}
