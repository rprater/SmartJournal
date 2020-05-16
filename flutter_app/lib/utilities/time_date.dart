




class TimeDate {


  static int currentDateStamp() {

    return DateTime.now().millisecondsSinceEpoch;
  }

  static String time(int timeStamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    int hour = date.hour > 12 ? date.hour % 12 : date.hour;
    String am_pm = date.hour < 12 ? "AM" : "PM";
    int min = date.minute;


    String min_str =  (min < 10 ? "0" : "") + "${min}";

    return "$hour:$min_str $am_pm";
  }

  static String weekDay(int timeStamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    if (date.weekday == 0) return "Sunday";
    else if (date.weekday == 1) return "Monday";
    else if (date.weekday == 2) return "Tuesday";
    else if (date.weekday == 3) return "Wednesday";
    else if (date.weekday == 4) return "Thursday";
    else if (date.weekday == 5) return "Friday";
    else return "Saturday";

  }

  static String date(int timeStamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    String result = "";
    if (date.month == 1) result = "January";
    else if (date.month == 2) result = "February";
    else if (date.month == 3) result = "March";
    else if (date.month == 4) result = "April";
    else if (date.month == 5) result = "May";
    else if (date.month == 6) result = "June";
    else if (date.month == 7) result = "July";
    else if (date.month == 8) result = "August";
    else if (date.month == 9) result = "September";
    else if (date.month == 10) result = "October";
    else if (date.month == 11) result = "November";
    else result = "December";

    return result += " ${date.day}";

  }


}



