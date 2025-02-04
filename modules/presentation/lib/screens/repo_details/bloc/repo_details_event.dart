part of 'repo_details_bloc.dart';

@freezed
class RepoDetailsEvent with _$RepoDetailsEvent {
  const factory RepoDetailsEvent.onInitiated() = _OnInitiated;

  const factory RepoDetailsEvent.onTabSelected({required DetailsTab selectedTab}) = _OnTabSelected;
}
