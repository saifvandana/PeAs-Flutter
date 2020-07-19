import 'package:flutter/material.dart';

//Defines the styles used throughout the app
//for both light and dark themes

//lightTheme constants
class Style {
  static const lightBackgroundColor = Color(0xffffffff);
  static const lightLogo = "assets/logoLight.png";

//darkTheme constants
  static const darkBackgroundColor = Color(0xff121212);
  static const darkLogo = "assets/logoDark.png";

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackgroundColor,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackgroundColor,
  );
}
