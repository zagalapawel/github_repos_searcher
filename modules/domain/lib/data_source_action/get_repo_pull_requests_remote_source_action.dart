import 'package:domain/model/error_detail.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetRepoPullRequestsRemoteSourceAction {
  TaskEither<ErrorDetail, List<RepoPullRequest>> execute(GetRepoPullRequestsRequest request);
}
