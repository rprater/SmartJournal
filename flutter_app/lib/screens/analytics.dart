import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/utilities/time_date.dart';

class Anylitics extends StatefulWidget {
  static const String routeName = 'analytics';

  @override
  _AnyliticsState createState() => _AnyliticsState();
}

class _AnyliticsState extends State<Anylitics> {
  String currentText = "Where";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Container(
              margin: EdgeInsets.only(left: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios,
                    color: Colors.grey.shade600, size: 30.0),
              ),
            ),
            title: Text(
              "Happy!",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            centerTitle: true,
            backgroundColor: kBackgroundColor,
            elevation: 0),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myButton("Where"),
                      myButton("Who"),
                      myButton("What"),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Expanded(child: myCards())])
              ],
            ),
          ),
        ));
  }

  Widget myCards() {
    String pickText() {
      if (currentText == "Where") return "This is where you are happiest!";
      if (currentText == "Who") return "This is who makes you the happiest!";
      return "This is when you are happiest!";
    }

    Widget card(String text) {
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
                        //  image: AssetImage("images/line.png"),
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.navigate_next, color: Colors.black)
                ]),
          ),
          onPressed: () {
            print("Clicked a button!");
          },
        ),
      );
    }

    Color pickColor() {
      if (currentText == "Where") return Colors.white;
      if (currentText == "Who") return Colors.grey.shade600;
      return Colors.orange;
    }

    Widget pickArbitraryCards()
    {
      if (currentText == "Where") 
      {
        return Column(
          children: <Widget> [
            card("Gym"),
            card("Home")
          ],
        );
      }
      if (currentText == "Who") 
      {
        return Column(
          children: <Widget> [
            card("Robert"),
            card("James")
          ],
        );
      }
      return Column(
        children: <Widget> [
            card("Coding"),
            card("Soccer")
        ],
      );
    }

    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(pickText(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 19.0,
            ))),
        pickArbitraryCards()
      ]),
    );
  }

  Widget myButton(String placement) {
    Color pickColor() {
      return placement == currentText
          ? Colors.grey.shade500
          : Colors.grey.shade400;
    }

    return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            child: RaisedButton(
                elevation: 10.0,
                color: pickColor(),
                hoverColor: Colors.grey.shade100,
                hoverElevation: 2.0,
                padding: EdgeInsets.symmetric(vertical: 20),
                onPressed: () {
                  setState(() {
                    print(placement + " clicked");
                    currentText = placement;
                  });
                },
                child: Text(placement, style: TextStyle(fontSize: 19.0)))));
  }

  Future<void> onTap(BuildContext context, int id) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Entry(id)));
    setState(() {});
  }
}
