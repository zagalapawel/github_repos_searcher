import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/application.dart';
import 'package:presentation/common/app_bloc_observer.dart';
import 'package:presentation/environment/env.dart';
import 'package:presentation/injector_container.dart' as di;
import 'package:presentation/router/app_route_factory.dart';

Future<void> runApplication() async {
  await di.init(
    gitHubApiUrl: Env.gitHubApiUrl,
  );

  Bloc.observer = AppBlocObserver();

  runApp(
    Application(
      appRouteFactory: AppRouteFactory(),
    ),
  );
}
