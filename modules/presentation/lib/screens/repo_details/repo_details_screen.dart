import 'package:domain/model/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/extensions/column_padded_extension.dart';
import 'package:presentation/screens/repo_details/bloc/repo_details_bloc.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_issues/bloc/repo_details_issues_bloc.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_issues/repo_details_issues.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_pull_requests/bloc/repo_details_pull_requests_bloc.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_pull_requests/repo_details_pull_requests.dart';
import 'package:presentation/widgets/my_app_bar.dart';
import 'package:presentation/widgets/my_button.dart';
import 'package:presentation/widgets/my_divider.dart';
import 'package:presentation/widgets/my_modal_bottom_sheet.dart';
import 'package:presentation/widgets/my_network_image.dart';
import 'package:presentation/widgets/my_scaffold.dart';
import 'package:presentation/widgets/my_text.dart';

class RepoDetailsScreen extends StatelessWidget {
  static const routeName = '/repo-details';

  const RepoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        context,
        titleText: context.strings.repoDetailsScreenTitle,
      ),
      body: SafeArea(
        child: BlocConsumer<RepoDetailsBloc, RepoDetailsState>(
          listenWhen: (previous, current) => previous.type != current.type && current.type == StateType.loaded,
          listener: (context, _) {
            context
              ..read<RepoDetailsIssuesBloc>().add(const RepoDetailsIssuesEvent.onIssuesRequested())
              ..read<RepoDetailsPullRequestsBloc>().add(const RepoDetailsPullRequestsEvent.onPullRequestsRequested());
          },
          builder: (context, state) {
            final selectedTab = state.detailsTab;

            return Column(
              children: [
                _Header(repo: state.argument.repo),
                Gap.medium,
                MyDivider(),
                Gap.medium,
                _TabsContent(selectedTab: selectedTab),
              ],
            ).columnPadded;
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.repo,
  });

  final Repo repo;

  static const _avatarHeight = 64.0;
  static const _avatarWidth = 64.0;
  static const _borderRadius = BorderRadius.all(Radius.circular(32));

  @override
  Widget build(BuildContext context) {
    final owner = repo.owner;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: _borderRadius,
              child: MyNetworkImage(
                imageUrl: owner.avatarUrl,
                height: _avatarHeight,
                width: _avatarWidth,
              ),
            ),
            HorizontalGap.large,
            MyText(
              owner.login,
              style: AppTextStyles.heading2,
            )
          ],
        ),
        Gap.medium,
        MyDivider(),
        Gap.medium,
        _RepoInfo(repo: repo),
      ],
    );
  }
}

class _RepoInfo extends StatelessWidget {
  const _RepoInfo({
    required this.repo,
  });
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    final repoDescription = repo.description ?? '';
    final repoTopics = repo.topics;

    final hasDescription = repoDescription.isNotEmpty;
    final hasTopics = repoTopics.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: MyText(
            repo.name,
            style: AppTextStyles.heading1,
          ),
        ),
        if (hasDescription || hasTopics) ...[
          HorizontalGap.large,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (hasDescription) _Description(description: repoDescription),
              if (hasDescription && hasTopics) Gap.small,
              if (hasTopics) _Topics(topics: repoTopics),
            ],
          ),
        ],
        Gap.large,
        MyDivider(),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton.icon(
      text: context.strings.repoDetailsDescriptionHeader,
      iconData: Icons.question_mark,
      onPressed: () => showMyModalBottomSheet(
        context: context,
        builder: (context) => MyModalBottomSheet(
          title: context.strings.repoDetailsDescriptionHeader,
          children: [
            MyText(
              description,
              style: AppTextStyles.bodyText,
            ),
          ],
        ),
      ),
    );
  }
}

class _Topics extends StatelessWidget {
  const _Topics({
    required this.topics,
  });

  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton.icon(
      text: context.strings.repoDetailsTopicsHeader,
      iconData: Icons.question_mark,
      onPressed: () => showMyModalBottomSheet(
        context: context,
        builder: (context) => MyModalBottomSheet(
          title: context.strings.repoDetailsTopicsHeader,
          children: topics
              .map(
                (e) => MyText(
                  e,
                  style: AppTextStyles.bodyText,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _TabsContent extends StatelessWidget {
  const _TabsContent({
    required this.selectedTab,
  });

  final DetailsTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTabButton(
                text: context.strings.repoDetailsIssuesLabel,
                isSelected: selectedTab == DetailsTab.issues,
                onPressed: () => context.read<RepoDetailsBloc>().add(
                      RepoDetailsEvent.onTabSelected(
                        selectedTab: DetailsTab.issues,
                      ),
                    ),
              ),
              HorizontalGap.large,
              MyTabButton(
                text: context.strings.repoDetailsPullRequestsLabel,
                isSelected: selectedTab == DetailsTab.pullRequests,
                onPressed: () => context.read<RepoDetailsBloc>().add(
                      RepoDetailsEvent.onTabSelected(
                        selectedTab: DetailsTab.pullRequests,
                      ),
                    ),
              ),
            ],
          ),
          if (selectedTab == DetailsTab.issues) RepoDetailsIssues(),
          if (selectedTab == DetailsTab.pullRequests) RepoDetailsPullRequests(),
        ],
      ),
    );
  }
}
