import 'package:domain/domain_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/screens/repo_details/bloc/repo_details_bloc.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_issues/bloc/repo_details_issues_bloc.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_pull_requests/bloc/repo_details_pull_requests_bloc.dart';
import 'package:remote/remote_injector.dart';

final injector = GetIt.instance;

Future<void> init({
  required String gitHubApiUrl,
}) async {
  injector
    ..registerDomain()
    ..registerRemote(
      gitHubApiUrl: gitHubApiUrl,
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(
        getReposUsecase: injector.get(),
      ),
    )
    ..registerFactoryParam<RepoDetailsBloc, RepoDetailsArgument, void>(
      (argument, _) => RepoDetailsBloc(
        argument: argument,
      ),
    )
    ..registerFactoryParam<RepoDetailsIssuesBloc, RepoDetailsArgument, void>(
      (argument, _) => RepoDetailsIssuesBloc(
        argument: argument,
        getRepoIssuesUsecase: injector.get(),
      ),
    )
    ..registerFactoryParam<RepoDetailsPullRequestsBloc, RepoDetailsArgument, void>(
      (argument, _) => RepoDetailsPullRequestsBloc(
        argument: argument,
        getRepoPullRequestsUsecase: injector.get(),
      ),
    );
}
