import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapCommentMarkerCluster extends StatelessWidget {
  const MapCommentMarkerCluster({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Stack(
        children: [
          Center(
            child: Icon(
              FontAwesomeIcons.comment,
              size: 23,
              color: theme.primaryColor,
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(color: theme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
