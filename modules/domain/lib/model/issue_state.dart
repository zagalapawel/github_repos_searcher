enum IssueState {
  open('open'),
  closed('closed');

  final String value;

  const IssueState(this.value);

  factory IssueState.fromValue(String value) => values.firstWhere(
        (e) => e.value == value,
        orElse: () => IssueState.open,
      );
}
