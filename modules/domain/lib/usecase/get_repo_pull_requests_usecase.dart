import 'package:domain/data_source_action/get_repo_pull_requests_remote_source_action.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

enum GetRepoPullRequestsFailure { fatal }

class GetRepoPullRequestsUsecase
    implements ParamUseCase<GetRepoPullRequestsFailure, List<RepoPullRequest>, GetRepoPullRequestsRequest> {
  const GetRepoPullRequestsUsecase({
    required GetRepoPullRequestsRemoteSourceAction getRepoPullRequestsRemoteSourceAction,
  }) : _getRepoPullRequestsRemoteSourceAction = getRepoPullRequestsRemoteSourceAction;

  final GetRepoPullRequestsRemoteSourceAction _getRepoPullRequestsRemoteSourceAction;

  @override
  TaskEither<GetRepoPullRequestsFailure, List<RepoPullRequest>> execute({required GetRepoPullRequestsRequest param}) =>
      _getRepoPullRequestsRemoteSourceAction.execute(param).bimap(
            (_) => GetRepoPullRequestsFailure.fatal,
            (r) => r,
          );
}
