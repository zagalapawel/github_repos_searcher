import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remote/models/user_remote_model.dart';

part 'repo_remote_model.freezed.dart';
part 'repo_remote_model.g.dart';

@freezed
class RepoRemoteModel with _$RepoRemoteModel {
  @JsonSerializable(explicitToJson: true)
  const factory RepoRemoteModel({
    required int id,
    required String name,
    required UserRemoteModel owner,
    required List<String> topics,
    String? description,
  }) = _RepoRemoteModel;

  factory RepoRemoteModel.fromJson(Map<String, dynamic> json) => _$RepoRemoteModelFromJson(json);
}
