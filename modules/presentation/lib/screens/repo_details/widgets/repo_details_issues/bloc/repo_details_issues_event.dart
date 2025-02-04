part of 'repo_details_issues_bloc.dart';

@freezed
class RepoDetailsIssuesEvent with _$RepoDetailsIssuesEvent {
  const factory RepoDetailsIssuesEvent.onIssuesRequested({@Default(1) int page}) = _OnIssuesRequested;
}
