import 'package:flutter/material.dart';
import 'package:peas/handler.dart';
import 'package:peas/routes/NoInternet.dart';

/*
This server as the intermediate loading page to load the data
to diplay
*/

class LoadData extends StatefulWidget {
  @override
  _LoadData createState() => _LoadData();
}

class _LoadData extends State<LoadData> {
  //will hold the arguments coming from the previous route
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    //Getting the arguments from the previous route
    arguments = ModalRoute.of(context).settings.arguments;

    /*
    There are multiple 'modes' in which the loadData page can be called
    depending on the 'action' passed in the arguments
    refer to the routeArguments file for a list of the arguments that each
    page uses currently, you may add or remove if necessary
    */

    //action == start
    //this means that this is the first time this link is being passed (not a reload of data)
    //so the process needs to start from the beginning
    if (arguments['action'] == 'start') {
      _start();
    }

    //TODO: implement the other modes, ie. reloading the data when going back to
    //the listAssessments page to make sure data is always updated

    return SafeArea(
      child: Scaffold(
        //It just has a circular loading indicator that takes the color of
        //the accent color defined in style.dart depending on the theme
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  //Method is called when a url is first being processed
  //TODO: When deep linking is implemented, the url should be passed
  //to the loadData page with the action:start and from there everything should
  //work the same way
  void _start() async {
    //If there's no connection redirect to the noInternet page and pass the arguments
    //redirect and the redirect args, so that the noInternet page goes back to where the user
    //left off before the internet went out
    var connectionExists = await NoInternet.checkConnection();
    //In this case, if there is no internet, the redirect will tell the noInternet page to
    //come back to the loading page and retry from the start with the same arguments once
    //connection is restored
    //TODO: just an example of how redirect from noInternet would work
    if (connectionExists == false) {
      Navigator.pushReplacementNamed(context, "/noInternet", arguments: {
        'redirect': '/loadData',
        'redirectArgs': {
          'url': arguments['url'],
          'action': 'start',
        },
      });
    } else {
      //Getting all the information to check validity of the assessment
      var assessor = Handler.getAssessor(arguments['url']);
      var assessmentInfo = await Handler.getAssessmentInfo(assessor);
      var valid = await Handler.checkAssessmentValidity(assessmentInfo);
      //if an assessment is not valid, user will be redirected to the badAssessment page
      //along with the output of the checkAssessmentValidity function
      //which will be used to determine the error message to display
      if (valid == 0) {
        Navigator.pushReplacementNamed(context, '/badAssessment', arguments: {
          'valid': valid,
          'assessmentInfo': assessmentInfo,
        });
      } else {
        //if a connection does exist, move forward normally to listAssessments
        var peerAssessments = await Handler.getPeerAssessments(assessor);
        Navigator.pushReplacementNamed(context, '/listAssessments', arguments: {
          'assessor': assessor,
          'assessmentInfo': assessmentInfo,
          'peerAssessments': peerAssessments,
        });
      }
    }
  }
}
