import 'package:flutter/material.dart';
import 'package:peas/assessmentInfo.dart';

/*
This is the page to show that an assessment
is currently invalid due to it either being expired
or not started yet
*/

class BadAssessment extends StatefulWidget {
  @override
  _BadAssessmentState createState() => _BadAssessmentState();
}

class _BadAssessmentState extends State<BadAssessment> {
  //will hold the arguments coming from the previous route
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    //Getting the arguments from the previous route
    arguments = ModalRoute.of(context).settings.arguments;
    //Pulling out some constants from the arguments
    AssessmentInfo assessmentInfo = arguments['assessmentInfo'];

    //The starting or end dates to display in the error message
    var endDay = assessmentInfo.endTime.day.toString();
    var endMonth = assessmentInfo.endTime.month.toString();
    var endYear = assessmentInfo.endTime.year.toString();
    var startDay = assessmentInfo.startTime.day.toString();
    var startMonth = assessmentInfo.startTime.month.toString();
    var startYear = assessmentInfo.startTime.year.toString();

    return SafeArea(
        child: Scaffold(
      //App bar to show back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: WillPopScope(
        //When the user presses the back button (screen or device)
        //The navigator will go all the way back to the homescreen
        onWillPop: () {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
          return Future.value(true);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.error_outline,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Text(
                        (arguments['valid'] == -1)
                            ? "The assessment period has not started yet."
                            : "The assessment period has expired.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20,
                            )),
                    Text(
                      (arguments['valid'] == -1)
                          ? "It will begin on $startDay/$startMonth/$startYear, try again later."
                          : "It expired on $endDay/$endMonth/$endYear.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16, height: 2.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
