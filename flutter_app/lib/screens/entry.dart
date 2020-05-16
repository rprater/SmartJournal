import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter_app/models/entry_model.dart';


class Entry extends StatefulWidget {


  static const String routeName = 'entry';
  final int id;

  Entry(this.id);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {

  TextEditingController noteController = TextEditingController();

  EntryModel entry = EntryModel(
    sentiment: 0,
    id: -1,
    date: 0,
    confidence: 0,
    body: ""
  );

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

    int x = widget.id;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          await entry.update();
          return true;
        },
        child: SafeArea(
          child: FutureBuilder(
            future: EntryModel.get(widget.id),
            builder: (BuildContext context, AsyncSnapshot<EntryModel> snapshot) {
              if (!snapshot.hasData)
                return Text("");

              entry = snapshot.data;
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
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            // Back btn
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.maybePop(context);
                                },
                                child: Icon(Icons.arrow_back_ios),
                              ),
                            ),

                            // Date
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                "${entry.date}",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            Text(
                                "${entry.date}",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${Demoji.rage} ${Demoji.confused} ${Demoji.neutral_face} ${Demoji.slightly_smiling_face} ${Demoji.grinning}",
                        style: TextStyle(
                            fontSize: 40
                        ),
                      ),
                    ),


                    // Top portion
                    Expanded(
                        flex: 70,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: Colors.white
                          ),

                          child: TextField(
                            onChanged: (val) {
//                              entry.body = val;
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
                              height: 2,
                            ),

                          ),
                        )
                    )
                  ],

                ),
              );
            },
          )
        ),
      ),
    );
  }
}
