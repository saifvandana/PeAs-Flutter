import 'package:flutter/material.dart';
import 'package:peas/assessmentInfo.dart';

class BadAssessment extends StatefulWidget {
  @override
  _BadAssessmentState createState() => _BadAssessmentState();
}

class _BadAssessmentState extends State<BadAssessment> {
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    AssessmentInfo assessmentInfo = arguments['assessmentInfo'];
    var endDay = assessmentInfo.endTime.day.toString();
    var endMonth = assessmentInfo.endTime.month.toString();
    var endYear = assessmentInfo.endTime.year.toString();
    var startDay = assessmentInfo.startTime.day.toString();
    var startMonth = assessmentInfo.startTime.month.toString();
    var startYear = assessmentInfo.startTime.year.toString();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: WillPopScope(
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
