import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class CommentViewScreen extends StatelessWidget {
  const CommentViewScreen({
    Key? key,
    required this.onDelete,
    required this.comment,
  }) : super(key: key);
  final VoidCallback onDelete;
  final String comment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            initialValue: comment,
            minLines: 1,
            maxLines: 10,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton(
                onTap: () => Navigator.pop(context),
                title: 'Back',
                titleColor: theme.primaryColor,
                color: Colors.transparent,
              ),
              AppButton(
                onTap: () {
                  onDelete();
                  Navigator.pop(context);
                },
                title: 'Delete',
                color: AppColors.darkRedColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
