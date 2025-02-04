import 'package:domain/model/issue_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repo_issues_request.freezed.dart';

@freezed
class GetRepoIssuesRequest with _$GetRepoIssuesRequest {
  const factory GetRepoIssuesRequest({
    required int pageNumber,
    required int pageSize,
    required String owner,
    required String repo,
    @Default(IssueState.open) state,
  }) = _GetRepoIssuesRequest;
}
