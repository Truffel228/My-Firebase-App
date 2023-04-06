import 'package:flutter/material.dart';

final TextTheme lightTextTheme = TextTheme(
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  ),
);

final ThemeData lightTheme = ThemeData(
  splashColor: AppColors.transparentColor,
  highlightColor: AppColors.transparentColor,
  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.purpleColor, elevation: 0, centerTitle: true),
  primaryColor: AppColors.purpleColor,
  errorColor: AppColors.darkRedColor,
  textTheme: lightTextTheme,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.lightPurpleColor,
    selectionHandleColor: AppColors.lightPurpleColor,
    selectionColor: AppColors.purpleColor.withOpacity(0.5),
  ),
);

class AppColors {
  static const Color purpleColor = Color(0xFF7E0080);
  static const Color lightPurpleColor = Color(0xFF9B51B4);
  static const Color pinkColor = Color(0xFFDF6FA0);
  static const Color redColor = Color(0xFFEF224B);
  static const Color darkRedColor = Color(0xFFC20232);
  static const Color greenColor = Color(0xFF38B64A);
  static const Color greyColor = Color(0xFFA6A6A6);
  static const Color transparentColor = Colors.transparent;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
}
