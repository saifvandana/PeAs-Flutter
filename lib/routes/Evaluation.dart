import 'package:flutter/material.dart';
import 'package:peas/rating_bar.dart';

class Evaluation extends StatefulWidget {
  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  Map arguments = {};

  //Test variables to store ratings and comments
  String _comments;
  var _rating;
  Map nums = {};

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Evaluation"),
      ),
      body: Column(
        children: <Widget>[
          Text("TeamMember1"),
          Flexible(
              flex: 3,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Dimension" + index.toString()),
                          RatingBar(
                            maxRating: 5,
                            initialRating: nums[index] ?? 0,
                            onRatingChanged: (rating) {
                              setState(() {
                                _rating = rating;
                                nums[index] = rating;
                                print(_rating);
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
              autofocus: false,
              onChanged: (value) {
                _comments = value;
                print(_comments);
              },
              maxLength: null,
              decoration: InputDecoration(hintText: "Comments"),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: BottomAppBar(
                    child: FlatButton.icon(
                  color: Colors.green,
                  onPressed: () {
                    if (arguments['end'] == true) {
                      //First go to loading screen and pop until list over there
                      Navigator.popUntil(context, ModalRoute.withName('/list'));
                    } else {
                      Navigator.pushNamed(context, "/evaluation",
                          arguments: {'url': "fdf", 'end': true});
                    }
                  },
                  label: Text(arguments['end'] == false ? "Next" : "Submit"),
                  icon: Icon(Icons.arrow_forward),
                )),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
