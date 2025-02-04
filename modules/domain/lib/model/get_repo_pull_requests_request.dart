import 'package:domain/model/pull_request_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repo_pull_requests_request.freezed.dart';

@freezed
class GetRepoPullRequestsRequest with _$GetRepoPullRequestsRequest {
  const factory GetRepoPullRequestsRequest({
    required int pageNumber,
    required int pageSize,
    required String owner,
    required String repo,
    @Default(PullRequestState.open) state,
  }) = _GetRepoPullRequestsRequest;
}
