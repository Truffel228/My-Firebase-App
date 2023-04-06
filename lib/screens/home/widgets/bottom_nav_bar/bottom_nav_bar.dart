import 'package:fire_base_app/screens/home/widgets/bottom_nav_bar/nav_bar_clipper.dart';
import 'package:fire_base_app/screens/home/widgets/bottom_nav_bar/nav_bar_item.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.onItemTap})
      : super(key: key);
  final int currentIndex;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          child: ClipPath(
            clipper: NavBarClipper(),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.lightPurpleColor, theme.primaryColor],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavBarItem(
                onTap: () => onItemTap(0),
                isActive: currentIndex == 0,
                icon: FontAwesomeIcons.user,
                iconSize: 26,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.17),
              NavBarItem(
                onTap: () => onItemTap(1),
                isActive: currentIndex == 1,
                icon: FontAwesomeIcons.map,
                iconSize: 26,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
