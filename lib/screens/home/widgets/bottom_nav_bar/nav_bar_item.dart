import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem(
      {Key? key,
      required this.isActive,
      required this.icon,
      required this.iconSize,
      required this.onTap})
      : super(key: key);
  final bool isActive;
  final IconData icon;
  final double iconSize;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: theme.primaryColor,
        child: CircleAvatar(
          radius: 27,
          child: Icon(
            icon,
            color: isActive ? theme.primaryColor : Colors.white,
            size: iconSize,
          ),
          backgroundColor: isActive ? Colors.white : theme.primaryColor,
        ),
      ),
    );
  }
}
