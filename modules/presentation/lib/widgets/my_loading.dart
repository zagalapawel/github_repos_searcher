import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  static const _strokeWidth = 1.3;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Colors.black,
      backgroundColor: Colors.amber,
      strokeWidth: _strokeWidth,
    );
  }
}
