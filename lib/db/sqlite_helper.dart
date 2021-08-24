import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'dart:io';

class SQLiteDatabaseHelper {

  final String dbName = 'transporter.db';

  Future<Database> initializeDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, dbName);
    var dbOpened = await openDatabase(dbPath, onCreate: (db, version) async {
      String sql = 
      '''
      CREATE TABLE IF NOT EXISTS "expenditure" (
	    "id"	INTEGER NOT NULL UNIQUE,
	    "name"	TEXT,
	    "amount"	NUMERIC,
	    "created_at"	TEXT,
	    "last_update_at"	TEXT,
	    PRIMARY KEY("id" AUTOINCREMENT)
      );

      CREATE TABLE IF NOT EXISTS "income" (
	    "id"	INTEGER NOT NULL UNIQUE,
	    "name"	TEXT,
	    "amount"	NUMERIC,
	    "created_at"	TEXT,
	    "last_update_at"	TEXT,
	    PRIMARY KEY("id" AUTOINCREMENT)
      );

      CREATE TABLE IF NOT EXISTS "persons" (
	    "id"	INTEGER NOT NULL UNIQUE,
	    "first_name"	TEXT,
	    "last_name"	TEXT,
	    "role"	TEXT,
	    "phone"	TEXT,
	    "email"	TEXT,
	    "created_at"	TEXT,
	    "last_update_at"	TEXT,
	    PRIMARY KEY("id" AUTOINCREMENT)
      );
      ''';
      await db.execute(sql);
    }, version: 1);
    return dbOpened;
  }

}