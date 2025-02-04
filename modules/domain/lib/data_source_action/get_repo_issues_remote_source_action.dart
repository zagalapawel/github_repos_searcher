import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetRepoIssuesRemoteSourceAction {
  TaskEither<ErrorDetail, List<RepoIssue>> execute(GetRepoIssuesRequest request);
}
