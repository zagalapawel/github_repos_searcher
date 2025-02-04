import 'package:domain/model/get_repo_issues_request.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repo_issues_request_remote_model.dart';

class GetRepoIssuesRequestToRemoteMapper implements Mapper<GetRepoIssuesRequest, GetRepoIssuesRequestRemoteModel> {
  const GetRepoIssuesRequestToRemoteMapper();

  @override
  GetRepoIssuesRequestRemoteModel map(GetRepoIssuesRequest request) => GetRepoIssuesRequestRemoteModel(
        owner: request.owner,
        pageNumber: request.pageNumber,
        pageSize: request.pageSize,
        repo: request.repo,
        state: request.state.value,
      );
}
