import 'package:domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_pull_request.freezed.dart';

@freezed
class RepoPullRequest with _$RepoPullRequest {
  const factory RepoPullRequest({
    required int id,
    required String title,
    required User user,
  }) = _RepoPullRequest;
}
