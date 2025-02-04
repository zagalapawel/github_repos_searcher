import 'package:domain/usecase/get_repo_issues_usecase.dart';
import 'package:domain/usecase/get_repo_pull_requests_usecase.dart';
import 'package:domain/usecase/get_repos_usecase.dart';
import 'package:get_it/get_it.dart';

extension DomainInjector on GetIt {
  void registerDomain() {
    this
      ..registerFactory<GetReposUsecase>(
        () => GetReposUsecase(
          getReposRemoteSourceAction: get(),
        ),
      )
      ..registerFactory<GetRepoIssuesUsecase>(
        () => GetRepoIssuesUsecase(
          getRepoIssuesRemoteSourceAction: get(),
        ),
      )
      ..registerFactory<GetRepoPullRequestsUsecase>(
        () => GetRepoPullRequestsUsecase(
          getRepoPullRequestsRemoteSourceAction: get(),
        ),
      );
  }
}
