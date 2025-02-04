import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/screens/home/home_route.dart';
import 'package:presentation/screens/home/home_screen.dart';
import 'package:presentation/screens/repo_details/repo_details_route.dart';
import 'package:presentation/screens/repo_details/repo_details_screen.dart';
import 'package:presentation/screens/splash/splash_route.dart';
import 'package:presentation/screens/splash/splash_screen.dart';

class AppRouteFactory {
  GoRouter router({
    required GlobalKey<NavigatorState> rootNavigatorKey,
  }) =>
      GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: SplashScreen.routeName,
        errorBuilder: (_, state) => splashRoute(state),
        routes: [
          GoRoute(
            path: SplashScreen.routeName,
            parentNavigatorKey: rootNavigatorKey,
            builder: (_, state) => splashRoute(state),
          ),
          GoRoute(
            path: HomeScreen.routeName,
            parentNavigatorKey: rootNavigatorKey,
            builder: (_, state) => homeRoute(state),
          ),
          GoRoute(
            path: RepoDetailsScreen.routeName,
            parentNavigatorKey: rootNavigatorKey,
            builder: (_, state) => repoDetailsRoute(state),
          )
        ],
      );
}
