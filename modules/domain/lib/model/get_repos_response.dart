import 'package:domain/model/repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repos_response.freezed.dart';

@freezed
class GetReposResponse with _$GetReposResponse {
  const factory GetReposResponse({
    required int totalCount,
    required List<Repo> items,
  }) = _GetReposResponse;
}
