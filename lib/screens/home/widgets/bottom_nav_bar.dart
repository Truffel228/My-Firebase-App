import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.onItemTap})
      : super(key: key);
  final int currentIndex;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedIconTheme: IconThemeData(color: theme.primaryColor, size: 27),
      unselectedIconTheme:
          IconThemeData(color: theme.primaryColor.withOpacity(0.6), size: 25),
      onTap: onItemTap,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.map),
          label: '',
        ),
      ],
    );
  }
}
