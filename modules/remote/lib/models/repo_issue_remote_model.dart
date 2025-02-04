import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remote/models/user_remote_model.dart';

part 'repo_issue_remote_model.freezed.dart';
part 'repo_issue_remote_model.g.dart';

@freezed
class RepoIssueRemoteModel with _$RepoIssueRemoteModel {
  @JsonSerializable(explicitToJson: true)
  const factory RepoIssueRemoteModel({
    required int id,
    required String title,
    required UserRemoteModel user,
  }) = _RepoIssueRemoteModel;

  factory RepoIssueRemoteModel.fromJson(Map<String, dynamic> json) => _$RepoIssueRemoteModelFromJson(json);
}
