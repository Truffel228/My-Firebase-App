import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.title,
    this.titleColor,
    this.titleWidget,
    this.onTap,
    this.color,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String? title;
  final Color? titleColor;
  final Widget? titleWidget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: title != null
            ? Text(
                title!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: titleColor ?? AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            : titleWidget,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? theme.primaryColor,
        ),
      ),
    );
  }
}
