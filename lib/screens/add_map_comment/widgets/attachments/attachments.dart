import 'package:fire_base_app/core/enums/enums.dart';
import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/screens/add_map_comment/widgets/attachments/add_attachment_widget.dart';
import 'package:fire_base_app/screens/add_map_comment/widgets/attachments/attachment_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Attachments extends StatelessWidget {
  const Attachments({
    Key? key,
    required this.attachments,
  }) : super(key: key);

  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const AddAttachmentWidget(
              iconData: FontAwesomeIcons.solidImage,
              text: 'Add image',
              leftMargin: 16,
              fileType: FileType.image,
            ),
            const AddAttachmentWidget(
              iconData: FontAwesomeIcons.camera,
              text: 'Add video',
              leftMargin: 8,
              fileType: FileType.video,
            ),
            ...List.generate(
              attachments.length,
              (index) => Padding(
                padding: index == attachments.length - 1
                    ? const EdgeInsets.only(right: 16)
                    : EdgeInsets.zero,
                child: AttachmentWidget(
                  attachment: attachments[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
