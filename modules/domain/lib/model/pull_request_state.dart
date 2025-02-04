enum PullRequestState {
  open('open'),
  closed('closed');

  final String value;

  const PullRequestState(this.value);

  factory PullRequestState.fromValue(String value) => values.firstWhere(
        (e) => e.value == value,
        orElse: () => PullRequestState.open,
      );
}
