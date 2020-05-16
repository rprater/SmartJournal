import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/utilities/time_date.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/utilities/database.dart';

class EntryModel {

  static String get tableName => "entry_table";

  int id;
  String body;
  double sentiment;
  double confidence;
  int date;


  EntryModel({
    this.id,
    this.body,
    this.sentiment,
    this.confidence,
    this.date
  });


  static Future<List<EntryModel>> getAll() async {
    Database db = await DB.database;
    final List<Map<String, dynamic>> maps = await db.query(
        EntryModel.tableName,
    ).catchError((error) => print(error));

    List<EntryModel> itemList = [];

    maps.forEach((map) {
      itemList.add(fromMap(map));
    });
    return itemList;
  }



  static Future<EntryModel> get(int id) async {
    if (id == -1) {
      return EntryModel(
          body: "",
          confidence: 0,
          date: TimeDate.currentDateStamp(),
          id: id,
          sentiment: 0
      );
    }
    Database db = await DB.database;
    final List<Map<String, dynamic>> maps = await db.query(
        EntryModel.tableName,
        where: "id = ?",
        whereArgs: [id]
    ).catchError((error) => print(error));

    List<EntryModel> itemList = [];

    maps.forEach((map) {
      itemList.add(fromMap(map));
    });
    return itemList[0];
  }

  Future<void> delete() async {
    bool isNew = this.id == -1;
    int result = 0;

    if (!isNew) {
      Database db = await DB.database;
      result = await db.delete(
          EntryModel.tableName,
          where: "id = ?",
          whereArgs: [id]
      );
    }
  }


  Future<int> update() async {
    bool create = this.id == -1;
    Database db = await DB.database;
    int result = 0;
    if (create) {
      result = await db.insert(
        EntryModel.tableName,
        this.toMap(forCreate: create),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      this.id = result;
    }
    else {
      result = await db.update(
        EntryModel.tableName,
        this.toMap(forCreate: create),
        conflictAlgorithm: ConflictAlgorithm.fail,
        where: "id = ?",
        whereArgs: [this.id]
      );
    }

    return result;
  }


  static EntryModel fromMap(Map<String, dynamic> map) {

    EntryModel entry = EntryModel(
        id: map["id"],
        body: map["body"],
        sentiment: map["sentiment"],
        confidence: map["confidence"],
        date: map["date"]
    );
    return entry;
  }

  Map<String, dynamic> toMap({bool forCreate: false}) {
    var data = {
      "body": this.body,
      "sentiment": this.sentiment,
      "confidence": this.confidence,
      "date": this.date,
    };
    if (!forCreate) {
      data["id"] = this.id;
    }

    return data;
  }


}