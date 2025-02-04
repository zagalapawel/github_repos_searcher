import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';

part 'repo_details_bloc.freezed.dart';
part 'repo_details_event.dart';
part 'repo_details_state.dart';

class RepoDetailsBloc extends Bloc<RepoDetailsEvent, RepoDetailsState> {
  RepoDetailsBloc({
    required RepoDetailsArgument argument,
  }) : super(RepoDetailsState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
    on<_OnTabSelected>(_onTabSelected);
  }

  Future<void> _onInitiated(
    _OnInitiated event,
    Emitter<RepoDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        type: StateType.loaded,
      ),
    );
  }

  Future<void> _onTabSelected(
    _OnTabSelected event,
    Emitter<RepoDetailsState> emit,
  ) async {
    final eventTab = event.selectedTab;

    if (eventTab == state.detailsTab) {
      return;
    }

    emit(
      state.copyWith(
        detailsTab: eventTab,
        type: StateType.loaded,
      ),
    );
  }
}
