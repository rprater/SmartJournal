import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

class Entry extends StatelessWidget {

  static const String routeName = 'entry';

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
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
              ],

            ),
          ),
        )
      ),
    );
  }

}
