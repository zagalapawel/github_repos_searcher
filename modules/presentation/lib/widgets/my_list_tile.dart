import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/widgets/my_divider.dart';
import 'package:presentation/widgets/my_ink_well.dart';
import 'package:presentation/widgets/my_text.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    required this.title,
    this.titleMaxLines = 2,
    this.descriptionMaxLines = 5,
    this.onPressed,
    this.description,
    this.footer,
    super.key,
  });

  final String title;
  final int titleMaxLines;
  final int descriptionMaxLines;
  final VoidCallback? onPressed;
  final String? description;
  final Widget? footer;

  static const _borderRadius = BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    final itemDescription = description ?? '';

    final content = Padding(
      padding: EdgeInsets.all(Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title,
            style: AppTextStyles.heading2,
            maxLines: titleMaxLines,
            textOverflow: TextOverflow.ellipsis,
          ),
          if (itemDescription.isNotEmpty) ...[
            Gap.medium,
            MyText(
              itemDescription,
              style: AppTextStyles.bodyText,
              maxLines: descriptionMaxLines,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
          Gap.large,
          if (footer != null) ...[
            MyDivider(),
            Gap.small,
            footer!,
          ],
        ],
      ),
    );

    return Card(
      color: Colors.amber.shade100,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black12,
        ),
        borderRadius: _borderRadius,
      ),
      child: onPressed == null
          ? content
          : MyInkWell(
              onPressed: onPressed,
              borderRadius: _borderRadius,
              child: content,
            ),
    );
  }
}
