import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/assessmentInfo.dart';
import 'package:peas/handler.dart';
import 'package:peas/peerAssessment.dart';
import 'package:peas/rating_bar.dart';
import 'package:peas/style.dart';
import 'package:provider/provider.dart';

class Evaluation extends StatefulWidget {
  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    PeerAssessment peerAssessment = arguments['peerAssessment'];
    AssessmentInfo assessmentInfo = arguments['assessmentInfo'];
    var numOfDimensions = assessmentInfo.dimensionNames.indexOf(null);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Evaluation',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                (peerAssessment.fname + ' ' + peerAssessment.lname),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
              ),
            ),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            Flexible(
                flex: 3,
                child: ListView.builder(
                    itemCount: numOfDimensions,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              assessmentInfo.dimensionNames[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    height: 2,
                                  ),
                            ),
                            Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            RatingBar(
                              maxRating: 5,
                              initialRating: peerAssessment
                                      .dimensionRatings[index]
                                      .toDouble() ??
                                  0,
                              onRatingChanged: (rating) {
                                setState(() {
                                  peerAssessment.dimensionRatings[index] =
                                      rating.toInt();
                                });
                              },
                              size: 48,
                            ),
                          ],
                        ),
                      );
                    })),
            Flexible(
              flex: 1,
              child: TextFormField(
                initialValue: peerAssessment.comments,
                autofocus: false,
                onChanged: (value) {
                  peerAssessment.comments = value;
                },
                maxLength: null,
                decoration: InputDecoration(hintText: "Comments"),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: 100,
          height: 40,
          child: FloatingActionButton(
            onPressed: () async {
              await Handler.postAssessmentUpdate(peerAssessment);
              final snackBar = SnackBar(
                content: Text('Assessment successfully submitted'),
                duration: Duration(seconds: 1),
              );
              scaffoldKey.currentState
                  .showSnackBar(snackBar)
                  .closed
                  .then((value) {
                if (arguments['redirect'] == null) {
                  Navigator.pop(context);
                }
              });
              // else {
              //   Navigator.pushNamed(
              //     context,
              //     arguments['redirect'],
              //     arguments: arguments['redirectArgs'],
              //   );
              // }
            },
            backgroundColor: Provider.of<AppStateNotifier>(context).isDarkMode
                ? Style.darkGreenColor
                : Style.lightGreenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  (arguments['redirect'] == null) ? 'Submit' : 'Next',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0,
                  ),
                ),
                Icon(
                  (arguments['redirect'] == null)
                      ? Icons.check
                      : Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
