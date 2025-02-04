import 'package:domain/model/issue_state.dart';
import 'package:test/test.dart';

void main() {
  group(
    'IssueState',
    () {
      test(
        'should return IssueState if known sort type found',
        () async {
          final result = IssueState.fromValue('closed');

          expect(result, IssueState.closed);
        },
      );

      test(
        'should return IssueState.open if unknown sort type found',
        () async {
          final result = IssueState.fromValue('');

          expect(result, IssueState.open);
        },
      );
    },
  );
}
