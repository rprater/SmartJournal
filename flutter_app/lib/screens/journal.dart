import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/utilities/time_date.dart';

class Journal extends StatefulWidget {
  static const String routeName = 'entry_list';

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  String currentText = "";
  final myController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    myController.addListener(() {
      if (myController.text.isEmpty) {
        setState(() {
          currentText = "";
        });
      } else {
        setState(() {
          currentText = myController.text;
        });
      }
    });

    return Scaffold(
        appBar: AppBar(
            leading: Container(
              margin: EdgeInsets.only(left: 30),
              child: GestureDetector(
                onTap: () {
                  onTap(context, -1);
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.grey.shade600,
                  size: 30.0
                ),
              ),
            ),
            title: Text(
              "Journal",
              style: TextStyle(
                color: Colors.grey.shade600
              ),
            ),
            centerTitle: true,
            backgroundColor: kBackgroundColor,
            elevation: 0,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 30),
                child: IconButton(
                  icon: Icon(
                    Icons.apps,
                    color: Colors.grey.shade600,
                    size: 36.0
                  ),
                  tooltip: 'Open the apps',
                  onPressed: () {
                    print("Open up a list of apps");
                  },
                ),
              )
            ]
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    // search bar
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)
                      ),


                      child: Row(
                        children: [

                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: myController,
                              onTap: () {
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: "Search entries..."
                              ),
                              style: TextStyle(
                                height: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Icon(
                              Icons.search,
                              color: Colors.grey.shade400
                            ),
                          )
                        ],
                      ),

                    ),
                    FutureBuilder(
                      future: EntryModel.getFilteredText(currentText),
                      builder: (BuildContext context, AsyncSnapshot<List<EntryModel>> snapshot) {
                      if (!snapshot.hasData)
                        return Text("None");
                      List<EntryModel> entries = snapshot.data;

                      List<Widget> children = List();
                      for (EntryModel entry in entries) {
                        children.add(myButton(context, entry));
                      }
                      
                      return Column(
                        children: children
                      );
                    }
                    ),

                  ]
                )
              ],
            ),
          ),
        ));
  }

  Future<void> onTap(BuildContext context, int id) async {
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Entry(id))
    );
    setState(() {});
  }

  Widget myButton(BuildContext context, EntryModel entry) {

    Color circleColor()
    {
      String time = TimeDate.time(entry.date);

      if(time.contains("PM"))
      {
        return TimeDate.getHour(entry.date) < 4? Colors.orange.shade800 : Colors.blue.shade900;
      }

      return TimeDate.getHour(entry.date) <= 6 ? Colors.yellow.shade300 : Colors.green.shade300;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 13),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
        ),
        color: Colors.white,
        elevation: 1.0,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                    color: circleColor(),
                    borderRadius: BorderRadius.circular(40.0)),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${TimeDate.time(entry.date)}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "${TimeDate.date(entry.date)}",
                            style: TextStyle(
                              fontSize: 19.0,
                            )
                        )
                    ),
                  ]),
              Spacer(),
              Icon(Icons.navigate_next, color: Colors.black)
            ],
          ),
        ),
        onPressed: () {
          onTap(context, entry.id);
        },
      ),
    );
  }
}