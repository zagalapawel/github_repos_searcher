import 'package:flutter/material.dart';
import 'package:presentation/l10n/translations.dart';
import 'package:presentation/router/app_route_factory.dart';

class Application extends StatelessWidget {
  Application({
    required this.appRouteFactory,
    super.key,
  });

  final AppRouteFactory appRouteFactory;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  late final _routerConfig = appRouteFactory.router(
    rootNavigatorKey: _rootNavigatorKey,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      debugShowCheckedModeBanner: false,
      routerConfig: _routerConfig,
      builder: (_, child) => child ?? SizedBox.shrink(),
    );
  }
}
