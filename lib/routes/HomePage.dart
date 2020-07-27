import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/handler.dart';
import 'package:peas/routes/NoInternet.dart';
import 'package:peas/routes/TutorialPage.dart';
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
  //The internet connection is checked on app startup
  //If there is no connection, app will redirect to the noInternet page
  //TODO: depending on how deep linking is implemented, internet checking should be
  //added on app startup
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
  //The correct assessment url to compare the user's input url to
  //Taken from the Handler class, baseAssessmentURL
  final String _trueURL = Handler.baseAssessmentURL;
  //User's input URL
  String _url;

  @override
  Widget build(BuildContext context) {
    //SafeArea ensures the widgets will not be covered by
    //device specific display differences like notches
    return SafeArea(
        //A Scaffold is necessary as a Material ancestor to Switch
        child: Scaffold(
      body: Column(
        children: [
          //TODO: Fix scaling and alignment of switch
          //Currently the switch has to be scaled down to fit properly
          //This leaves some space on the right side of the switch, not intentional
          //or find alternative widget
          //TODO: Fix hold and slide but no theme change issue
          //Currently the switch works if it is tapped on
          //but if a user attempts to slide the switch, the graphic moves
          //but the theme will not be updated until the next switch tap
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
                      //Selecting which logo to display based on the theme
                      Provider.of<AppStateNotifier>(context).isDarkMode
                          ? Style.darkLogo
                          : Style.lightLogo,
                    ),
                  ),
                ),
                Spacer(),
                //By default the dayNight switch is too large
                //Had to be scaled down
                //Not ideal solution as marked above
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
                          //Autocorrect being false let's the user's keyboard
                          //know not to attempt to correct the entered url
                          autocorrect: false,
                          autofocus: false,
                          autovalidate: false,
                          //This notifies the phone to bring up a keyboard which
                          //makes entering links easier
                          //such as having the / symbol ready
                          keyboardType: TextInputType.url,
                          //Does not allow the user to type in multiple lines
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              //Custom icon defined in the pe_as_icons_icons.dart file
                              PeAsIcons.link,
                              //Force the use of iconTheme color
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: "Paste the evaluation links here..",
                            border: InputBorder.none,
                          ),
                          //To validate the URL before trying to fetch
                          //TODO: fix styling of invalid link message
                          //The colors for the error message in dark and light theme
                          //need to be set
                          //Currently, the error message shows up outside the input box
                          validator: (input) => !input.startsWith(_trueURL)
                              ? "Not a valid evaluation link!"
                              : null,
                          //onSaved is called after the input in validated
                          onSaved: (input) {
                            _url = input;
                          },
                        ),
                      ),
                      //Arrow button to submit the entered URL
                      //Calls the method _submit when the button is clicked
                      IconButton(
                          icon: Icon(PeAsIcons.right), onPressed: _submit),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TutorialButton(),
        ],
      ),
    ));
  }

  //Submits input URL and goes to next step if valid
  void _submit() {
    //Will check the input fields with validation condition
    //defined in the validator
    if (formKey.currentState.validate()) {
      //Updates the local url variable if valid
      formKey.currentState.save();

      //Removes focus from the textformfield on return to home route
      //TODO: Clear input box on return to home route
      //Currently, after finishing an assessment and coming back to the homepage
      //the old url still shows in the input box, needs to be cleared
      FocusScope.of(context).unfocus();

      //Route to go to on submit
      //The arguments passed here will determine what to load
      //Since the url is just entered, the data needs to be loaded from the beginning
      //Pushes loadData and passes it the url along with the action: start
      //start tells loadData that all the data needs to be loaded from the beginning
      Navigator.pushNamed(context, "/loadData",
          arguments: {'url': _url, 'redirect': null, 'action': 'start'});
    }
  }

  
}

class TutorialButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstPage()),
                  );
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.5),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A2),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(21.0),
                child: const Text('Peer Assessment', style: TextStyle(fontSize: 20)),
              ),
            ),
    );
  }
}
