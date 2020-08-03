import 'package:flutter/material.dart';
import 'package:peas/style.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:provider/provider.dart';

var appState = AppStateNotifier(true);

class NextPage extends StatelessWidget {
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(10.0),
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
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
               textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
              text: 'Application will be available to use once you receive the link from your instructor. \n Click on the link to open the app. \nAfter that, you can start evaluating your peers.\n Evaluations can be done between start and end dates',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 16,
                    ),
            ),
             textAlign: TextAlign.center,
            ),
            SizedBox(height: 29),
            RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textColor: Colors.black,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue,Colors.redAccent, Colors.white10],
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
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          title: Text(
            'Peer Assessment',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: new ListView(
          children: <Widget>[
            titleSection,
          ],   
        )
      )
    );
  }
}