import 'package:domain/model/repo_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_issues/bloc/repo_details_issues_bloc.dart';
import 'package:presentation/widgets/my_generic_empty_page.dart';
import 'package:presentation/widgets/my_generic_error_page.dart';
import 'package:presentation/widgets/my_list_tile.dart';
import 'package:presentation/widgets/my_paged_list.dart';
import 'package:presentation/widgets/my_text.dart';

class RepoDetailsIssues extends StatelessWidget {
  const RepoDetailsIssues({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepoDetailsIssuesBloc, RepoDetailsIssuesState>(
      buildWhen: (previous, current) =>
          previous.type != current.type || previous.pagingController != current.pagingController,
      builder: (_, state) => Expanded(
        child: state.type.mapOrElse(
          error: () => const MyGenericErrorPage(),
          orElse: () => _IssuesList(state: state),
        ),
      ),
    );
  }
}

class _IssuesList extends StatelessWidget {
  const _IssuesList({
    required this.state,
  });

  final RepoDetailsIssuesState state;

  @override
  Widget build(BuildContext context) {
    return MyPagedList<RepoIssue>(
      pagingController: state.pagingController,
      onLoadMore: (page) => context.read<RepoDetailsIssuesBloc>().add(
            RepoDetailsIssuesEvent.onIssuesRequested(page: page),
          ),
      noItemsFoundIndicatorBuilder: (_) => MyGenericEmptyPage.custom(
        title: context.strings.repoDetailsIssuesEmptyPageTitle,
        description: context.strings.repoDetailsIssuesEmptyPageDescription,
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
