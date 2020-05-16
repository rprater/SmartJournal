import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/entry.dart';

class Journal extends StatelessWidget {

  static const String routeName = 'entry_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.apps),
            tooltip: 'Open the apps',
            onPressed: () {
              print("Open up a list of apps");
            },
          )
        ]
      ),

      backgroundColor: kBackgroundColor,

      /*
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [

                   Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child:
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(Entry.routeName);
                              },
                              child: Icon(Icons.edit),
                            ),
                        ),
                        Text("Journal"),
                        Text("List View Button")
                      ],
                    ),

                  Column(
                    children: <Widget>[
                       Text("Nihal"),
                       JournalButton()
                    ]
                  )
                ],
              ),
            ),
          )
      ), */
    );
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
  Widget build(BuildContext context)
  { 
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: new RaisedButton(
          child: Text("Click Here"),
          onPressed: () => {
            print("The Button was Pressed")
          },
        )
      );
  }
}