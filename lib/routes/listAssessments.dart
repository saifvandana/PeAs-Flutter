import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/assessmentInfo.dart';
import 'package:peas/assessor.dart';
import 'package:peas/peerAssessment.dart';
import 'package:peas/style.dart';
import 'package:provider/provider.dart';

/*
Displays the teammates and the assessment deadline
Each teammate is displayed on a card which when clicked will take
the user to the evaluation page for that teammate
*/

class ListAsessments extends StatefulWidget {
  @override
  _ListAsessmentsState createState() => _ListAsessmentsState();
}

class _ListAsessmentsState extends State<ListAsessments> {
  //will hold the arguments coming from the previous route
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    //Getting the arguments coming from the previous route
    arguments = ModalRoute.of(context).settings.arguments;
    Assessor assessor = arguments['assessor'];
    AssessmentInfo assessmentInfo = arguments['assessmentInfo'];
    List<PeerAssessment> peerAssessments = arguments['peerAssessments'];

    //The deadline to show for the assessment
    var endDay = assessmentInfo.endTime.day.toString();
    var endMonth = assessmentInfo.endTime.month.toString();
    var endYear = assessmentInfo.endTime.year.toString();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //Course name goes here
          title: Text(
            assessmentInfo.course,
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
                //Displaying the project name
                "Evaluate your team for " + assessmentInfo.projectName,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 18,
                      height: 2,
                    ),
              ),
            ),
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "You have until $endDay/$endMonth/$endYear to complete this assessment",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 18,
                    ),
              ),
            ),
            Divider(
              height: 10,
              color: Colors.transparent,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: peerAssessments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: ListTile(
                        //Redirect to evaluation page for a particular teammate
                        onTap: () {
                          Navigator.pushNamed(context, "/evaluation",
                              arguments: {
                                'redirect': null,
                                'peerAssessment': peerAssessments[index],
                                'assessmentInfo': assessmentInfo,
                              });
                        },
                        title: Text(
                          peerAssessments[index].fname +
                              ' ' +
                              peerAssessments[index].lname,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        //Checking if the assessment has been done or not
                        //If all ratings are 0 and comments are empty then it is not done
                        //else it is
                        //the trailing icon to show is decided based on this
                        trailing: (peerAssessments[index]
                                    .dimensionRatings
                                    .every((element) => element == 0) &&
                                peerAssessments[index].comments == '')
                            ? Icon(
                                Icons.assignment_late,
                                color: Colors.red,
                              )
                            : Icon(Icons.assignment_turned_in,
                                color: Provider.of<AppStateNotifier>(context)
                                        .isDarkMode
                                    ? Style.darkGreenColor
                                    : Style.lightGreenColor),
                      ),
                    );
                  }),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: 180,
          height: 40,
          child: FloatingActionButton(
            //Currently not implemented
            //TODO: Implement the begin assessment button
            //When clicked it should automatically take the user through
            //each evaluation page unlike clicking on an individual teammates card
            //This should be done by passing the redirect route 'redirect' in the arugments
            //and a redirectArgs array containing the peerAssessment and AssessmentInfo
            //objects for each temmate
            onPressed: () {
              //What should happen on pressing the begin assessment button
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
                  "Begin assessment ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
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
