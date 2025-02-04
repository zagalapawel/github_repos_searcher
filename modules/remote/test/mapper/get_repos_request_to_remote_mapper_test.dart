import 'package:domain/model/get_repos_request.dart';
import 'package:remote/mapper/get_repos_request_to_remote_mapper.dart';
import 'package:remote/models/get_repos_request_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'GetReposRequestToRemoteMapper',
    () {
      late GetReposRequestToRemoteMapper getReposRequestToRemoteMapper;

      setUp(
        () => getReposRequestToRemoteMapper = const GetReposRequestToRemoteMapper(),
      );

      test(
        'should correctly map request',
        () {
          const request = GetReposRequest(
            pageNumber: 10,
            pageSize: 10,
            queryText: 'queryText',
          );

          const expectedResult = GetReposRequestRemoteModel(
            pageNumber: 10,
            pageSize: 10,
            queryText: 'queryText',
          );

          final result = getReposRequestToRemoteMapper.map(request);

          expect(result, expectedResult);
        },
      );
    },
  );
}
