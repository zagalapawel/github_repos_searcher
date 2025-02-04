import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('${_baseType(bloc)}: Created ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('${_baseType(bloc)}: Closed ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${_baseType(bloc)}: Error in ${bloc.runtimeType}: $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('${_baseType(bloc)}: Transition in ${bloc.runtimeType}: $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${_baseType(bloc)}: Change in ${bloc.runtimeType}: $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('${_baseType(bloc)}: Event in ${bloc.runtimeType}: $event');
  }

  String _baseType(BlocBase blocBase) {
    return (blocBase is Bloc) ? 'bloc' : 'cubit';
  }
}
