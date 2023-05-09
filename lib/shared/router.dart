import 'package:fire_base_app/screens/home/home_screen.dart';
import 'package:fire_base_app/screens/image_view/image_view_screen.dart';
import 'package:fire_base_app/screens/user_profile_view/user_profile_view_screen.dart';
import 'package:fire_base_app/screens/video_view/video_view_screen.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String home = '/home';
  static String log = '/log';
  static String userProfileView = '/userProfileView';
  static String imageView = '/imageView';
  static String videoView = '/videoView';

  static Map<String, WidgetBuilder> get routes => {
        home: (BuildContext context) => const HomeScreen(),
        userProfileView: (BuildContext context) => const UserProfileScreen(),
        imageView: (BuildContext context) => const ImageViewScreen(),
        videoView: (BuildContext context) => const VideoViewScreen(),
      };
}
