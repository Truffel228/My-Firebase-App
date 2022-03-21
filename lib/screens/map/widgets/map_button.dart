import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  const MapButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          icon,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
