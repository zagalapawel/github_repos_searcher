import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    required this.body,
    this.appBar,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;

  static const bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      backgroundColor: bgColor,
      appBar: appBar,
      body: body,
    );

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: bgColor,
        systemNavigationBarDividerColor: bgColor,
      ),
      child: content,
    );
  }
}
