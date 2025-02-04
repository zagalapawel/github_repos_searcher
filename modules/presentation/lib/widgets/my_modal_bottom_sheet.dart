import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/extensions/column_padded_extension.dart';
import 'package:presentation/widgets/my_divider.dart';
import 'package:presentation/widgets/my_text.dart';

Future<T?> showMyModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
}) async {
  const blurSigma = 3.0;
  final screenSize = MediaQuery.of(context).size;
  final maxHeight = 3 * screenSize.height / 4;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    barrierColor: Colors.transparent,
    constraints: BoxConstraints(maxHeight: maxHeight),
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: builder(context),
    ),
  );
}

class MyModalBottomSheet extends StatelessWidget {
  const MyModalBottomSheet({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  static const _radius = BorderRadius.vertical(top: Radius.circular(28));

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final header = [
      Gap.small,
      MyText(
        title,
        style: AppTextStyles.heading2,
      ),
      Gap.small,
      MyDivider().columnPadded,
      Gap.small,
    ];

    final content = [
      Flexible(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...children,
              Gap.large,
              SizedBox(height: bottomPadding),
            ],
          ).columnPadded,
        ),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: _radius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...header,
          ...content,
        ],
      ),
    );
  }
}
