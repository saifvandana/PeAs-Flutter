import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:peas/style.dart';

//This class provides a method to check the
//internet connectivity to the server
//Can be used before making any API calls

class NoInternet extends StatefulWidget {
  static Future<bool> checkConnection() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  //arguments contains the arguments coming from the previous route
  Map arguments = {};
  //timer to be used to periodically recheck the internet connection
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        //connection is rechecked every 3 seconds
        Duration(seconds: 3),
        (Timer t) => NoInternet.checkConnection().then((value) {
              if (value) {
                timer.cancel();
                if (arguments['redirect'] != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    arguments['redirect'],
                    arguments: arguments['redirectArgs'],
                  );
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    //Getting arguments coming from previous route
    arguments = ModalRoute.of(context).settings.arguments;

    return SafeArea(
        child: Scaffold(
      body: WillPopScope(
        onWillPop: () {
          //TODO: What to do on back pressed
          //Currently no way to go back
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.network_check,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Unable to connect to the internet.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 20),
                    ),
                    Text(
                      "Check your connection and try again.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: MaterialButton(
                color: Provider.of<AppStateNotifier>(context).isDarkMode
                    ? Style.darkButtonColor
                    : Style.lightButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  //TODO: What to do on press
                },
                child: Text(
                  "Try again",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
