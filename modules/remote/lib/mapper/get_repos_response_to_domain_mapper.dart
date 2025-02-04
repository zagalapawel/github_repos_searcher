import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/repo.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repos_response_remote_model.dart';
import 'package:remote/models/repo_remote_model.dart';

class GetReposResponseToDomainMapper implements Mapper<GetReposResponseRemoteModel, GetReposResponse> {
  const GetReposResponseToDomainMapper({
    required Mapper<RepoRemoteModel, Repo> repoRemoteToDomainMapper,
  }) : _repoRemoteToDomainMapper = repoRemoteToDomainMapper;

  final Mapper<RepoRemoteModel, Repo> _repoRemoteToDomainMapper;

  @override
  GetReposResponse map(GetReposResponseRemoteModel element) {
    final items = element.items.map(_repoRemoteToDomainMapper.map).toList();

    return GetReposResponse(
      totalCount: element.totalCount,
      items: items,
    );
  }
}
