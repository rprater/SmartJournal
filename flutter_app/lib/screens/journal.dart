import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/entry.dart';

class Journal extends StatelessWidget {

  static const String routeName = 'entry_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Entry.routeName);
                    },
                    child: Icon(Icons.edit),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

}