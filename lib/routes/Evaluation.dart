import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/assessmentInfo.dart';
import 'package:peas/handler.dart';
import 'package:peas/peerAssessment.dart';
import 'package:peas/rating_bar.dart';
import 'package:peas/style.dart';
import 'package:provider/provider.dart';

/*
This is the page where the rating and writing comments is done
*/

class Evaluation extends StatefulWidget {
  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  //will hold the arugments coming from the previous route
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    //Getting the arguments from the previous route
    arguments = ModalRoute.of(context).settings.arguments;
    //Pulling out some objects from the arguments
    PeerAssessment peerAssessment = arguments['peerAssessment'];
    AssessmentInfo assessmentInfo = arguments['assessmentInfo'];
    //Counting the number of dimensions in the assessment based on the
    //index of the first occurence of null
    //The actual dimensions are assumed to be strings
    var numOfDimensions = assessmentInfo.dimensionNames.indexOf(null);
    //need key to display the snackbar on assessment submit
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Assessment',
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
              //Display the peer's name and surname
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
                            //Display the name of the dimension
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
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Comments",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Provider.of<AppStateNotifier>(context).isDarkMode
                        ? Style.darkAccentColor
                        : Style.lightAccentColor,
                  )),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          //TODO: button covers comments input when keyboard is open
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
                //The evaluation page receives a redirect argument
                //If the user chooses one teammate in the listAssessments screen
                //the redirect is null
                if (arguments['redirect'] == null) {
                  Navigator.pop(context);
                }
                //TODO: going through all assessment when clicking 'Begin assessment' on the
                //listAssessments page
                //If the user clicks the 'Begin assessment' button on the listAssessments page
                //rather than selecting one teammate, they should automatically be taken through
                //all the evaluation pages of all the teammates without having to click on them
                //individually
                //That is what the redirect is used for
                //An array of all the evaluation pages along with their arguments
                //could be passed in redirectArgs to cycle through all the pages before
                //returning back to the listAssessments page
              });
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
                //If a redirect exists the button should display next
                //instead of submit and then taken to the next teammate's
                //evaluation page after submission
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
