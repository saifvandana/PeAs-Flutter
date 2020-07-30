import 'package:flutter/material.dart';
import 'package:peas/style.dart';
import 'package:peas/AppStateNotifier.dart';

var appState = AppStateNotifier(true);

class NextPage extends StatelessWidget {
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(110.0),
      child: new Column(
          children: <Widget>[
            Image(
                  image: AssetImage('assets/mail.jpg'),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
              ),
            SizedBox(height: 50),
            RichText(
              text: TextSpan(
              text: 'How to use it? ',
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 33),
              ),
               textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
              text: 'Application will be available to use once you receive the link from your instructor. \n Click on the link to open the app. \nAfter that, you can start evaluating your peers.\n Evaluations can be done between start and end dates',
              style: TextStyle(color: Colors.blueGrey, fontSize: 21),
            ),
             textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A2),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child:
                  const Text('Back', style: TextStyle(fontSize: 20)),
            ),
            ),
          ],
        ),
    );
    //build function returns a "Widget"
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: Style.lightTheme, darkTheme: Style.darkTheme,

      //Sets the app theme based on saved user preferences
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      home: new Scaffold(
        
        appBar: new AppBar(
          title: new Text('Peer Assessment'),
        ),
        
        body: new ListView(
          
          children: <Widget>[
            titleSection
          ],
        )
      )
    );
  }
}