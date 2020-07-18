import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/BadAssessment.dart';
import 'package:peas/Evaluation.dart';
import 'package:peas/NoInternet.dart';
import 'package:provider/provider.dart';
import 'package:peas/HomePage.dart';
import 'package:peas/LoadData.dart';
import 'package:peas/List.dart';

void main() {
  runApp(
    //Change notifier to apply app-wide changes to the theme
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(false),
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        return MaterialApp(
          //Title of the app
          title: 'PeAs',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          //Sets the app theme based on saved user preference
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
        );
      }),
    ),
  );
}
