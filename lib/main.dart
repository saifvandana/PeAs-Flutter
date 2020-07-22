import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/BadAssessment.dart';
import 'package:peas/Evaluation.dart';
import 'package:peas/NoInternet.dart';
import 'package:provider/provider.dart';
import 'package:peas/HomePage.dart';
import 'package:peas/LoadData.dart';
import 'package:peas/List.dart';
import 'package:peas/style.dart';

void main() {
  //Loading saved preferences before starting app
  WidgetsFlutterBinding.ensureInitialized();
  var appState = AppStateNotifier(false);
  runApp(
    //Change notifier to apply app-wide changes to the theme
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => appState,
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        //Gesture detector to unfocus from any form field when clicked away from
        //This behaviour will be there throughout the app
        return GestureDetector(
            onTap: () {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            },
            child: MaterialApp(
              //Title of the app
              title: 'PeAs',

              //Removes the debug banner during testing
              debugShowCheckedModeBanner: false,

              //Defines the light and dark themes to be used in the app
              //The themes are defined in style.dart
              theme: Style.lightTheme,
              darkTheme: Style.darkTheme,

              //Sets the app theme based on saved user preferences
              themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,

              //App routes
              routes: {
                '/': (context) => HomePage(),
                '/loadData': (context) => LoadData(),
                '/list': (context) => List(),
                '/evaluation': (context) => Evaluation(),
                '/badAssessment': (context) => BadAssessment(),
                '/noInternet': (context) => NoInternet(),
              },
            ));
      }),
    ),
  );
}
