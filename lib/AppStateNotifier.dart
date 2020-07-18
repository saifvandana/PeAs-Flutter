import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateNotifier extends ChangeNotifier {
  //
  bool isDarkMode = false;

  AppStateNotifier() {
    this.getIsDarkMode().then((value) {
      this.isDarkMode = value;
      notifyListeners();
    });
  }

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
    setIsDarkMode(isDarkMode);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------
  Future<bool> getIsDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool('isDarkMode');
    if (result == null) {
      return (ThemeMode.system == ThemeMode.dark) ? true : false;
    }
    return result;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision to allow notifications
  /// ----------------------------------------------------------
  Future<bool> setIsDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool('isDarkMode', value);
  }
}
