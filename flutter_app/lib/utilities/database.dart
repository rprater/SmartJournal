import 'package:flutter_app/models/entry_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

import 'dart:async';

class DB {
  static final dbName = "sites.db";
  static Database _database;

  static Future<Database> get database async {
    if (DB._database != null)
      return DB._database;

    DB._database = await DB._connectDb();
    return DB._database;
  }

  static setupDB(Database db) async {
    print("In setup");
    await db.execute("DROP TABLE IF EXISTS ${EntryModel.tableName}");
    await db.execute("CREATE TABLE IF NOT EXISTS ${EntryModel.tableName} ( "
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "body TEXT, "
        "sentiment REAL, "
        "confidence REAL, "
        "date INTEGER "
        ")");
  }

//  Connects to the database
  static Future<Database> _connectDb() async {
    print("COnnecting");
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, dbName);

    Database connection = await openDatabase(
        dbPath,
        version: 2,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          await DB.setupDB(db);
        },
        onDowngrade: (Database db, int oldVersion, int newVersion) async {
          await DB.setupDB(db);
        }
    );
    return connection;
  }



}