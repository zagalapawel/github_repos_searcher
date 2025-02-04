import 'package:flutter/widgets.dart';
import 'package:presentation/application/app.dart';

extension ColumnPaddedExtension on Widget {
  Widget get columnPadded => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
        child: this,
      );
}
