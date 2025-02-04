part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.onReposRequested({@Default(1) int page}) = _OnReposRequested;

  const factory HomeEvent.onSearchChanged({required String value}) = _OnSearchChanged;

  const factory HomeEvent.onSearchCleared() = _OnSearchCleared;
}
