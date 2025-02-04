import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/injector_container.dart';
import 'package:presentation/screens/repo_details/bloc/repo_details_bloc.dart';
import 'package:presentation/screens/repo_details/repo_details_screen.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_issues/bloc/repo_details_issues_bloc.dart';
import 'package:presentation/screens/repo_details/widgets/repo_details_pull_requests/bloc/repo_details_pull_requests_bloc.dart';

Widget repoDetailsRoute(GoRouterState state) => MultiBlocProvider(
      providers: [
        BlocProvider<RepoDetailsBloc>(
          create: (_) => injector<RepoDetailsBloc>(
            param1: state.extra,
          )..add(const RepoDetailsEvent.onInitiated()),
        ),
        BlocProvider<RepoDetailsIssuesBloc>(
          create: (_) => injector<RepoDetailsIssuesBloc>(
            param1: state.extra,
          ),
        ),
        BlocProvider<RepoDetailsPullRequestsBloc>(
          create: (_) => injector<RepoDetailsPullRequestsBloc>(
            param1: state.extra,
          ),
        ),
      ],
      child: const RepoDetailsScreen(),
    );
