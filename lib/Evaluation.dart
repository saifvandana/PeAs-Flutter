import 'package:flutter/material.dart';

class Evaluation extends StatefulWidget {
  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Evaluation"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(child: Text("TeamMember1")),
        ],
      ),
    ));
  }
}

//Continue making rating buttons
