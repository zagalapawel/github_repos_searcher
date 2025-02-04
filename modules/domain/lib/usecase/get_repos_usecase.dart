import 'package:domain/data_source_action/get_repos_remote_source_action.dart';
import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

enum GetReposFailure { fatal }

class GetReposUsecase implements ParamUseCase<GetReposFailure, GetReposResponse, GetReposRequest> {
  const GetReposUsecase({
    required GetReposRemoteSourceAction getReposRemoteSourceAction,
  }) : _getReposRemoteSourceAction = getReposRemoteSourceAction;

  final GetReposRemoteSourceAction _getReposRemoteSourceAction;

  @override
  TaskEither<GetReposFailure, GetReposResponse> execute({required GetReposRequest param}) =>
      _getReposRemoteSourceAction.execute(param).bimap(
            (_) => GetReposFailure.fatal,
            (r) => r,
          );
}
