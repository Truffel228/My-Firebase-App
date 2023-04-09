import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttachmentCrossIcon extends StatelessWidget {
  const AttachmentCrossIcon({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greyColor.withOpacity(0.7),
        ),
        padding: const EdgeInsets.all(2.5),
        child: const Icon(
          FontAwesomeIcons.xmark,
          color: AppColors.blackColor,
          size: 14,
        ),
      ),
    );
  }
}
