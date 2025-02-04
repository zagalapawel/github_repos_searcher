import 'package:domain/model/get_repos_response.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/get_repos_request.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/api/repos_rest_api.dart';
import 'package:remote/data_source_action/get_repos_remote_source_action_impl.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/get_repos_request_remote_model.dart';
import 'package:remote/models/get_repos_response_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';
import 'package:test/test.dart';

class MockReposRestApi extends Mock implements ReposRestApi {}

class MockErrorConverter extends Mock implements ErrorConverter {}

class MockToRemoteMapper extends Mock implements Mapper<GetReposRequest, GetReposRequestRemoteModel> {}

class MockToDomainMapper extends Mock implements Mapper<GetReposResponseRemoteModel, GetReposResponse> {}

class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  group(
    'GetReposRemoteSourceActionImpl',
    () {
      const fallbackGetReposRequest = GetReposRequest(
        pageNumber: 0,
        queryText: '',
        pageSize: 10,
      );

      const fallbackGetReposRequestRemoteModel = GetReposRequestRemoteModel(
        pageNumber: 0,
        queryText: '',
        pageSize: 10,
      );

      const fallbackGetReposResponseRemoteModel = GetReposResponseRemoteModel(
        totalCount: 0,
        items: [],
      );

      const fallbackGetReposResponse = GetReposResponse(
        totalCount: 0,
        items: [],
      );

      late MockReposRestApi mockReposRestApi;
      late MockErrorConverter mockErrorConverter;
      late MockToRemoteMapper mockToRemoteMapper;
      late MockToDomainMapper mockToDomainMapper;
      late GetReposRemoteSourceActionImpl getReposRemoteSourceActionImpl;

      setUpAll(
        () {
          registerFallbackValue(fallbackGetReposRequest);
          registerFallbackValue(fallbackGetReposRequestRemoteModel);
          registerFallbackValue(fallbackGetReposResponseRemoteModel);
          registerFallbackValue(fallbackGetReposResponse);
          registerFallbackValue(FakeStackTrace());
        },
      );

      setUp(
        () {
          mockReposRestApi = MockReposRestApi();
          mockErrorConverter = MockErrorConverter();
          mockToRemoteMapper = MockToRemoteMapper();
          mockToDomainMapper = MockToDomainMapper();
          getReposRemoteSourceActionImpl = GetReposRemoteSourceActionImpl(
            reposRestApi: mockReposRestApi,
            errorConverter: mockErrorConverter,
            getReposRequestToRemoteMapper: mockToRemoteMapper,
            getReposResponseToDomainMapper: mockToDomainMapper,
          );
        },
      );

      test(
        'should return ErrorDetail.fatal when an exception occurs',
        () async {
          when(
            () => mockToRemoteMapper.map(any()),
          ).thenReturn(
            fallbackGetReposRequestRemoteModel,
          );
          when(
            () => mockReposRestApi.getRepos(
              fallbackGetReposRequestRemoteModel.queryText,
              fallbackGetReposRequestRemoteModel.pageNumber,
              fallbackGetReposRequestRemoteModel.pageSize,
            ),
          ).thenThrow(
            Exception(),
          );
          when(
            () => mockErrorConverter.handleRemoteError(any(), any()),
          ).thenReturn(
            const ErrorDetail.fatal(),
          );

          final result = await getReposRemoteSourceActionImpl.execute(fallbackGetReposRequest).run();

          result.match(
            (l) => expect(l, const ErrorDetail.fatal()),
            (r) => throw r,
          );
        },
      );

      test(
        'should return a GetReposResponse when there is no error',
        () async {
          when(
            () => mockToRemoteMapper.map(any()),
          ).thenReturn(
            fallbackGetReposRequestRemoteModel,
          );

          when(
            () => mockReposRestApi.getRepos(
              fallbackGetReposRequestRemoteModel.queryText,
              fallbackGetReposRequestRemoteModel.pageNumber,
              fallbackGetReposRequestRemoteModel.pageSize,
            ),
          ).thenAnswer(
            (_) async => fallbackGetReposResponseRemoteModel,
          );

          when(
            () => mockToDomainMapper.map(fallbackGetReposResponseRemoteModel),
          ).thenReturn(
            fallbackGetReposResponse,
          );

          final result = await getReposRemoteSourceActionImpl.execute(fallbackGetReposRequest).run();

          result.match(
            (l) => throw l,
            (r) => expect(r, fallbackGetReposResponse),
          );

          verify(() => mockToRemoteMapper.map(fallbackGetReposRequest)).called(1);
          verifyNoMoreInteractions(mockToRemoteMapper);
          verify(
            () => mockReposRestApi.getRepos(
              fallbackGetReposRequestRemoteModel.queryText,
              fallbackGetReposRequestRemoteModel.pageNumber,
              fallbackGetReposRequestRemoteModel.pageSize,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockReposRestApi);
          verify(() => mockToDomainMapper.map(fallbackGetReposResponseRemoteModel)).called(1);
          verifyNoMoreInteractions(mockToDomainMapper);
        },
      );
    },
  );
}
