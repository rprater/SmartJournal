


import 'dart:convert';

import 'package:flutter_app/utilities/database.dart';
import 'package:sqflite/sqflite.dart';

class AnalyticsModel {

  static String get tableName => 'analytics_table ';




  String value;
  String type;
  double sentiment;
  List<dynamic> occurrences;


  AnalyticsModel({this.value, this.type, this.sentiment, this.occurrences});




  /// Used for testing purposes to print all values in the AnalyticModel table
  static Future<void> getAllAsMap() async {
    Database db = await DB.database;

    final List<Map<String, dynamic>> maps = await db.query(
        AnalyticsModel.tableName,
    ).catchError((error) => print(error));

    for (Map<String, dynamic> map in maps) {
//      print(map);
      print(AnalyticsModel.fromMap(map));
    }

  }


  /// Takes a given [val] and [type] and uses that to grab an Analytic model
  /// from the database. This is only used by the "add" and "remove"
  /// static functions
  static Future<AnalyticsModel> _get(String val, String type) async {
    Database db = await DB.database;

    final List<Map<String, dynamic>> maps = await db.query(
        AnalyticsModel.tableName,
        where: "value = ?",
        whereArgs: [val + type] // turns the key into a more unique value
    ).catchError((error) => print(error));

    if (maps.length == 0) {
      return AnalyticsModel(
          value: val,
          type: type,
          occurrences: [],
          sentiment: 0
      );
    }

    List<AnalyticsModel> itemList = [];

    maps.forEach((map) {
      itemList.add(fromMap(map));
    });
    return itemList[0];
  }

  /// Takes the given entity and addsit from the analytics
  /// The [val] is the name of the person or place
  /// The [sentiment] is the value from -1 to 1
  /// The [type] is weather it's a person, place, etc
  /// The [id] is the id of the note for future references
  static Future<void> add({String val, String type, int id, double sentiment}) async {
    AnalyticsModel model = await AnalyticsModel._get(val, type);
    if (model.value != val)
      throw "The values do not match up!";
    if (model.occurrences.indexOf(id) == -1)
      model.occurrences.add(id);


    model.sentiment += sentiment;
    model.save();
  }

  /// Sorts the given entity of a givetn [type] based on the [sentiment] and
  /// returns them
  /// The [val] is the name of the person or place
  /// The [sentiment] is the value from -1 to 1
  /// The [type] is weather it's a person, place, etc
  /// The [id] is the id of the note for future references
  static Future<List<AnalyticsModel>> filter({String type}) async {
    Database db = await DB.database;
    final List<Map<String, dynamic>> maps = await db.query(
        AnalyticsModel.tableName,
        where: "type = ?",
        whereArgs: [type] // turns the key into a more unique value
    ).catchError((error) => print(error));

    List<AnalyticsModel> lst = [];
    maps.forEach((map) => lst.add(AnalyticsModel.fromMap(map)));
    lst.sort((a, b) {
      return a.sentiment < b.sentiment ? 1 : 0;
    });
    return lst;
  }

  /// Takes the given entity and removes it from the analytics
  /// The [val] is the name of the person or place
  /// The [sentiment] is the value from -1 to 1
  /// The [type] is weather it's a person, place, etc
  /// The [id] is the id of the note for future references
  static Future<void> remove({String val, String type, int id, double sentiment}) async {
    AnalyticsModel model = await AnalyticsModel._get(val, type);
    if (model.value != val)
      throw "The values do not match up!";

    if (model.occurrences.indexOf(id) != -1) {
      model.occurrences.remove(id);
      model.sentiment -= sentiment;
    }
    else
      throw "Value was never added...";
    model.save();
  }



  /// Takes the current "analytical" model and saves it to the db
  Future<int> save() async {
    Database db = await DB.database;

    final List<Map<String, dynamic>> maps = await db.query(
      AnalyticsModel.tableName,
      where: "value = ?",
      whereArgs: [this.value + this.type]  // turns the key into a more unique value
    ).catchError((error) => print(error));

    int result = 0;
    if (maps.length == 0) {
      result = await db.insert(
        AnalyticsModel.tableName,
        this.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    else {
      result = await db.update(
          AnalyticsModel.tableName,
          this.toMap(),
          conflictAlgorithm: ConflictAlgorithm.fail,
          where: "value = ?",
          whereArgs: [this.value + this.type]  // turns the key into a more unique value
      );
    }

    return result;
  }









  /// Takes [map] of the current "analytic" and converts it into an
  /// AnalyticModel after it's been extracrted from the db
  static AnalyticsModel fromMap(Map<String, dynamic> map) {
    String type = map["type"];
    String val = map["value"];

    AnalyticsModel analitic = AnalyticsModel(
      value: val.split(type)[0],  // Turns the name from: "valueTYPE" to just "value"
      type: map["type"],
      sentiment: map["sentiment"],
      occurrences: json.decode(map["occurrences"])
    );
    return analitic;
  }

  /// Takes the instance of the "analytic" and converts it into
  /// an map to be put back into the db
  Map<String, dynamic> toMap() {
    var data = {
      "value": this.value + this.type,  // Makes the value more unique by turning it into: "valueTYPE" instead of just "value"
      "type": this.type,
      "sentiment": this.sentiment,
      "occurrences": json.encode(this.occurrences),
    };

    return data;
  }

  @override
  String toString() {
    return "sentiment: ${this.sentiment},"
        "occurrences: ${this.occurrences},"
        "value: ${this.value},"
        "type: ${this.type},";
  }

}