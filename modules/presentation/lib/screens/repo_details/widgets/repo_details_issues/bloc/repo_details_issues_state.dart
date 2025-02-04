part of 'repo_details_issues_bloc.dart';

@freezed
class RepoDetailsIssuesState with _$RepoDetailsIssuesState {
  const factory RepoDetailsIssuesState({
    required StateType type,
    required RepoDetailsArgument argument,
    required MyPagingController<RepoIssue> pagingController,
  }) = _RepoDetailsIssuesState;

  factory RepoDetailsIssuesState.initial({required RepoDetailsArgument argument}) {
    return RepoDetailsIssuesState(
      type: StateType.loading,
      argument: argument,
      pagingController: MyPagingController(),
    );
  }
}
