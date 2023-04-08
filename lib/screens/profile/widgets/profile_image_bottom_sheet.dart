import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PickFileBottomSheet extends StatelessWidget {
  const PickFileBottomSheet({
    Key? key,
    required this.onGalleryTap,
    required this.onCameraTap,
    required this.onDeleteTap,
  }) : super(key: key);

  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 130),
            child: AppButton(
              onTap: onGalleryTap,
              titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.solidImage,
                    color: AppColors.whiteColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'GALLERY',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 130),
            child: AppButton(
              onTap: onCameraTap,
              titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.camera,
                    color: AppColors.whiteColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'CAMERA',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (onDeleteTap != null) ...[
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 130),
              child: AppButton(
                onTap: onDeleteTap,
                color: AppColors.darkRedColor,
                titleWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.trash,
                      color: AppColors.whiteColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'DELETE',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
