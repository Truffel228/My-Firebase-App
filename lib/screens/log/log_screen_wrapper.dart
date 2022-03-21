import 'package:fire_base_app/screens/log/sign_in_screen.dart';
import 'package:fire_base_app/screens/log/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LogScreenWrapper extends StatefulWidget {
  const LogScreenWrapper({Key? key}) : super(key: key);

  @override
  State<LogScreenWrapper> createState() => _LogScreenWrapperState();
}

class _LogScreenWrapperState extends State<LogScreenWrapper> {
  bool isSignIn = true;

  void toogleScreen() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignIn
        ? SignInScreen(toogleScreen: toogleScreen)
        : SignUpScreen(toogleScreen: toogleScreen);
  }
}
