import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_repos_request.freezed.dart';

@freezed
class GetReposRequest with _$GetReposRequest {
  const factory GetReposRequest({
    required int pageNumber,
    required String queryText,
    required int pageSize,
  }) = _GetReposRequest;
}
