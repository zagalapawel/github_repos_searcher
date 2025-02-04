part of 'repo_details_pull_requests_bloc.dart';

@freezed
class RepoDetailsPullRequestsEvent with _$RepoDetailsPullRequestsEvent {
  const factory RepoDetailsPullRequestsEvent.onPullRequestsRequested({@Default(1) int page}) = _OnPullRequestsRequested;
}
