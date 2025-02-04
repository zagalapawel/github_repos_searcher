import 'dart:async';

import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/usecase/get_repo_pull_requests_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';
import 'package:presentation/widgets/my_paged_list.dart';

part 'repo_details_pull_requests_bloc.freezed.dart';
part 'repo_details_pull_requests_event.dart';
part 'repo_details_pull_requests_state.dart';

class RepoDetailsPullRequestsBloc extends Bloc<RepoDetailsPullRequestsEvent, RepoDetailsPullRequestsState> {
  RepoDetailsPullRequestsBloc({
    required RepoDetailsArgument argument,
    required GetRepoPullRequestsUsecase getRepoPullRequestsUsecase,
  })  : _getRepoPullRequestsUsecase = getRepoPullRequestsUsecase,
        super(RepoDetailsPullRequestsState.initial(argument: argument)) {
    on<_OnPullRequestsRequested>(_onPullRequestsRequested);
  }

  final GetRepoPullRequestsUsecase _getRepoPullRequestsUsecase;

  static const _pageSize = 40;

  Future<void> _onPullRequestsRequested(
    _OnPullRequestsRequested event,
    Emitter<RepoDetailsPullRequestsState> emit,
  ) async {
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

    final argument = state.argument;
    final repo = argument.repo;

    final request = GetRepoPullRequestsRequest(
      pageNumber: event.page,
      pageSize: _pageSize,
      owner: repo.owner.login,
      repo: repo.name,
    );

    final newState = await _getRepoPullRequestsUsecase.execute(param: request).match(
      (_) => state.copyWith(type: StateType.error),
      (items) {
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

  @override
  Future<void> close() {
    state.pagingController.dispose();
    return super.close();
  }
}
