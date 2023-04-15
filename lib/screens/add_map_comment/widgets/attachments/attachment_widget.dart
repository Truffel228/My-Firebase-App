import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/screens/add_map_comment/widgets/attachments/attachment_cross_icon.dart';
import 'package:fire_base_app/shared/entities/attachment.dart';
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:fire_base_app/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: VideoDurationChip(
                durationSec: attachment.videoDurationSec!,
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
}
