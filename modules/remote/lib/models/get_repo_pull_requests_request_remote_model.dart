import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repo_pull_requests_request_remote_model.freezed.dart';
part 'get_repo_pull_requests_request_remote_model.g.dart';

@freezed
class GetRepoPullRequestsRequestRemoteModel with _$GetRepoPullRequestsRequestRemoteModel {
  const factory GetRepoPullRequestsRequestRemoteModel({
    required int pageNumber,
    required int pageSize,
    required String owner,
    required String repo,
    required String state,
  }) = _GetRepoPullRequestsRequestRemoteModel;

  factory GetRepoPullRequestsRequestRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$GetRepoPullRequestsRequestRemoteModelFromJson(json);
}
