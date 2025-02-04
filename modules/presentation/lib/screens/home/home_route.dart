import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/injector_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/screens/home/home_screen.dart';

Widget homeRoute(GoRouterState state) => BlocProvider<HomeBloc>(
      create: (_) => injector<HomeBloc>(),
      child: const HomeScreen(),
    );
