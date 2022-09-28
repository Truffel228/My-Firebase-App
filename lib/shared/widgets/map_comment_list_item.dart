import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/comment_view/comment_view_screen.dart';
import 'package:flutter/material.dart';

class MapCommentListItem extends StatelessWidget {
  const MapCommentListItem({
    Key? key,
    required this.mapComment,
    required this.index,
    this.onItemDelete,
    required this.enabled,
  }) : super(key: key);
  final MapComment mapComment;
  final int index;
  final VoidCallback? onItemDelete;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: enabled ? () => _onCommentTap(context) : () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: theme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            mapComment.comment,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  void _onCommentTap(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => CommentViewScreen(
        onDelete: onItemDelete != null ? () => onItemDelete!() : () {},
        comment: mapComment.comment,
      ),
    );
  }
}
