import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    this.color,
    super.key,
  });

  final Color? color;

  static const dividerHeight = 1.3;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.black26,
      height: dividerHeight,
    );
  }
}
