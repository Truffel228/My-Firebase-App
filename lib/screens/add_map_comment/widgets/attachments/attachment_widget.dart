import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/screens/add_map_comment/widgets/attachments/attachment_cross_icon.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_base_app/core/enums/enums.dart';

class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({
    Key? key,
    required this.attachment,
  }) : super(key: key);

  final Attachment attachment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 80,
      width: 80,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: attachment.fileType == FileType.image
            ? DecorationImage(
                image: FileImage(attachment.file),
                fit: BoxFit.cover,
              )
            : attachment.videoPreview != null
                ? DecorationImage(
                    image: FileImage(attachment.videoPreview!),
                    fit: BoxFit.cover,
                  )
                : null,
      ),
      child: Stack(
        children: [
          if (attachment.fileType == FileType.video &&
              attachment.videoDurationSec != null)
            Positioned(
              bottom: 6,
              right: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
                decoration: BoxDecoration(
                  color: AppColors.blackColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatTime(attachment.videoDurationSec!),
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          Positioned(
            top: 6,
            right: 6,
            child: AttachmentCrossIcon(
              onTap: () => context
                  .read<AddMapCommentBloc>()
                  .add(AddMapCommentAttachmentDelete(attachment.file.path)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    if (seconds >= 60) {
      final min = (seconds / 60).floor();
      final sec = seconds.remainder(60).toString().padLeft(2, '0');
      return '$min:$sec';
    }
    final sec = seconds.toString().padLeft(2, '0');
    return '0:$sec';
  }
}
