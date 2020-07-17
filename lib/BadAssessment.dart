import 'package:flutter/material.dart';

class BadAssessment extends StatefulWidget {
  @override
  _BadAssessmentState createState() => _BadAssessmentState();
}

class _BadAssessmentState extends State<BadAssessment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bad assessment'),
        ),
        body: Text("Bad assessment: expired or not yet started"),
      ),
    );
  }
}
