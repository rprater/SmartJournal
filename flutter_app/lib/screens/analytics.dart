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
              ),
            ),
          ),
          title: Text(
            "Happy!",
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


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
}
