import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class DioProvider {
  static const dioInstance = 'DioInstance';
  static Dio create({
    required String gitHubApiUrl,
    required PrettyDioLogger prettyDioLogger,
  }) {
    return Dio()
      ..options.baseUrl = gitHubApiUrl
      ..options.responseType = ResponseType.json
      ..interceptors.add(prettyDioLogger)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers.addAll(
              {
                'Accept': 'application/vnd.github.v3+json',
                'User-Agent': 'GitHub Repos Searcher',
              },
            );
            handler.next(options);
          },
        ),
      );
  }
}
