import 'package:flutter/material.dart';

//Defines the styles used throughout the app
//for both light and dark themes

class Style {
  //lightTheme constants
  //Some of these constants are accessed from other widgets
  //in the app

  //background color of the scaffold
  static const lightBackgroundColor = Color(0xfffafafa);
  //Asset image of the PeAs logo shown in light mode
  static const lightLogo = "assets/logoLight.png";
  //Assets: sun image in the theme switcher
  static const lightSunImage = "assets/sun.png";
  //Color of the 'sky' behind the sun in the theme switcher
  static const lightDayColor = Color(0xFF87ceeb);
  //background color of all card widgets
  static const lightCardColor = Color(0xfff5f5f5);
  //cursor color of all input boxes
  static const lightCursorColor = Colors.black;
  static const lightIconColor = Color(0xff0281be);
  //The hint text color of the text input boxes
  static const lightHintTextColor = Colors.black54;
  static const lightButtonColor = Color(0xfff5b400);
  static const lightAccentColor = Color(0xff0281be);
  //The shade of green used for the submit button
  //and assessment completion icon on the evaluation page
  static const lightGreenColor = Colors.lightGreen;

  //darkTheme constants

  //background color of the scaffold
  static const darkBackgroundColor = Color(0xff121212);
  //Asset image of the PeAs logo shown in light mode
  static const darkLogo = "assets/logoDark.png";
  //Assets: moon image in the theme switcher
  static const darkMoonImage = "assets/moon.png";
  //Color of the 'sky' behind the moon in the theme switcher
  static const darkNightColor = Color(0xFF645e73);
  //background color of all card widgets
  static const darkCardColor = Color(0xff2e2e2e);
  //cursor color of all input boxes
  static const darkCursorColor = Colors.white;
  static const darkIconColor = Color(0xFFffedb9);
  //The hint text color of the text input boxes
  static const darkHintTextColor = Colors.white60;
  static const darkButtonColor = Color(0xFFffedb9);
  static const darkAccentColor = Color(0xFFffedb9);
  //The shade of green used for the submit button
  //and assessment completion icon on the evaluation page
  static const darkGreenColor = Colors.greenAccent;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
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
      //Warning message for no internet
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
      ),
      headline6: TextStyle(
        color: Colors.black,
      ),
    ),
    accentColor: lightAccentColor,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
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
      //Warning message for no internet
      bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      headline6: TextStyle(
        color: Colors.white,
      ),
    ),
    accentColor: darkAccentColor,
  );
}
