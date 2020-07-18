import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/NoInternet.dart';
import 'package:provider/provider.dart';

/*
  Main page of the app
  Displays logo, theme switch, and URL input box
*/
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    /* 
    TODO: Check internet connection on startup
    and push NoInternet with back, no redirect
    */
  }

  //Form key to handle link input
  final formKey = GlobalKey<FormState>();
  //Correct URL used to validate input URL
  final String _trueURL = '';
  //User's input URL
  String _url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  //Logo and dark mode switch
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.cover,
                          ),
                        )),
                    Spacer(flex: 1),
                    Switch(
                      value: Provider.of<AppStateNotifier>(context).isDarkMode,
                      onChanged: (boolVal) {
                        Provider.of<AppStateNotifier>(context)
                            .updateTheme(boolVal);
                      },
                    ),
                  ],
                ),
              )),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Row(
                //Message above paste box
                children: <Widget>[
                  Text(
                    "Paste the evaluation link and press go!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )),
          Flexible(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 2,
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Paste the link here...",
                          ),
                          //input validation condition goes here
                          validator: (input) => !input.contains(_trueURL)
                              ? "Not a valid link"
                              : null,
                          onSaved: (input) {
                            _url = input;
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward), onPressed: _submit),
                ],
              )),
        ],
      ),
    ));
  }

  //Submits input URL and goes to next step if valid
  void _submit() {
    //Will check the input fields with validation condition
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      //The arguments passed here will determine what to load
      NoInternet.checkConnection().then((value) {
        if (!value) {
          Navigator.pushNamed(context, "/noInternet", arguments: {
            'nextRoute': '/loadData',
            'goBack': false,
            'url': _url
          });
        } else {
          Navigator.pushNamed(context, "/loadData", arguments: {'url': _url});
        }
      });
      //Removes focus from the textformfield on return to home route
      FocusScope.of(context).unfocus();
    }
  }
}
