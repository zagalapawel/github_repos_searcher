import 'package:domain/data_source_action/get_repo_issues_remote_source_action.dart';
import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repo_issues_request_remote_model.dart';
import 'package:remote/models/repo_issue_remote_model.dart';

import 'package:remote/other/error/error_converter.dart';

class GetRepoIssuesRemoteSourceActionImpl implements GetRepoIssuesRemoteSourceAction {
  const GetRepoIssuesRemoteSourceActionImpl({
    required ReposRestApi reposRestApi,
    required ErrorConverter errorConverter,
    required Mapper<GetRepoIssuesRequest, GetRepoIssuesRequestRemoteModel> getRepoIssuesRequestToRemoteMapper,
    required Mapper<RepoIssueRemoteModel, RepoIssue> repoIssueRemoteToDomainMapper,
  })  : _reposRestApi = reposRestApi,
        _errorConverter = errorConverter,
        _getRepoIssuesRequestToRemoteMapper = getRepoIssuesRequestToRemoteMapper,
        _repoIssueRemoteToDomainMapper = repoIssueRemoteToDomainMapper;

  final ReposRestApi _reposRestApi;
  final ErrorConverter _errorConverter;
  final Mapper<GetRepoIssuesRequest, GetRepoIssuesRequestRemoteModel> _getRepoIssuesRequestToRemoteMapper;
  final Mapper<RepoIssueRemoteModel, RepoIssue> _repoIssueRemoteToDomainMapper;

  @override
  TaskEither<ErrorDetail, List<RepoIssue>> execute(GetRepoIssuesRequest request) {
    return TaskEither.tryCatch(
      () async {
        final remoteRequest = _getRepoIssuesRequestToRemoteMapper.map(request);
        final response = await _reposRestApi.getRepoIssues(
          remoteRequest.owner,
          remoteRequest.repo,
          remoteRequest.state,
          remoteRequest.pageNumber,
          remoteRequest.pageSize,
        );

        return response.map(_repoIssueRemoteToDomainMapper.map).toList();
      },
      _errorConverter.handleRemoteError,
    );
  }
}
