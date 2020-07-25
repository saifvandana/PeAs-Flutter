import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
AppStateNotifier is used to notify all listeners throughout
the app of a change in theme
*/

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode;

  //Constructor that is called before the app is run
  AppStateNotifier(bool isDarkonStart) {
    this.isDarkMode = isDarkonStart;
    //Necessary to fetch the stored theme preferences on app startup
    getIsDarkMode().then((value) {
      this.isDarkMode = value;
      notifyListeners();
    });
  }

  //To update the app on theme change and to save the preference
  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
    setIsDarkMode(isDarkMode);
  }

  //To get the stored theme preference
  Future<bool> getIsDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool('isDarkMode');
    if (result == null) {
      return (ThemeMode.system == ThemeMode.dark) ? true : false;
    }
    return result;
  }

  //To store the user's theme preference
  Future<bool> setIsDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('isDarkMode', value);
  }
}
