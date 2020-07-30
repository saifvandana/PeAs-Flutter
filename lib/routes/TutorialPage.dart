import 'package:flutter/material.dart';
import 'package:peas/routes/HomePage.dart';


class FirstPage extends StatelessWidget {
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(130.0),
      child: new Column(
          children: <Widget>[
            Image(
                  image: AssetImage('assets/bilkentlogo.png'),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
              ),
            SizedBox(height: 50),
            RichText(
              text: TextSpan(
              text: 'What is this App for?',
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 33),
              ),
               textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
              text: 'The Peer Assessment System (PeAs) is exclusively used for peer assessment in project groups. As a requirement for ABET accreditation, Bilkent University students are to evaluate the performances of their project partners via this system ',
              style: TextStyle(color: Colors.blueGrey, fontSize: 21),
            ),
             textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            FirstButton(),
          ],
        ),
    );

    //build function returns a "Widget"
    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Peer Assessment'),
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