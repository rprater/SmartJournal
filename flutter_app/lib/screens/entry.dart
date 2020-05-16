import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:demoji/demoji.dart';


class Entry extends StatelessWidget {
  static const String routeName = 'entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
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
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),

                      // Date
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Saturday",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      Text(
                          "September 12",
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
                  "${Demoji.disappointed} ${Demoji.frowning_face} ${Demoji.neutral_face} ${Demoji.slightly_smiling_face} ${Demoji.grin}",
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
                    onTap: () {
//                      if (_noteSaved == true) {
//                        setState(() => _noteSaved = false);
//                      }
                    },
                    maxLines: null,
                    minLines: 20,
//                    controller: noteController,
                    decoration: InputDecoration(

                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Add notes..."
                    ),
                    style: TextStyle(
                      height: 2,
                    ),

                  ),
                )
              )
            ],

          ),
        )
      ),
    );
  }

}
