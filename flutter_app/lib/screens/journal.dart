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

      backgroundColor: Colors.grey.shade200,
      
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [

                  Column(

                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.white,
                        child: Center(
                          child: Text("Search Box")
                        ),
                      ),
                      buildMyButtons()
                    ]
                  )
                  
                ],

              ),
            ),
          )
    );
    } 

    Center buildMyButtons()
    {
      // implement some logic to call the myButton method
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            SizedBox( height: 100 ),
            myButton("test", ""),
            myButton("test2", "")
          ]
        )
      );
    }
    
    Padding myButton(String textInput, String heading)
    {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(50.0, 20, 50, 20),
          color: Colors.white,
          focusColor: Colors.white,
          elevation: 10.0,
          child: Text(textInput)
        )
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