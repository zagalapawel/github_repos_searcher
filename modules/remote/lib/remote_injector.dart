import 'package:dio/dio.dart';
import 'package:domain/data_source_action/get_repo_issues_remote_source_action.dart';
import 'package:domain/data_source_action/get_repo_pull_requests_remote_source_action.dart';
import 'package:domain/data_source_action/get_repos_remote_source_action.dart';
import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/model/repo_issue.dart';
import 'package:domain/model/repo_pull_request.dart';
import 'package:domain/model/user.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get_it/get_it.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/data_source_action/get_repo_issues_remote_source_action_impl.dart';
import 'package:remote/data_source_action/get_repo_pull_requests_remote_source_action_impl.dart';
import 'package:remote/data_source_action/get_repos_remote_source_action_impl.dart';
import 'package:remote/dio_provider.dart';
import 'package:remote/mapper/get_repo_issues_request_to_remote_mapper.dart';
import 'package:remote/mapper/get_repo_pull_requests_request_to_remote_mapper.dart';
import 'package:remote/mapper/get_repos_request_to_remote_mapper.dart';
import 'package:remote/mapper/get_repos_response_to_domain_mapper.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/mapper/repo_issue_remote_to_domain_mapper.dart';
import 'package:remote/mapper/repo_pull_request_remote_to_domain_mapper.dart';
import 'package:remote/mapper/user_remote_to_domain_mapper.dart';
import 'package:remote/mapper/repo_remote_to_domain_mapper.dart';
import 'package:remote/models/get_repo_issues_request_remote_model.dart';
import 'package:remote/models/get_repo_pull_requests_request_remote_model.dart';
import 'package:remote/models/get_repos_request_remote_model.dart';
import 'package:remote/models/get_repos_response_remote_model.dart';
import 'package:remote/models/repo_issue_remote_model.dart';
import 'package:remote/models/repo_pull_request_remote_model.dart';
import 'package:remote/models/repo_remote_model.dart';
import 'package:remote/models/user_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

extension RemoteInjector on GetIt {
  void registerRemote({
    required String gitHubApiUrl,
  }) {
    this
      .._registerMappers()
      .._registerApi()
      .._registerRemoteSourceAction()
      ..registerLazySingleton(
        () => PrettyDioLogger(
          canShowLog: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          queryParameters: true,
        ),
      )
      ..registerSingleton(const ErrorConverter())
      ..registerLazySingleton<Dio>(
        () => DioProvider.create(
          gitHubApiUrl: gitHubApiUrl,
          prettyDioLogger: get(),
        ),
      );
  }

  void _registerMappers() {
    this
      ..registerFactory<Mapper<GetReposRequest, GetReposRequestRemoteModel>>(
        () => GetReposRequestToRemoteMapper(),
      )
      ..registerFactory<Mapper<UserRemoteModel, User>>(
        () => const UserRemoteToDomainMapper(),
      )
      ..registerFactory<Mapper<RepoRemoteModel, Repo>>(
        () => RepoRemoteToDomainMapper(
          userToDomainMapper: get(),
        ),
      )
      ..registerFactory<Mapper<GetReposResponseRemoteModel, GetReposResponse>>(
        () => GetReposResponseToDomainMapper(
          repoRemoteToDomainMapper: get(),
        ),
      )
      ..registerFactory<Mapper<GetRepoIssuesRequest, GetRepoIssuesRequestRemoteModel>>(
        () => GetRepoIssuesRequestToRemoteMapper(),
      )
      ..registerFactory<Mapper<RepoIssueRemoteModel, RepoIssue>>(
        () => RepoIssueRemoteToDomainMapper(
          userRemoteToDomainMapper: get(),
        ),
      )
      ..registerFactory<Mapper<GetRepoPullRequestsRequest, GetRepoPullRequestsRequestRemoteModel>>(
        () => GetRepoPullRequestsRequestToRemoteMapper(),
      )
      ..registerFactory<Mapper<RepoPullRequestRemoteModel, RepoPullRequest>>(
        () => RepoPullRequestRemoteToDomainMapper(
          userRemoteToDomainMapper: get(),
        ),
      );
  }

  void _registerApi() {
    registerFactory<ReposRestApi>(
      () => ReposRestApi(
        get(),
      ),
    );
  }

  void _registerRemoteSourceAction() {
    this
      ..registerFactory<GetReposRemoteSourceAction>(
        () => GetReposRemoteSourceActionImpl(
          reposRestApi: get(),
          errorConverter: get(),
          getReposRequestToRemoteMapper: get(),
          getReposResponseToDomainMapper: get(),
        ),
      )
      ..registerFactory<GetRepoIssuesRemoteSourceAction>(
        () => GetRepoIssuesRemoteSourceActionImpl(
          reposRestApi: get(),
          errorConverter: get(),
          getRepoIssuesRequestToRemoteMapper: get(),
          repoIssueRemoteToDomainMapper: get(),
        ),
      )
      ..registerFactory<GetRepoPullRequestsRemoteSourceAction>(
        () => GetRepoPullRequestsRemoteSourceActionImpl(
          reposRestApi: get(),
          errorConverter: get(),
          getRepoPullRequestsRequestToRemoteMapper: get(),
          repoPullRequestRemoteToDomainMapper: get(),
        ),
      );
  }
}
