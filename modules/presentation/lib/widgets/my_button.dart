import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/widgets/my_ink_well.dart';
import 'package:presentation/widgets/my_text.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    required this.text,
    required this.onPressed,
    super.key,
  }) : iconData = null;

  const MyOutlinedButton.icon({
    required this.text,
    required this.onPressed,
    required this.iconData,
    super.key,
  });

  final String text;
  final IconData? iconData;
  final VoidCallback? onPressed;

  static const _iconSize = 20.0;
  static const _contentColor = Colors.black;
  static const _borderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    final textWidget = MyText(
      text,
      style: AppTextStyles.heading2,
      color: _contentColor,
    );

    final style = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black12,
      side: BorderSide(color: Colors.black, width: _borderWidth),
    );

    if (iconData != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        label: textWidget,
        style: style,
        icon: Icon(
          iconData,
          size: _iconSize,
          color: _contentColor,
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: textWidget,
      );
    }
  }
}

class MyTabButton extends StatelessWidget {
  const MyTabButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  static const _borderRadius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.black : Colors.black45;

    return MyInkWell(
      borderRadius: _borderRadius,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.medium,
          vertical: Insets.small,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade100 : Colors.white,
          backgroundBlendMode: BlendMode.darken,
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.black,
            width: _borderWidth,
          ),
          borderRadius: _borderRadius,
        ),
        child: MyText(
          text,
          style: AppTextStyles.heading2,
          color: textColor,
        ),
      ),
    );
  }
}
