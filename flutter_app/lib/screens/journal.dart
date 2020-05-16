import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/entry.dart';
import 'dart:math';

class Journal extends StatelessWidget {
  static const String routeName = 'entry_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Entry.routeName);
              },
              child: Icon(Icons.edit),
            ),
            title: Text("Journal"),
            centerTitle: true,
            backgroundColor: const Color(0x9F9A90),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.apps),
                tooltip: 'Open the apps',
                onPressed: () {
                  print("Open up a list of apps");
                },
              )
            ]),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Center(child: Text("Search Box")),
                  ),
                  buildMyButtons()
                ])
              ],
            ),
          ),
        ));
  }

  Center buildMyButtons() {
    // implement some logic to call the myButton method
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(height: 100),
      myButton("September 12", "7:00 pm", 0xFFFFFF),
      myButton("September 11", "11:00 pm", 0xFFFFF)
    ]));
  }

  Padding myButton(String cardName, String date, int color1) {
    double elementHeight = 60.0;
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: ButtonTheme(
          height: elementHeight,
          child: RaisedButton(
            color: Colors.white,
            elevation: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(8,8,20,8),
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)], borderRadius: BorderRadius.circular(40.0)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(date),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0), 
                      child: Text(
                        cardName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                        )
                      )
                    ),
                  ]
                ),
                Spacer(),
                Icon(
                  Icons.navigate_next, color: Colors.black
                )
              ],
            ),
            onPressed: () {
              print("direct to a card");
            },
          ),
        ));
  }
}

class JournalButton extends StatefulWidget {
  final String startColor = "Red";
  final String buttonText = "Blue";

  @override
  State<StatefulWidget> createState() {
    return new RaisedButtonState();
  }
}

class RaisedButtonState extends State<JournalButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: new RaisedButton(
          child: Text("Click Here"),
          onPressed: () => {print("The Button was Pressed")},
        ));
  }
}
