import 'package:domain/data_source_action/get_repo_pull_requests_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repo_pull_requests_request_remote_model.dart';
import 'package:remote/models/repo_pull_request_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

class GetRepoPullRequestsRemoteSourceActionImpl implements GetRepoPullRequestsRemoteSourceAction {
  const GetRepoPullRequestsRemoteSourceActionImpl({
    required ReposRestApi reposRestApi,
    required ErrorConverter errorConverter,
    required Mapper<GetRepoPullRequestsRequest, GetRepoPullRequestsRequestRemoteModel>
        getRepoPullRequestsRequestToRemoteMapper,
    required Mapper<RepoPullRequestRemoteModel, RepoPullRequest> repoPullRequestRemoteToDomainMapper,
  })  : _reposRestApi = reposRestApi,
        _errorConverter = errorConverter,
        _getRepoPullRequestsRequestToRemoteMapper = getRepoPullRequestsRequestToRemoteMapper,
        _repoPullRequestRemoteToDomainMapper = repoPullRequestRemoteToDomainMapper;

  final ReposRestApi _reposRestApi;
  final ErrorConverter _errorConverter;
  final Mapper<GetRepoPullRequestsRequest, GetRepoPullRequestsRequestRemoteModel>
      _getRepoPullRequestsRequestToRemoteMapper;
  final Mapper<RepoPullRequestRemoteModel, RepoPullRequest> _repoPullRequestRemoteToDomainMapper;

  @override
  TaskEither<ErrorDetail, List<RepoPullRequest>> execute(GetRepoPullRequestsRequest request) {
    return TaskEither.tryCatch(
      () async {
        final remoteRequest = _getRepoPullRequestsRequestToRemoteMapper.map(request);
        final response = await _reposRestApi.getRepoPullRequests(
          remoteRequest.owner,
          remoteRequest.repo,
          remoteRequest.state,
          remoteRequest.pageNumber,
          remoteRequest.pageSize,
        );

        return response.map(_repoPullRequestRemoteToDomainMapper.map).toList();
      },
      _errorConverter.handleRemoteError,
    );
  }
}
