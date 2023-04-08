import 'dart:io';

import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Attachments extends StatelessWidget {
  const Attachments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            AddAttachmentWidget(
              iconData: FontAwesomeIcons.solidImage,
              text: 'Add image',
              leftMargin: 16,
              onTap: () {},
            ),
            AddAttachmentWidget(
              iconData: FontAwesomeIcons.camera,
              text: 'Add video',
              leftMargin: 8,
              onTap: () {},
            ),
            AttachmentWidget(),
          ],
        ),
      ),
    );
  }
}

class AddAttachmentWidget extends StatelessWidget {
  const AddAttachmentWidget({
    Key? key,
    required this.iconData,
    required this.text,
    required this.leftMargin,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final double leftMargin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        margin: EdgeInsets.only(left: leftMargin),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: theme.primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Icon(
                    iconData,
                    color: AppColors.whiteColor,
                    size: constraints.maxHeight * 0.6,
                  );
                },
              ),
            ),
            Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      width: 80,
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: theme.primaryColor,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.7),
          ),
          padding: const EdgeInsets.all(2),
          child: const Icon(
            FontAwesomeIcons.xmark,
            color: AppColors.blackColor,
            size: 12,
          ),
        ),
      ),
    );
  }
}
