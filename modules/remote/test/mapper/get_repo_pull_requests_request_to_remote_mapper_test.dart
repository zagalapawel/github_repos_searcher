import 'package:domain/model/get_repo_pull_requests_request.dart';
import 'package:domain/model/pull_request_state.dart';
import 'package:remote/mapper/get_repo_pull_requests_request_to_remote_mapper.dart';
import 'package:remote/models/get_repo_pull_requests_request_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'GetRepoPullRequestsRequestToRemoteMapper',
    () {
      late GetRepoPullRequestsRequestToRemoteMapper getRepoPullRequestsRequestToRemoteMapper;

      setUp(
        () => getRepoPullRequestsRequestToRemoteMapper = const GetRepoPullRequestsRequestToRemoteMapper(),
      );

      test(
        'should correctly map request',
        () {
          const request = GetRepoPullRequestsRequest(
            owner: 'owner',
            pageNumber: 1,
            pageSize: 1,
            repo: 'repo',
            state: PullRequestState.open,
          );

          const expectedResult = GetRepoPullRequestsRequestRemoteModel(
            owner: 'owner',
            pageNumber: 1,
            pageSize: 1,
            repo: 'repo',
            state: 'open',
          );

          final result = getRepoPullRequestsRequestToRemoteMapper.map(request);

          expect(result, expectedResult);
        },
      );
    },
  );
}
