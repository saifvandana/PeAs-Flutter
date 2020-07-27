import 'package:flutter/material.dart';


class FirstPage extends StatelessWidget {
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(130.0),
      child: new Column(
          children: <Widget>[
            Image(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
              ),
            SizedBox(height: 50),
            RichText(
              text: TextSpan(
              text: 'What is this App for? ',
              style: TextStyle(color: Colors.black.withOpacity(1.0), fontWeight: FontWeight.bold, fontSize: 33),
              ),
               textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
              text: 'The Peer Assessment System (PeAs) is exclusively used for peer assessment in project groups. As a requirement for ABET accreditation, Bilkent University students are to evaluate the performances of their project partners via this system ',
              style: TextStyle(color: Colors.black.withOpacity(1.0),fontSize: 21),
            ),
             textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
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

class FirstButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                  );
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.5),
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
                padding: const EdgeInsets.all(21.0),
                child: const Text('Next', style: TextStyle(fontSize: 20)),
              ),
            ),
    );
  }
}

/*
class HomeButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.5),
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
                padding: const EdgeInsets.all(21.0),
                child: const Text('Back', style: TextStyle(fontSize: 20)),
              ),
            ),
    );
  }
}*/

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
              style: TextStyle(color: Colors.black.withOpacity(1.0), fontWeight: FontWeight.bold, fontSize: 33),
              ),
               textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
              text: 'Application will be available to use once you receive the necessary link from your instructor. \n Copy and paste the link in the provided link slot on the app. \nAfter that, you can start evaluating your peers.\n Evaluations can be done prior to the deadline',
              style: TextStyle(color: Colors.black.withOpacity(1.0),fontSize: 21),
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