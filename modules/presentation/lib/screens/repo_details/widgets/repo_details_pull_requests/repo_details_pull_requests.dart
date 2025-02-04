import 'package:domain/model/repo_pull_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_pull_requests/bloc/repo_details_pull_requests_bloc.dart';
import 'package:presentation/widgets/my_generic_empty_page.dart';
import 'package:presentation/widgets/my_generic_error_page.dart';
import 'package:presentation/widgets/my_list_tile.dart';
import 'package:presentation/widgets/my_paged_list.dart';
import 'package:presentation/widgets/my_text.dart';

class RepoDetailsPullRequests extends StatelessWidget {
  const RepoDetailsPullRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepoDetailsPullRequestsBloc, RepoDetailsPullRequestsState>(
      buildWhen: (previous, current) =>
          previous.type != current.type || previous.pagingController != current.pagingController,
      builder: (_, state) => Expanded(
        child: state.type.mapOrElse(
          error: () => const MyGenericErrorPage(),
          orElse: () => _PullRequestsList(state: state),
        ),
      ),
    );
  }
}

class _PullRequestsList extends StatelessWidget {
  const _PullRequestsList({
    required this.state,
  });

  final RepoDetailsPullRequestsState state;

  @override
  Widget build(BuildContext context) {
    return MyPagedList<RepoPullRequest>(
      pagingController: state.pagingController,
      onLoadMore: (page) => context.read<RepoDetailsPullRequestsBloc>().add(
            RepoDetailsPullRequestsEvent.onPullRequestsRequested(page: page),
          ),
      noItemsFoundIndicatorBuilder: (_) => MyGenericEmptyPage.custom(
        title: context.strings.repoDetailsPullRequestsEmptyPageTitle,
        description: context.strings.repoDetailsPullRequestsEmptyPageDescription,
      ),
      padding: EdgeInsets.symmetric(vertical: Insets.xLarge),
      itemBuilder: (_, item, __) => MyListTile(
        title: item.title,
        titleMaxLines: 5,
        footer: MyText(
          item.user.login,
        ),
      ),
    );
  }
}
