import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileImageBottomSheet extends StatelessWidget {
  const ProfileImageBottomSheet({
    Key? key,
    required this.onPickGalleryTap,
    required this.onTakePhotoTap,
    required this.onDeletePhotoTap,
  }) : super(key: key);

  final VoidCallback onPickGalleryTap;
  final VoidCallback onTakePhotoTap;
  final VoidCallback onDeletePhotoTap;

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
              onTap: onPickGalleryTap,
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
              onTap: onTakePhotoTap,
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
                    'PHOTO',
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
      ),
    );
  }
}
