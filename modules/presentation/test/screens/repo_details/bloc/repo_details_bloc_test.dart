import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/repo.dart';
import 'package:domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/bloc/repo_details_bloc.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';

void main() {
  group(
    'RepoDetailsBloc',
    () {
      late RepoDetailsBloc bloc;

      final owner = User(
        id: 1,
        login: 'login',
        avatarUrl: 'avatarUrl',
      );

      final repo = Repo(
        id: 1,
        name: 'name',
        owner: owner,
        topics: [],
      );

      final argument = RepoDetailsArgument(
        repo: repo,
      );

      setUp(
        () => bloc = RepoDetailsBloc(
          argument: argument,
        ),
      );

      blocTest<RepoDetailsBloc, RepoDetailsState>(
        'on RepoDetailsEvent.onInitiated emits update of type',
        build: () => bloc,
        act: (bloc) => bloc.add(const RepoDetailsEvent.onInitiated()),
        expect: () => [
          RepoDetailsState.initial(argument: argument).copyWith(
            type: StateType.loaded,
          ),
        ],
      );

      blocTest<RepoDetailsBloc, RepoDetailsState>(
        'on RepoDetailsEvent.onTabSelected emits update of type and detailsTab',
        build: () => bloc,
        act: (bloc) => bloc.add(const RepoDetailsEvent.onTabSelected(selectedTab: DetailsTab.pullRequests)),
        expect: () => [
          RepoDetailsState.initial(argument: argument).copyWith(
            detailsTab: DetailsTab.pullRequests,
            type: StateType.loaded,
          ),
        ],
      );

      blocTest<RepoDetailsBloc, RepoDetailsState>(
        'on RepoDetailsEvent.onTabSelected emits nothing '
        'when tab is already selected',
        build: () => bloc,
        seed: () => RepoDetailsState.initial(argument: argument).copyWith(
          type: StateType.loaded,
          detailsTab: DetailsTab.pullRequests,
        ),
        act: (bloc) => bloc.add(const RepoDetailsEvent.onTabSelected(selectedTab: DetailsTab.pullRequests)),
        expect: () => [],
      );
    },
  );
}
