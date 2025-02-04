import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repo_issues_request_remote_model.freezed.dart';
part 'get_repo_issues_request_remote_model.g.dart';

@freezed
class GetRepoIssuesRequestRemoteModel with _$GetRepoIssuesRequestRemoteModel {
  const factory GetRepoIssuesRequestRemoteModel({
    required int pageNumber,
    required int pageSize,
    required String owner,
    required String repo,
    required String state,
  }) = _GetRepoIssuesRequestRemoteModel;

  factory GetRepoIssuesRequestRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$GetRepoIssuesRequestRemoteModelFromJson(json);
}
