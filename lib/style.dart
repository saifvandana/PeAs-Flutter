import 'package:flutter/material.dart';

//Defines the styles used throughout the app
//for both light and dark themes

//lightTheme constants
class Style {
  //static const lightBackgroundColor = Color(0xffffffff);
  static const lightBackgroundColor = Color(0xfffafafa);
  static const lightLogo = "assets/logoLight.png";
  static const lightSunImage = "assets/sun.png";
  static const lightDayColor = Color(0xFF87ceeb);
  static const lightCardColor = Color(0xfff5f5f5);
  static const lightCursorColor = Colors.black;
  static const lightIconColor = Color(0xff0281be);
  static const lightHintTextColor = Colors.black38;

//darkTheme constants
  static const darkBackgroundColor = Color(0xff121212);
  static const darkLogo = "assets/logoDark.png";
  static const darkMoonImage = "assets/moon.png";
  static const darkNightColor = Color(0xFF645e73);
  static const darkCardColor = Color(0xff2e2e2e);
  static const darkCursorColor = Colors.white;
  static const darkIconColor = Color(0xFFffedb9);
  static const darkHintTextColor = Colors.white38;

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackgroundColor,
    cardTheme: CardTheme(
      color: lightCardColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: lightHintTextColor,
      ),
    ),
    iconTheme: IconThemeData(
      color: lightIconColor,
    ),
    cursorColor: lightCursorColor,
    textTheme: TextTheme(
      //subtitle1 is used for the URL input box text
      subtitle1: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackgroundColor,
    cardTheme: CardTheme(
      color: darkCardColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: darkHintTextColor,
      ),
    ),
    iconTheme: IconThemeData(
      color: darkIconColor,
    ),
    cursorColor: darkCursorColor,
    textTheme: TextTheme(
      //subtitle1 is used for the URL input box text
      subtitle1: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
