import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/Evaluation.dart';
import 'package:provider/provider.dart';
import 'package:peas/HomePage.dart';
import 'package:peas/LoadData.dart';
import 'package:peas/List.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        return MaterialApp(
          //To set the whole app's theme
          title: 'PeAs',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,

          //App routes
          initialRoute: '/evaluation',
          routes: {
            '/': (context) => HomePage(),
            '/loadData': (context) => LoadData(),
            '/list': (context) => List(),
            '/evaluation': (context) => Evaluation(),
          },
        );
      }),
    ),
  );
}
