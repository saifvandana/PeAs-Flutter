import 'package:flutter/material.dart';

//Fetching and parsing HTML happens here
class LoadData extends StatefulWidget {
  @override
  _LoadData createState() => _LoadData();
}

class _LoadData extends State<LoadData> {
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    _getData();

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Text("Loading..."),
        ],
      )),
    );
  }

  //Getting and parsing happens here
  Future _getData() {
    return Future.delayed(const Duration(seconds: 2), () {
      if (arguments['url'] == "badLink") {
        Navigator.pushReplacementNamed(context, '/badAssessment');
      } else {
        //If link is not expired or sth go here
        //Pass to the next screen the data that has been loaded
        Navigator.pushReplacementNamed(context, '/list', arguments: {
          'data':
              'data that has been loaded and will be used in the next screen goes here',
        });
      }
    });
  }
}
