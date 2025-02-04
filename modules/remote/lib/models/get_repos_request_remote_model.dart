import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repos_request_remote_model.freezed.dart';
part 'get_repos_request_remote_model.g.dart';

@freezed
class GetReposRequestRemoteModel with _$GetReposRequestRemoteModel {
  const factory GetReposRequestRemoteModel({
    required int pageNumber,
    required String queryText,
    required int pageSize,
  }) = _GetReposRequestRemoteModel;

  factory GetReposRequestRemoteModel.fromJson(Map<String, dynamic> json) => _$GetReposRequestRemoteModelFromJson(json);
}
