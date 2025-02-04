import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/extensions/column_padded_extension.dart';
import 'package:presentation/widgets/my_text.dart';

enum MyGenericErrorPageType { generic, custom }

class MyGenericErrorPage extends StatelessWidget {
  const MyGenericErrorPage({
    super.key,
  })  : _title = null,
        _description = null,
        _type = MyGenericErrorPageType.generic;

  const MyGenericErrorPage.custom({
    required String title,
    String? description,
    super.key,
  })  : _title = title,
        _description = description,
        _type = MyGenericErrorPageType.custom;

  final MyGenericErrorPageType _type;
  final String? _title;
  final String? _description;

  @override
  Widget build(BuildContext context) {
    final description =
        _type == MyGenericErrorPageType.generic ? context.strings.genericErrorMessageDescription : _description;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          _title ?? context.strings.genericErrorMessageTitle,
          style: AppTextStyles.heading2,
        ),
        if (description != null) ...[
          Gap.large,
          MyText(
            description,
            style: AppTextStyles.information,
          ),
        ],
      ],
    ).columnPadded;
  }
}
