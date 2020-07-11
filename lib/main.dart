import 'package:flutter/material.dart';
import 'package:peas/AppStateNotifier.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(),
      body: Switch(
        value: Provider.of<AppStateNotifier>(context).isDarkMode,
        onChanged: (boolVal) {
          Provider.of<AppStateNotifier>(context, listen: false)
              .updateTheme(boolVal);
        },
      ),
    );
  }
}
