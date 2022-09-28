import 'package:fire_base_app/screens/map/map_screen.dart';
import 'package:fire_base_app/screens/profile/profile_screen.dart';
import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/services/auth/auth_service.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/logger.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthServiceInterface _auth = locator.get<AuthServiceInterface>();
  int currentIndex = 0;
  final screens = [ProfileScreen(), MapScreen()];

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Firebase App'),
        actions: [
          AppButton(
            onPressed: () async {
              _auth.signOut();
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onItemTap: _onBottomNavBarItemTap,
      ),
    );
  }

  void _onBottomNavBarItemTap(int index) {
    setState(() {
      currentIndex = index;
    });
    logger.i('On Bottom Nav Bar Item Tap');
  }
}
