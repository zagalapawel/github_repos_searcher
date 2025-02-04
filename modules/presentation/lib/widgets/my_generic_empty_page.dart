import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/extensions/column_padded_extension.dart';
import 'package:presentation/widgets/my_text.dart';

enum MyGenericEmptyPageType { generic, custom }

class MyGenericEmptyPage extends StatelessWidget {
  const MyGenericEmptyPage({
    super.key,
  })  : _title = null,
        _description = null,
        _type = MyGenericEmptyPageType.generic;

  const MyGenericEmptyPage.custom({
    required String title,
    String? description,
    super.key,
  })  : _title = title,
        _description = description,
        _type = MyGenericEmptyPageType.custom;

  final MyGenericEmptyPageType _type;
  final String? _title;
  final String? _description;

  @override
  Widget build(BuildContext context) {
    final description =
        _type == MyGenericEmptyPageType.generic ? context.strings.genericEmptyMessageDescription : _description;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          _title ?? context.strings.genericEmptyMessageTitle,
          style: AppTextStyles.heading2,
          textAlign: TextAlign.center,
        ),
        if (description != null) ...[
          Gap.large,
          MyText(
            description,
            style: AppTextStyles.information,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    ).columnPadded;
  }
}
