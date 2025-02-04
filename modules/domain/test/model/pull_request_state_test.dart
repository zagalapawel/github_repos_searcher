import 'package:domain/model/pull_request_state.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PullRequestState',
    () {
      test(
        'should return PullRequestState if known sort type found',
        () async {
          final result = PullRequestState.fromValue('closed');

          expect(result, PullRequestState.closed);
        },
      );

      test(
        'should return PullRequestState.open if unknown sort type found',
        () async {
          final result = PullRequestState.fromValue('');

          expect(result, PullRequestState.open);
        },
      );
    },
  );
}
