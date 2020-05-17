

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/screens/analytics.dart';
import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/utilities/time_date.dart';
import 'package:flutter_app/widgets/NoteCard.dart';





//class FilteredView extends StatelessWidget {
//
//  List<dynamic> noteIds;
//
//  FilteredView(this.noteIds);
//
//  @override
//  Widget build(BuildContext context) {
//    return ;
//  }
//}


class FilteredView extends StatefulWidget {
  static const String routeName = 'filtered_view';

  List<dynamic> noteIds;

  FilteredView(this.noteIds);

  @override
  _FilteredView createState() => _FilteredView();
}

class _FilteredView extends State<FilteredView> {

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
                child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey.shade600,
                    size: 30.0
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
            elevation: 0,

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


                      FutureBuilder(
                          future: EntryModel.getBatch(widget.noteIds),
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


