part of 'repo_details_bloc.dart';

@freezed
class RepoDetailsState with _$RepoDetailsState {
  const factory RepoDetailsState({
    required StateType type,
    required RepoDetailsArgument argument,
    required DetailsTab detailsTab,
  }) = _RepoDetailsState;

  factory RepoDetailsState.initial({required RepoDetailsArgument argument}) {
    return RepoDetailsState(
      type: StateType.initial,
      argument: argument,
      detailsTab: DetailsTab.issues,
    );
  }
}

enum DetailsTab { issues, pullRequests }
