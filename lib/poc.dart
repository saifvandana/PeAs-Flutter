import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peas/handler.dart';
import 'bloc.dart';

final String trueURL = Handler.baseAssessmentURL;
//User's clicked URL
String url;

class PocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              child: Center(
                  child: Text('No deep link was used!',
                      style: Theme.of(context).textTheme.headline6)));
        } else {
          url = snapshot.data;
          if (!url.startsWith(trueURL)){
            return Container(
                child: Center(
                  child: Text("Not a valid evaluation link!",
                      style: Theme.of(context).textTheme.headline6)));
          } else {
            return Container(
              child: Center(
                child: EvaluationButton()
            ));
          }
        }
      },
    );

     
  }
}

class EvaluationButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context, "/loadData",
                  arguments: {'url': url, 'redirect': null, 'action': 'start'},
                  );
              },
              textColor: Colors.black87,
              padding: const EdgeInsets.all(0.5),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green ,Colors.lightGreenAccent, Colors.green],
                  ),
                ),
                padding: const EdgeInsets.all(21.0),
                child: const Text('Go to Peer Evaluation', style: TextStyle(fontSize: 20)),
              ),
            ),
    );
  }
}