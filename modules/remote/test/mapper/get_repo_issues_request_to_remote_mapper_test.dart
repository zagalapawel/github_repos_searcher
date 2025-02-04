import 'package:domain/model/get_repo_issues_request.dart';
import 'package:domain/model/issue_state.dart';
import 'package:remote/mapper/get_repo_issues_request_to_remote_mapper.dart';
import 'package:remote/models/get_repo_issues_request_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'GetRepoIssuesRequestToRemoteMapper',
    () {
      late GetRepoIssuesRequestToRemoteMapper getRepoIssuesRequestToRemoteMapper;

      setUp(
        () => getRepoIssuesRequestToRemoteMapper = const GetRepoIssuesRequestToRemoteMapper(),
      );

      test(
        'should correctly map request',
        () {
          const request = GetRepoIssuesRequest(
            owner: 'owner',
            pageNumber: 1,
            pageSize: 1,
            repo: 'repo',
            state: IssueState.open,
          );

          const expectedResult = GetRepoIssuesRequestRemoteModel(
            owner: 'owner',
            pageNumber: 1,
            pageSize: 1,
            repo: 'repo',
            state: 'open',
          );

          final result = getRepoIssuesRequestToRemoteMapper.map(request);

          expect(result, expectedResult);
        },
      );
    },
  );
}
