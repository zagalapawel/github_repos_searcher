import 'package:domain/data_source_action/get_repos_remote_source_action.dart';
import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repos_request_remote_model.dart';
import 'package:remote/models/get_repos_response_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

class GetReposRemoteSourceActionImpl implements GetReposRemoteSourceAction {
  const GetReposRemoteSourceActionImpl({
    required ReposRestApi reposRestApi,
    required ErrorConverter errorConverter,
    required Mapper<GetReposRequest, GetReposRequestRemoteModel> getReposRequestToRemoteMapper,
    required Mapper<GetReposResponseRemoteModel, GetReposResponse> getReposResponseToDomainMapper,
  })  : _reposRestApi = reposRestApi,
        _errorConverter = errorConverter,
        _getReposRequestToRemoteMapper = getReposRequestToRemoteMapper,
        _getReposResponseToDomainMapper = getReposResponseToDomainMapper;

  final ReposRestApi _reposRestApi;
  final ErrorConverter _errorConverter;
  final Mapper<GetReposRequest, GetReposRequestRemoteModel> _getReposRequestToRemoteMapper;
  final Mapper<GetReposResponseRemoteModel, GetReposResponse> _getReposResponseToDomainMapper;

  @override
  TaskEither<ErrorDetail, GetReposResponse> execute(GetReposRequest request) {
    return TaskEither.tryCatch(
      () async {
        final remoteRequest = _getReposRequestToRemoteMapper.map(request);
        final response = await _reposRestApi.getRepos(
          remoteRequest.queryText,
          remoteRequest.pageNumber,
          request.pageSize,
        );
        return _getReposResponseToDomainMapper.map(response);
      },
      _errorConverter.handleRemoteError,
    );
  }
}
