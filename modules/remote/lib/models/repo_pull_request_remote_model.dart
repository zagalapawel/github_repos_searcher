import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remote/models/user_remote_model.dart';

part 'repo_pull_request_remote_model.freezed.dart';
part 'repo_pull_request_remote_model.g.dart';

@freezed
class RepoPullRequestRemoteModel with _$RepoPullRequestRemoteModel {
  @JsonSerializable(explicitToJson: true)
  const factory RepoPullRequestRemoteModel({
    required int id,
    required String title,
    required UserRemoteModel user,
  }) = _RepoPullRequestRemoteModel;

  factory RepoPullRequestRemoteModel.fromJson(Map<String, dynamic> json) => _$RepoPullRequestRemoteModelFromJson(json);
}
