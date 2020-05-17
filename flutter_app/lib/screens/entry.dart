import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter_app/models/analytics_model.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/utilities/sendRequests.dart';
import 'package:flutter_app/utilities/time_date.dart';
import 'package:provider/provider.dart';

class Entry extends StatefulWidget {
  static const String routeName = 'entry';
  final int id;

  Entry(this.id);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  TextEditingController noteController = TextEditingController();

  EntryModel entry = EntryModel(sentiment: 0, id: -1, date: 0, confidence: 0, body: "");
  double oldSentiment = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noteController.addListener(() {
      entry.body = noteController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> list = [
      {
        "name": "lot",
        "salience": 0.44694051146507263,
        "type": "OTHER"
      },
      {
        "name": "John",
        "salience": 0.18721692264080048,
        "type": "PERSON"
      },
      {
        "name": "bar",
        "salience": 0.1305219531059265,
        "type": "LOCATION"
      },
      {
        "name": "Jessie",
        "salience": 0.11365512013435364,
        "type": "PERSON"
      },
      {
        "name": "movies",
        "salience": 0.058914050459861755,
        "type": "WORK_OF_ART"
      },
      {
        "name": "home",
        "salience": 0.03135562688112259,
        "type": "LOCATION"
      },
    ];

    String getText(String time)
    {
      if(time.contains("PM"))
        return "afternoon";
      return "morning";
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {

          print("ADDING A DUMMY SENTIMENT");
          Random randomGen = Random();

          entry.sentiment = 1 - randomGen.nextDouble()*2;
          print("entry.sentiment: ${entry.sentiment} oldSentiment: $oldSentiment entry.sentiment - oldSentiment: ${entry.sentiment - oldSentiment}");
          if (entry.id == -1 && entry.body.length == 0) return true;

          int id = await entry.save();

          for (Map<String, dynamic> item in list) {
            if (item["type"] == "PERSON" || item["type"] == "LOCATION") {
              print(item["name"]);
              await AnalyticsModel.add(
                  val: item["name"],
                  type: item["type"],
                  id:id,
                  sentiment: entry.sentiment - oldSentiment,
              );
            }
          }
          print(" GOT HWERE< ABOUT TO GO ");
          await AnalyticsModel.add(
            val: DateTime.fromMillisecondsSinceEpoch(entry.date).hour.toString(),
            type: "TIME",
            id:id,
            sentiment: entry.sentiment - oldSentiment,
          );


          await AnalyticsModel.getAllAsMap();
          await AnalyticsModel.filter(type: "TIME");
          return true;
        },
        child: SafeArea(
            child: FutureBuilder(
          future: EntryModel.get(widget.id),
          builder: (BuildContext context, AsyncSnapshot<EntryModel> snapshot) {
            if (!snapshot.hasData) return Text("");

            entry = snapshot.data;
            oldSentiment = entry.sentiment;
            noteController.text = entry.body;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 30,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Command buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.maybePop(context);
                                    },
                                    child: Icon(Icons.arrow_back_ios, size: 30.0),
                                  ),
                                ),

                                // Delete
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await entry.delete();
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.delete_forever,
                                      size: 36.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // Date
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: 
                                    Row(
                                      children: <Widget> [
                                        Text(
                                            "${TimeDate.weekDay(entry.date)} ",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                            getText(TimeDate.time(entry.date)),
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                        ),
                                      ]
                                    ),
                                  ),
                                  Text("${TimeDate.date(entry.date)}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.grey))
                                ]
                            )
                          ],
                        ),
                      ),
                    ),

                    ChangeNotifierProvider(
                      builder: (context) => entry,
                      child: Container(
                          alignment: Alignment.center,
                          child: Consumer<EntryModel>(
                            builder: (context, e, child) {
                              return ToEmoji(e.sentiment);
                            },
                          )
                      ),

                    ),
            
                    // Top portion
                    Expanded(
                        flex: 70,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            /*image: DecorationImage(
                              image: AssetImage(
                                  "images/line.png"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.saturation,
                              ),
                            )
                              */
                          ),

                          child: TextField(
                            onChanged: (val) async {
//                              Map< String, dynamic> response = await Requests.sentimentAnalysis(val);
//                              entry.sentiment = response["score"];
//                              entry.confidence = response["magnitude"];
//                              print("s: ${entry.sentiment}");
//                              entry.notify();

                            },
                            maxLines: null,
                            minLines: 20,
                            controller: noteController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: "Add notes...",
                            ),

                            style: TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                              height: 2,
                            ),

                          ),
                        )
                    )
                  ]
                ),
              );
            },
          )
        ),
      ),
    );
  }
}





Widget ToEmoji(double sentiment) {

  String result = "";
  if (sentiment < -0.6)
    result = ("${Demoji.rage}");
  else if (-0.6 <= sentiment  && sentiment < -0.2)
    result = ("${Demoji.confused}");
  else if (-0.2 <= sentiment  && sentiment < 0.2)
    result = ("${Demoji.neutral_face}");
  else if (0.2 <= sentiment  && sentiment < -0.6)
    result = ("${Demoji.slightly_smiling_face}");
  else
    result = ("${Demoji.grinning}");

  return Text(
    result,
    style: TextStyle(
      fontSize: 50
    ),
  );


}









