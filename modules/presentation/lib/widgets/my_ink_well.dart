import 'package:flutter/material.dart';

class MyInkWell extends StatelessWidget {
  const MyInkWell({
    this.onPressed,
    this.child,
    this.borderRadius,
    super.key,
  });

  final Widget? child;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.black12,
      focusColor: Colors.black12,
      highlightColor: Colors.black12,
      splashColor: Colors.black12,
      onTap: onPressed,
      borderRadius: borderRadius,
      child: child,
    );
  }
}
