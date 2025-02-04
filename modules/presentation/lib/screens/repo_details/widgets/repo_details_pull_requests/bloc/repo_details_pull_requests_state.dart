part of 'repo_details_pull_requests_bloc.dart';

@freezed
class RepoDetailsPullRequestsState with _$RepoDetailsPullRequestsState {
  const factory RepoDetailsPullRequestsState({
    required StateType type,
    required RepoDetailsArgument argument,
    required MyPagingController<RepoPullRequest> pagingController,
  }) = _RepoDetailsPullRequestsState;

  factory RepoDetailsPullRequestsState.initial({required RepoDetailsArgument argument}) {
    return RepoDetailsPullRequestsState(
      type: StateType.loading,
      argument: argument,
      pagingController: MyPagingController(),
    );
  }
}
