import 'package:flutter/material.dart';

final TextTheme lightTextTheme = TextTheme(
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: whiteColor,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: whiteColor,
  ),
);

final ThemeData lightTheme = ThemeData(
  splashColor: transparentColor,
  highlightColor: transparentColor,
  appBarTheme: AppBarTheme(
      backgroundColor: purpleColor, elevation: 0, centerTitle: true),
  primaryColor: purpleColor,
  errorColor: darkRedColor,
  textTheme: lightTextTheme,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: lightPurpleColor,
    selectionHandleColor: lightPurpleColor,
    selectionColor: purpleColor.withOpacity(0.5),
  ),
);

const Color purpleColor = Color(0xFF7E0080);
const Color lightPurpleColor = Color(0xFF9B51B4);
const Color pinkColor = Color(0xFFDF6FA0);
const Color redColor = Color(0xFFEF224B);
const Color darkRedColor = Color(0xFFC20232);
const Color greenColor = Color(0xFF38B64A);
const Color greyColor = Color(0xFFA6A6A6);
const Color transparentColor = Colors.transparent;
const Color whiteColor = Colors.white;
