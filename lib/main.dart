import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/routes/BadAssessment.dart';
import 'package:peas/routes/Evaluation.dart';
import 'package:peas/routes/NoInternet.dart';
import 'package:provider/provider.dart';
import 'package:peas/routes/HomePage.dart';
import 'package:peas/routes/LoadData.dart';
import 'package:peas/routes/listAssessments.dart';
import 'package:peas/style.dart';
/*
The app is run from the main method in this file
*/

//TODO: app icons could be added, you can use a dev package like:
//https://pub.dev/packages/flutter_launcher_icons
//or something similar to simplify the process

//TODO: test the app on an apple device, there could be system specific problems
//not guaranteed to run the same as on android

void main() {
  //Loading saved preferences before starting app
  //Used to have the saved theme available before rendering the page
  WidgetsFlutterBinding.ensureInitialized();
  //Passing false into the constructor so the app renders in light mode by default
  //until the saved preferences are fetched
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
              //Defines all the pages that can be navigated to in the app
              routes: {
                '/': (context) => HomePage(),
                '/loadData': (context) => LoadData(),
                '/listAssessments': (context) => ListAsessments(),
                '/evaluation': (context) => Evaluation(),
                '/badAssessment': (context) => BadAssessment(),
                '/noInternet': (context) => NoInternet(),
              },
            ));
      }),
    ),
  );
}
