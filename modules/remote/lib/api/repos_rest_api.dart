import 'package:dio/dio.dart' hide Headers;
import 'package:remote/models/get_repos_response_remote_model.dart';
import 'package:remote/models/repo_issue_remote_model.dart';
import 'package:remote/models/repo_pull_request_remote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'repos_rest_api.g.dart';

@RestApi()
abstract class ReposRestApi {
  factory ReposRestApi(Dio dio) = _ReposRestApi;

  @GET('/search/repositories')
  Future<GetReposResponseRemoteModel> getRepos(
    @Query('q') String queryText,
    @Query('page') int page,
    @Query('per_page') int pageSize,
  );

  @GET('/repos/{owner}/{repo}/issues')
  Future<List<RepoIssueRemoteModel>> getRepoIssues(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Query('state') String state,
    @Query('page') int page,
    @Query('per_page') int pageSize,
  );

  @GET('/repos/{owner}/{repo}/pulls')
  Future<List<RepoPullRequestRemoteModel>> getRepoPullRequests(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Query('state') String state,
    @Query('page') int page,
    @Query('per_page') int pageSize,
  );
}
