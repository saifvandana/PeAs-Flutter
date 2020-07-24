import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/handler.dart';
import 'package:peas/routes/NoInternet.dart';
import 'package:peas/pe_as_icons_icons.dart';
import 'package:provider/provider.dart';
import 'package:peas/style.dart';
import 'package:day_night_switch/day_night_switch.dart';

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
    NoInternet.checkConnection().then((value) {
      if (value == false) {
        Navigator.pushNamed(context, '/noInternet',
            arguments: {'redirect': null});
      }
    });
  }

  //Form key to handle link input
  final formKey = GlobalKey<FormState>();
  final String _trueURL = Handler.baseAssessmentURL;
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
          //TODO: Fix scaling and alignment of switch
          //or find alternative widget
          //TODO: Fix hold and slide but no theme change issue
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Image.asset(
                      Provider.of<AppStateNotifier>(context).isDarkMode
                          ? Style.darkLogo
                          : Style.lightLogo,
                    ),
                  ),
                ),
                Spacer(),
                Transform.scale(
                  scale: 0.4,
                  child: DayNightSwitch(
                    value: Provider.of<AppStateNotifier>(context).isDarkMode,
                    moonImage: AssetImage(Style.darkMoonImage),
                    sunImage: AssetImage(Style.lightSunImage),
                    dayColor: Style.lightDayColor,
                    nightColor: Style.darkNightColor,
                    onChanged: (boolVal) {
                      Provider.of<AppStateNotifier>(context, listen: false)
                          .updateTheme(boolVal);
                    },
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 85,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          //subtitle1 is used for the URL input box text
                          style: Theme.of(context).textTheme.subtitle1,
                          autocorrect: false,
                          autofocus: false,
                          autovalidate: false,
                          keyboardType: TextInputType.url,
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              PeAsIcons.link,
                              //Force the use of iconTheme color
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: "Paste the evaluation link here...",
                            border: InputBorder.none,
                          ),
                          //To validate the URL before trying to fetch
                          validator: (input) => !input.startsWith(_trueURL)
                              ? "Not a valid evaluation link!"
                              : null,
                          onSaved: (input) {
                            _url = input;
                          },
                        ),
                      ),
                      //Arrow button to submit the entered URL
                      IconButton(
                          icon: Icon(PeAsIcons.right), onPressed: _submit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  //Submits input URL and goes to next step if valid
  void _submit() {
    //Will check the input fields with validation condition
    if (formKey.currentState.validate()) {
      //Updates the local url variable if valid
      formKey.currentState.save();

      //Removes focus from the textformfield on return to home route
      //TODO: Clear input box on return to home route
      FocusScope.of(context).unfocus();

      //Route to go to on submit
      //The arguments passed here will determine what to load
      Navigator.pushNamed(context, "/loadData",
          arguments: {'url': _url, 'redirect': null, 'action': 'start'});
    }
  }
}
