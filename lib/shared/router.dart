import 'package:fire_base_app/screens/filter/filter_screen.dart';
import 'package:fire_base_app/screens/home/home_screen.dart';
import 'package:fire_base_app/screens/image_view/image_view_screen.dart';
import 'package:fire_base_app/screens/user_profile_view/user_profile_view_screen.dart';
import 'package:fire_base_app/screens/video_view/video_view_screen.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const String home = '/home';
  static const String log = '/log';
  static const String userProfileView = '/userProfileView';
  static const String imageView = '/imageView';
  static const String videoView = '/videoView';
  static const String filter = '/filter';

  static Map<String, WidgetBuilder> get routes => {
        home: (BuildContext context) => const HomeScreen(),
        userProfileView: (BuildContext context) => const UserProfileScreen(),
        imageView: (BuildContext context) => const ImageViewScreen(),
        videoView: (BuildContext context) => const VideoViewScreen(),
        filter: (BuildContext context) => const FilterScreen(),
      };
}
