import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remote/models/repo_remote_model.dart';

part 'get_repos_response_remote_model.freezed.dart';
part 'get_repos_response_remote_model.g.dart';

@freezed
class GetReposResponseRemoteModel with _$GetReposResponseRemoteModel {
  @JsonSerializable(explicitToJson: true)
  const factory GetReposResponseRemoteModel({
    @JsonKey(name: 'total_count') required int totalCount,
    required List<RepoRemoteModel> items,
  }) = _GetReposResponseRemoteModel;

  factory GetReposResponseRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$GetReposResponseRemoteModelFromJson(json);
}
