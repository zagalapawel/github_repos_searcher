import 'package:domain/data_source_action/get_repo_issues_remote_source_action.dart';
import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

enum GetRepoIssuesFailure { fatal }

class GetRepoIssuesUsecase implements ParamUseCase<GetRepoIssuesFailure, List<RepoIssue>, GetRepoIssuesRequest> {
  const GetRepoIssuesUsecase({
    required GetRepoIssuesRemoteSourceAction getRepoIssuesRemoteSourceAction,
  }) : _getRepoIssuesRemoteSourceAction = getRepoIssuesRemoteSourceAction;

  final GetRepoIssuesRemoteSourceAction _getRepoIssuesRemoteSourceAction;

  @override
  TaskEither<GetRepoIssuesFailure, List<RepoIssue>> execute({required GetRepoIssuesRequest param}) =>
      _getRepoIssuesRemoteSourceAction.execute(param).bimap(
            (_) => GetRepoIssuesFailure.fatal,
            (r) => r,
          );
}
