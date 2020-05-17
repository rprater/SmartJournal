import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/analytics_model.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/screens/filtered_view.dart';
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
                  color: Colors.grey.shade600, size: 30.0
              ),
            ),
          ),
          title: Text(
            "Dashboard",
            style: TextStyle(
                color: Colors.grey.shade600
            ),
          ),
          centerTitle: true,
          backgroundColor: kBackgroundColor,
          elevation: 0
        ),
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
                      myButton("Where", left: true),
                      myButton("Who"),
                      myButton("When", right: true),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: myCards()
                      )
                    ]
                )
              ],
            ),
          ),
        )
    );
  }

  AssetImage pickImage(String text)
  {
    if(currentText == "Where")
      return AssetImage("images/building.png");
    if(currentText == "Who")
      return AssetImage("images/person.png");
    return AssetImage("images/time.png");
  }

  Widget myCards() {

    String pickText() {
      if (currentText == "Where") return "This is where you are the happiest!";
      if (currentText == "Who") return "This is who makes you the happiest!";
      return "This is when you are the happiest!";
    }

    Widget card(AnalyticsModel model) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 14),

        child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 8.0),
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
                  margin: EdgeInsets.only(left: 10, right: 20),
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    image: DecorationImage (
                      image: pickImage(model.value),
                      fit: BoxFit.fill
                    ),
                    borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                Text(
                  "${model.value}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 19.0,
                  ),
                ),
                Spacer(),
                Icon(Icons.navigate_next, color: Colors.black)
              ]
            ),
          ),
          onPressed: () async {

            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilteredView(model.occurrences))
            );
          },
        ),
      );
    }

    Future<Widget> releventCards() async {


      String type = "LOCATION";
      if (currentText == "Who")
        type = "PERSON";
      else if (currentText == "When")
        type = "TIME";

      List<AnalyticsModel> theCards = await AnalyticsModel.filter(type: type);
      print(theCards);

      List<Widget> lst = [];
      for (AnalyticsModel analytic in theCards)
        lst.add(card(analytic));

      return Column(children: lst);

    }

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              pickText(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 19.0,
              )
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: FutureBuilder(
              future: releventCards(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (!snapshot.hasData)
                  return Text("");
                return snapshot.data;
              }
            )
          )
        ]
      ),
    );
  }


  Widget myButton(String placement, {bool right=false, bool left=false}) {
    BorderRadiusGeometry border = BorderRadius.only();

    if (right)
      border = BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20));
    else if (left)
      border = BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20));

    return Expanded(
      child: Container(
        child: RaisedButton(
          elevation: 1.0,
          color: placement == currentText ? Colors.grey.shade500 : Colors.grey.shade400,
          hoverColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
              borderRadius: border,
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          onPressed: () {
            setState(() {
              print(placement + " clicked");
              currentText = placement;
            }
            );
          },
          child: Text(placement, style: TextStyle(fontSize: 19.0)
          )
        )
      )
    );
  }

  Future<void> onTap(BuildContext context, int id) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Entry(id)));
    setState(() {});
  }
}
