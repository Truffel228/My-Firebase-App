import 'package:fire_base_app/screens/add_map_comment/add_map_comment_screen.dart';
import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/pick_file_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAttachmentWidget extends StatelessWidget {
  const AddAttachmentWidget({
    Key? key,
    required this.iconData,
    required this.text,
    required this.leftMargin,
    required this.fileType,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final double leftMargin;
  final FileType fileType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _onAddAttachmentTap(context),
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

  void _onGalleryTap(BuildContext context) => context
      .read<AddMapCommentBloc>()
      .add(AddMapCommentFileFromGallery(fileType));

  void _onCameraTap(BuildContext context) => context
      .read<AddMapCommentBloc>()
      .add(AddMapCommentFileFromCamera(fileType));

  void _onAddAttachmentTap(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => PickFileBottomSheet(
          onGalleryTap: () => _onGalleryTap(context),
          onCameraTap: () => _onCameraTap(context),
        ),
      );
}
