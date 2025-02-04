import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
    super.key,
  });

  final String data;
  final AppTextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;

  static const textScaleFactor = 1.0;
  static const textScaler = TextScaler.noScaling;

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? AppTextStyles.bodyText;

    return Text(
      data,
      style: textStyle.copyWith(
        color: color ?? Colors.black,
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: textOverflow,
      textScaler: textScaler,
    );
  }
}
