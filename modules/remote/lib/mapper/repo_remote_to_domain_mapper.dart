import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/repo_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';

class RepoRemoteToDomainMapper implements Mapper<RepoRemoteModel, Repo> {
  const RepoRemoteToDomainMapper({
    required Mapper<UserRemoteModel, User> userToDomainMapper,
  }) : _userToDomainMapper = userToDomainMapper;

  final Mapper<UserRemoteModel, User> _userToDomainMapper;

  @override
  Repo map(RepoRemoteModel element) => Repo(
        id: element.id,
        name: element.name,
        owner: _userToDomainMapper.map(element.owner),
        description: element.description,
        topics: element.topics,
      );
}
