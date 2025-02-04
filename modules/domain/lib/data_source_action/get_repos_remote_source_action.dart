import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:domain/model/error_detail.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetReposRemoteSourceAction {
  TaskEither<ErrorDetail, GetReposResponse> execute(GetReposRequest request);
}
