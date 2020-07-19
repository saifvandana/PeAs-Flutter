import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/NoInternet.dart';
import 'package:provider/provider.dart';
import 'package:peas/style.dart';

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
    //SafeArea to be independent of device display differences
    return SafeArea(
        //Scaffold necessary as Material ancestor to Switch
        child: Scaffold(
      body: Column(
        children: [
          Image.asset(
            Provider.of<AppStateNotifier>(context).isDarkMode
                ? Style.darkLogo
                : Style.lightLogo,
            fit: BoxFit.cover,
          ),
          Switch(
            value: Provider.of<AppStateNotifier>(context).isDarkMode,
            onChanged: (boolVal) {
              Provider.of<AppStateNotifier>(context, listen: false)
                  .updateTheme(boolVal);
            },
          ),
          Form(
            key: formKey,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Paste the link here...",
              ),
              //input validation condition goes here
              validator: (input) =>
                  !input.contains(_trueURL) ? "Not a valid link" : null,
              onSaved: (input) {
                _url = input;
              },
            ),
          ),
          IconButton(icon: Icon(Icons.arrow_forward), onPressed: _submit),
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
