import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repo_pull_requests_request_remote_model.dart';

class GetRepoPullRequestsRequestToRemoteMapper
    implements Mapper<GetRepoPullRequestsRequest, GetRepoPullRequestsRequestRemoteModel> {
  const GetRepoPullRequestsRequestToRemoteMapper();

  @override
  GetRepoPullRequestsRequestRemoteModel map(GetRepoPullRequestsRequest request) =>
      GetRepoPullRequestsRequestRemoteModel(
        owner: request.owner,
        pageNumber: request.pageNumber,
        pageSize: request.pageSize,
        repo: request.repo,
        state: request.state.value,
      );
}
