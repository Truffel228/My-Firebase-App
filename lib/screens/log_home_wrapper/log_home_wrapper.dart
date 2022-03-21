import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/screens/home/home_screen.dart';
import 'package:fire_base_app/screens/log/log_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogHomeWrapper extends StatelessWidget {
  const LogHomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);
    return appUser == null ? LogScreenWrapper() : HomeScreen();
  }
}
