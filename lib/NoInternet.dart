import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';

class NoInternet extends StatefulWidget {
  //TODO: Change URL to server
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
  Map arguments = {};
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 3),
        (Timer t) => NoInternet.checkConnection().then((value) {
              if (value) {
                timer.cancel();
                if (arguments['goBack']) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(
                      context, arguments['nextRoute'],
                      arguments: {'url': 'sth'});
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("No internet"),
        //automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          //What to do on back pressed
        },
        child: Column(
          children: [
            Text("Retrying connection..."),
          ],
        ),
      ),
    ));
  }
}
