import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/home/home_screen.dart';
import 'package:presentation/widgets/my_scaffold.dart';
import 'package:presentation/widgets/my_text.dart';

class SplashScreen extends HookWidget {
  static const String routeName = '/';

  const SplashScreen({super.key});

  static const splashDuration = Duration(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: splashDuration);

    useEffect(
      () {
        void listener(status) {
          if (status == AnimationStatus.completed) {
            context.go(HomeScreen.routeName);
          }
        }

        controller.addStatusListener(listener);
        return () => controller.removeStatusListener(listener);
      },
      [controller],
    );

    controller.forward();

    return MyScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: controller,
            child: Center(
              child: MyText(
                context.strings.appTitle,
                style: AppTextStyles.heading1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
