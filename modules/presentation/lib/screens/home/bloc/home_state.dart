part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required StateType type,
    required MyPagingController<Repo> pagingController,
    String? searchValue,
  }) = _HomeState;

  factory HomeState.initial() {
    return HomeState(
      type: StateType.initial,
      pagingController: MyPagingController(),
    );
  }
}
