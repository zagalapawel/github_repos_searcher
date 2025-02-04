import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/user.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/repo_issue_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';

class RepoIssueRemoteToDomainMapper implements Mapper<RepoIssueRemoteModel, RepoIssue> {
  const RepoIssueRemoteToDomainMapper({
    required Mapper<UserRemoteModel, User> userRemoteToDomainMapper,
  }) : _userRemoteToDomainMapper = userRemoteToDomainMapper;

  final Mapper<UserRemoteModel, User> _userRemoteToDomainMapper;

  @override
  RepoIssue map(RepoIssueRemoteModel element) => RepoIssue(
        id: element.id,
        title: element.title,
        user: _userRemoteToDomainMapper.map(element.user),
      );
}
