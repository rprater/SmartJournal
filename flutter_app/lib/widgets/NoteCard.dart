




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/entry_model.dart';
import 'package:flutter_app/utilities/time_date.dart';

Widget myButton(BuildContext context, EntryModel entry, Function onTap, Function setState) {

  Color circleColor()
  {
    String time = TimeDate.time(entry.date);

    if(time.contains("PM"))
    {
      return TimeDate.getHour(entry.date) < 4? Colors.orange.shade800 : Colors.blue.shade900;
    }

    return TimeDate.getHour(entry.date) <= 6 ? Colors.yellow.shade300 : Colors.green.shade300;
  }

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
                  color: circleColor(),
                  borderRadius: BorderRadius.circular(40.0)),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${TimeDate.time(entry.date)}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          "${TimeDate.date(entry.date)}",
                          style: TextStyle(
                            fontSize: 19.0,
                          )
                      )
                  ),
                ]),
            Spacer(),
            Icon(Icons.navigate_next, color: Colors.black)
          ],
        ),
      ),
      onPressed: () {
        onTap(context, entry.id, setState);
      },
    ),
  );
}