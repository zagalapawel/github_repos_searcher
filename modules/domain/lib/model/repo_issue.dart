import 'package:domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_issue.freezed.dart';

@freezed
class RepoIssue with _$RepoIssue {
  const factory RepoIssue({
    required int id,
    required String title,
    required User user,
  }) = _RepoIssue;
}
