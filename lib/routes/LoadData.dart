import 'package:flutter/material.dart';
import 'package:peas/handler.dart';
import 'package:peas/routes/NoInternet.dart';

class LoadData extends StatefulWidget {
  @override
  _LoadData createState() => _LoadData();
}

class _LoadData extends State<LoadData> {
  //Check for network connectivity before anything
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    if (arguments['action'] == 'start') {
      _start();
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _start() async {
    var connectionExists = await NoInternet.checkConnection();
    if (connectionExists == false) {
      Navigator.pushReplacementNamed(context, "/noInternet", arguments: {
        'redirect': '/loadData',
        'redirectArgs': {
          'url': arguments['url'],
          'action': 'start',
        },
      });
    } else {
      var assessor = Handler.getAssessor(arguments['url']);
      var assessmentInfo = await Handler.getAssessmentInfo(assessor);
      var isValid = await Handler.checkAssessmentValidity(assessmentInfo);
      if (isValid == false) {
        Navigator.pushReplacementNamed(context, '/badAssessment');
      } else {
        var peerAssessments = await Handler.getPeerAssessments(assessor);
        Navigator.pushReplacementNamed(context, '/list', arguments: {
          'assessor': assessor,
          'assessmentInfo': assessmentInfo,
          'peerAssessments': peerAssessments,
        });
      }
    }
  }
}
