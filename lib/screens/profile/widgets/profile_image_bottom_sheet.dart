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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 130),
            child: AppButton(
              onTap: onPickGalleryTap,
              titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    FontAwesomeIcons.solidImage,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'GALLERY',
                    style: Theme.of(context).textTheme.bodyMedium,
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
                children: [
                  const Icon(
                    FontAwesomeIcons.camera,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'PHOTO',
                    style: Theme.of(context).textTheme.bodyMedium,
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
