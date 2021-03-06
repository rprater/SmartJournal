import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/screens/analytics.dart';
import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/utilities/time_date.dart';
import 'package:flutter_app/widgets/NoteCard.dart';

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
                  onTap(context, -1, setState);
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
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Anylitics() )
                    );
                    setState(() {});
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
                        children.add(myButton(context, entry, onTap, setState));
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


}

 onTap(BuildContext context, int id, Function setState) async {
  await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Entry(id))
  );
  setState(() {});
}

