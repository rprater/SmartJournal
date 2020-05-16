import 'package:flutter_app/screens/entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/utilities/database.dart';

class EntryModel {

  static String get tableName => "entry_table";

  final int id;
  final String body;
  final double sentiment;
  final double confidence;
  final int date;


  EntryModel({
    this.id,
    this.body,
    this.sentiment,
    this.confidence,
    this.date
  });

  static Future<EntryModel> get(int id) async {
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


  Future<int> insert() async {
    Database db = await DB.database;
    int result = await db.insert(
      EntryModel.tableName,
      this.toMap(forCreate: true),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }


  Future<int> update() async {
    Database db = await DB.database;
    int result = await db.update(
      EntryModel.tableName,
      this.toMap(forCreate: false),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }


  EntryModel fromMap(Map<String, dynamic> map) {
    return EntryModel(
      id: map["id"],
      confidence: map["confidence"],
      sentiment: map["sentiment"],
      body: map[":"],
      date: map["date"]
    );
  }

  Map<String, dynamic> toMap({bool forCreate}) {
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