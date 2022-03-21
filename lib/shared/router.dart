import 'package:fire_base_app/screens/home/home_screen.dart';
import 'package:fire_base_app/screens/log/log_screen_wrapper.dart';
import 'package:flutter/material.dart';

abstract class Routes{
  static String home = '/home';
  static String log = '/log';

  static Map<String, WidgetBuilder> get routes =>{
    home:(BuildContext context) => HomeScreen(),
  };

}