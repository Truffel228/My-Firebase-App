import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/map_comment/map_comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapCommentMarker extends StatelessWidget {
  const MapCommentMarker({Key? key, required this.mapComment})
      : super(key: key);
  final MapComment mapComment;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _openMapComment(context, mapComment),
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          FontAwesomeIcons.comment,
          size: 20,
          color: theme.primaryColor,
        ),
      ),
    );
  }

  void _openMapComment(BuildContext context, MapComment mapComment) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) => MapCommentScreen(
        comment: mapComment.comment,
        userId: mapComment.userId,
      ),
    );
  }
}

