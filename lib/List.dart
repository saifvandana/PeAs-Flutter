import 'package:flutter/material.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  Map arguments = {};

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //Course name goes here
          title: Text("Course"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Text(
                "Hey, fname",
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: <Widget>[
                  Text("Evaluate your team for projectName"),
                  Spacer(),
                  Flexible(child: Text("You have until date")),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text("Member Name" + index.toString()),
                        trailing: Icon(Icons.check_circle),
                      ),
                    );
                  }),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: BottomAppBar(
                      child: FlatButton.icon(
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, "/evaluation",
                          arguments: {'url': "fdf", 'end': false});
                    },
                    label: Text(
                      "Begin evaluation",
                    ),
                    icon: Icon(Icons.arrow_forward),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
