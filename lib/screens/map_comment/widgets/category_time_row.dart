import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryTimeRow extends StatelessWidget {
  const CategoryTimeRow({
    Key? key,
    required this.category,
    required this.time,
  }) : super(key: key);
  final String category;
  final String? time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.greyColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(width: 24),
        time != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creation time:',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
