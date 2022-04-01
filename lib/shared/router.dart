import 'package:fire_base_app/screens/comment_form/comment_form_screen.dart';
import 'package:fire_base_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

abstract class Routes{
  static String home = '/home';
  static String log = '/log';
  static String commentFormScreen = '/commentFormScreen';


  static Map<String, WidgetBuilder> get routes =>{
    home:(BuildContext context) => HomeScreen(),
    commentFormScreen: (BuildContext context) => CommentFromScreen(),
  };

}