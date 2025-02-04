import 'package:domain/model/get_repos_request.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repos_request_remote_model.dart';

class GetReposRequestToRemoteMapper implements Mapper<GetReposRequest, GetReposRequestRemoteModel> {
  const GetReposRequestToRemoteMapper();

  @override
  GetReposRequestRemoteModel map(GetReposRequest request) => GetReposRequestRemoteModel(
        pageNumber: request.pageNumber,
        queryText: request.queryText,
        pageSize: request.pageSize,
      );
}
