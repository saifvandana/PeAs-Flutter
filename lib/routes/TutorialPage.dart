import 'package:flutter/material.dart';
import 'package:peas/routes/HomePage.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/style.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget {
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: EdgeInsets.only(top: 0),
      child: new Column(
          children: <Widget>[
            Image(
                  image: AssetImage('assets/bilkentlogo.png'),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topCenter,
              ),
            SizedBox(height: 50),
            RichText(
              text: TextSpan(
              text: 'What is this App for?',
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
              text: 'The Peer Assessment System (PeAs) is exclusively used for peer assessment in project groups. As a requirement for ABET accreditation, Bilkent University students are to evaluate the performances of their project partners via this system ',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 16,
                    ),
            ),
             textAlign: TextAlign.center,
            ),
            SizedBox(height: 35),
            FirstButton(),
          ],
        ),
    );

    //build function returns a "Widget"
    return SafeArea(
      child: new Scaffold(
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