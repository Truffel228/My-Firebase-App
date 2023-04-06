import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class GeoServiceDisabledDialog extends StatelessWidget {
  const GeoServiceDisabledDialog({Key? key}) : super(key: key);

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
              'Geolocation service is disabled. For app working poperly please turn on geoservice.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            AppButton(
              onTap: () => Navigator.of(context).pop(),
              title: 'Okay',
              titleColor: theme.primaryColor,
              color: AppColors.transparentColor,
            ),
          ],
        ),
      ),
    );
  }
}
