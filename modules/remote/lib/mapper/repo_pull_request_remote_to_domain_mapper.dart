import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/model/user.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/repo_pull_request_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';

class RepoPullRequestRemoteToDomainMapper implements Mapper<RepoPullRequestRemoteModel, RepoPullRequest> {
  const RepoPullRequestRemoteToDomainMapper({
    required Mapper<UserRemoteModel, User> userRemoteToDomainMapper,
  }) : _userRemoteToDomainMapper = userRemoteToDomainMapper;

  final Mapper<UserRemoteModel, User> _userRemoteToDomainMapper;

  @override
  RepoPullRequest map(RepoPullRequestRemoteModel element) => RepoPullRequest(
        id: element.id,
        title: element.title,
        user: _userRemoteToDomainMapper.map(element.user),
      );
}
