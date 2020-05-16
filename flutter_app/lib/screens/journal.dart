import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                    // has to be implemented in DB
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                        child: Text("Search Entries",
                            style: TextStyle(
                              fontSize: 19.0,
                            ))),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  buildMyButtons()
                ])
              ],
            ),
          ),
        ));
  }

  Column buildMyButtons() {
    // implement some logic to call the myButton method
    return Column(children: <Widget>[
      myButton("September 12", "7:00 pm"),
      myButton("September 11", "11:00 pm"),
      myButton("September 10", "10:00 pm"),
      myButton("September 9", "9:00 pm"),
      myButton("September 9", "8:00 pm"),
      myButton("September 9", "1:00 pm")
    ]);
  }

  void onTap(String text) {
    print("This card has been clicked " + text);
  }

  Padding myButton(String cardName, String date) {
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
                  margin: EdgeInsets.fromLTRB(8, 8, 20, 8),
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      borderRadius: BorderRadius.circular(40.0)),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(date),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(cardName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19.0,
                              ))),
                    ]),
                Spacer(),
                Icon(Icons.navigate_next, color: Colors.black)
              ],
            ),
            onPressed: () {
              onTap(cardName);
            },
          ),
        ));
  }
}

class FlutterSearchBar extends StatefulWidget{
  @override
  FlutterText createState() => FlutterText();
}

class FlutterText extends State<FlutterSearchBar>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold();
  }
}