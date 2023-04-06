import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GeoServiceNoPermissionDialog extends StatelessWidget {
  const GeoServiceNoPermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "The app doesn't have geolocation permission. Fore application working properly please provide geolocation permission.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  onTap: () => Navigator.of(context).pop(),
                  title: 'Cancel',
                  titleColor: theme.primaryColor,
                  color: AppColors.transparentColor,
                ),
                AppButton(
                  onTap: () => openAppSettings(),
                  title: 'Open app settings',
                  titleColor: theme.primaryColor,
                  color: AppColors.transparentColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
