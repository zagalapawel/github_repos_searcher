import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/application/typography.dart';
import 'package:presentation/widgets/my_text.dart';

class MyAppBar extends AppBar {
  MyAppBar(
    this.context, {
    this.titleText,
    super.actions,
    super.key,
  });

  final BuildContext context;
  final String? titleText;

  static const _backIconSize = 24.0;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  double? get scrolledUnderElevation => 0.0;

  @override
  Widget? get leading => super.automaticallyImplyLeading && context.canPop()
      ? IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.chevron_left,
            size: _backIconSize,
            color: Colors.black,
          ),
        )
      : super.leading;

  @override
  bool? get centerTitle => true;

  @override
  Widget? get title => titleText != null
      ? MyText(
          titleText!,
          style: AppTextStyles.heading1,
          color: Colors.black,
          textAlign: TextAlign.center,
        )
      : super.title;
}
