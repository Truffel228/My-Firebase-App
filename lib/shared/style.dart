import 'package:flutter/material.dart';

final TextTheme lightTextTheme = TextTheme(
  bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
);

final ThemeData lightTheme = ThemeData(
  splashColor: transparentColor,
  highlightColor: transparentColor,
  appBarTheme: AppBarTheme(
      backgroundColor: stylePurpleColor, elevation: 0, centerTitle: true),
  primaryColor: stylePurpleColor,
  errorColor: styleDarkRedColor,
  textTheme: lightTextTheme,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: styleLightPurpleColor,
    selectionHandleColor: styleLightPurpleColor,
    selectionColor: stylePurpleColor.withOpacity(0.5),
  ),
);

const Color stylePurpleColor = Color(0xFF7E0080);
const Color styleLightPurpleColor = Color(0xFF9B51B4);
const Color stylePinkColor = Color(0xFFDF6FA0);
const Color styleRedColor = Color(0xFFEF224B);
const Color styleDarkRedColor = Color(0xFFC20232);
const Color styleGreenColor = Color(0xFF38B64A);
const Color transparentColor = Colors.transparent;
