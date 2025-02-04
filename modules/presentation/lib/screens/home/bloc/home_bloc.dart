import 'package:domain/model/get_repos_request.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/usecase/get_repos_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/widgets/my_paged_list.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetReposUsecase getReposUsecase,
  })  : _getReposUsecase = getReposUsecase,
        super(HomeState.initial()) {
    on<_OnReposRequested>(_onReposRequested);
    on<_OnSearchChanged>(_onSearchChanged);
    on<_OnSearchCleared>(_onSearchCleared);
  }

  final GetReposUsecase _getReposUsecase;

  static const _pageSize = 40;

  Future<void> _onReposRequested(
    _OnReposRequested event,
    Emitter<HomeState> emit,
  ) async {
    final searchValue = state.searchValue ?? '';
    if (searchValue.isEmpty) {
      return;
    }

    final isFirstPage = event.page == 1;
    if (isFirstPage) {
      emit(
        state.copyWith(
          pagingController: MyPagingController()..refresh(),
          type: StateType.loading,
        ),
      );
    } else {
      emit(
        state.copyWith(
          type: StateType.loading,
        ),
      );
    }

    final request = GetReposRequest(
      pageNumber: event.page,
      queryText: searchValue,
      pageSize: _pageSize,
    );

    final newState = await _getReposUsecase.execute(param: request).match(
      (_) => state.copyWith(type: StateType.error),
      (result) {
        final items = result.items;
        if (items.length < _pageSize) {
          state.pagingController.appendLastPage(items);
        } else {
          state.pagingController.appendPage(items, event.page + 1);
        }
        return state.copyWith(
          type: StateType.loaded,
        );
      },
    ).run();

    emit(newState);
  }

  Future<void> _onSearchChanged(
    _OnSearchChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        type: StateType.loaded,
        searchValue: event.value,
      ),
    );
  }

  Future<void> _onSearchCleared(
    _OnSearchCleared event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        type: StateType.loaded,
        searchValue: null,
        pagingController: MyPagingController(),
      ),
    );
  }

  @override
  Future<void> close() {
    state.pagingController.dispose();
    return super.close();
  }
}
