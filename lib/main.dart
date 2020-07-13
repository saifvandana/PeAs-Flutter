import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: PeAs(),
    ),
  );
}

class PeAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.bottom]); //Hides Android status bar
      return MaterialApp(
          title: 'PeAs',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: HomePage(title: 'PeAs'),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "APP BAR TEXT",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(40, 70, 0, 0),
            child: Switch(
              value: Provider.of<AppStateNotifier>(context).isDarkMode,
              onChanged: (boolVal) {
                Provider.of<AppStateNotifier>(context, listen: false)
                    .updateTheme(boolVal);
              },
            ),
          )
        ],
      ),
    );
  }
}
