import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tba/data/models.dart';
// import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'dart:io';

class SQLiteDatabaseHelper {
  final String dbName = 'transporter.db';
  final int schemaVersion = 1;
  final String bkTable = 'bookkeeping';

  Future<Database> initializeDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, dbName);
    var dbOpened = await openDatabase(dbPath, onCreate: (db, version) async {
      String sql = '''
      CREATE TABLE IF NOT EXISTS $bkTable (
	    "id"	INTEGER NOT NULL UNIQUE,
	    "category"	TEXT,
	    "source"	TEXT,
	    "amount"	REAL,
	    "created_at"	TEXT,
	    "last_update_at"	TEXT,
	    PRIMARY KEY("id" AUTOINCREMENT)
      ); ''';
      await db.execute(sql);
    }, version: schemaVersion);
    return dbOpened;
  }

  Future insertRow(String tCategory, String tSource, String tAmount) async {
    final Database? db = await initializeDB();
    if (db != null) {
      List qData = ["$tCategory", "$tSource", "$tAmount"];
      String sql =
          '''INSERT INTO $bkTable (category, source, amount, created_at) VALUES (?, ?, ?, datetime('now', 'localtime'))''';
      int qResult = await db.rawInsert(sql, qData);
      return qResult;
    } else {
      return null;
    }
  }

  Future updateRow(
    String tDateTime,
    String tSource,
    String tAmount,
    int rId,
  ) async {
    final Database? db = await initializeDB();
    if (db != null) {
      List qData = ["$tDateTime", "$tSource", "$tAmount", "$rId"];
      String sql =
          '''UPDATE $bkTable SET created_at = ?, source = ? , amount = ?, last_update_at = datetime('now', 'localtime') WHERE id = ?''';
      int qResult = await db.rawUpdate(sql, qData);
      return qResult;
    } else {
      return null;
    }
  }

  Future deleteRow(
    int rId,
  ) async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql = '''DELETE FROM $bkTable WHERE id = $rId''';
      int qResult = await db.rawDelete(sql);
      return qResult;
    } else {
      return null;
    }
  }

  Future<List<Record>> getAllRows() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql = 'SELECT * FROM $bkTable ORDER BY datetime(created_at) DESC';
      List<Map<String, Object?>> qResult = await db.rawQuery(sql);
      return qResult.map((e) => Record.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  /*   Future getAllRows() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql = 'SELECT * FROM $bkTable ORDER BY datetime(created_at) DESC';
      List<Map<String, Object?>> qResult = await db.rawQuery(sql);
      return qResult.toList();
    } else {
      // print('SQL SELECT query returned an error!');
      return null;
    }
  } */

  Future<List<Income>> getAllExpentures() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql =
          'SELECT id, source, amount, created_at FROM $bkTable WHERE category = "expenditure" ORDER BY datetime(created_at) DESC';
      List<Map<String, Object?>> qResult = await db.rawQuery(sql);
      return qResult.map((e) => Income.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Income>> getAllIncomes() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql =
          'SELECT id, source, amount, created_at FROM $bkTable WHERE category = "income" ORDER BY datetime(created_at) DESC';
      List<Map<String, Object?>> qResult = await db.rawQuery(sql);
      return qResult.map((e) => Income.fromMap(e)).toList();
    } else {
      return [];
    }
  }

/*   Future getExpenditureSum() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql =
          'SELECT sum(amount) AS sum_ex FROM $bkTable WHERE category = "expenditure"';
      List<Map<String, dynamic>> qResult = await db.rawQuery(sql);
      return qResult[0];
    } else {
      return null;
    }
  }

  Future getIncomeSum() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sql =
          'SELECT sum(amount) AS sum_in FROM $bkTable WHERE category = "income"';
      List<Map<String, dynamic>> qResult = await db.rawQuery(sql);
      return qResult[0];
    } else {
      return null;
    }
  } */
  
  /* Get sum data */
  Future getSumAll() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sqlSumExp =
          'SELECT sum(amount) AS sum_exp FROM $bkTable WHERE category = "expenditure"';
      String sqlSumInc =
          'SELECT sum(amount) AS sum_inc FROM $bkTable WHERE category = "income"';
      List<Map<String, dynamic>> qResultSumExp = await db.rawQuery(sqlSumExp);
      List<Map<String, dynamic>> qResultSumInc = await db.rawQuery(sqlSumInc);
      return {'sumExp': qResultSumExp[0]['sum_exp'], 'sumInc': qResultSumInc[0]['sum_inc']};
    } else {
      return null;
    }
  }

  Future getSumToday() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sqlSumExp =
          'SELECT sum(amount) AS sum_exp FROM $bkTable WHERE category = "expenditure" AND DATE(created_at) = DATE("now", "localtime")';
      String sqlSumInc =
          'SELECT sum(amount) AS sum_inc FROM $bkTable WHERE category = "income" AND DATE(created_at) = DATE("now", "localtime")';
      List<Map<String, dynamic>> qResultSumExp = await db.rawQuery(sqlSumExp);
      List<Map<String, dynamic>> qResultSumInc = await db.rawQuery(sqlSumInc);
      return {'sumExpToday': qResultSumExp[0]['sum_exp'], 'sumIncToday': qResultSumInc[0]['sum_inc']};
    } else {
      return null;
    }
  }

  Future getSumByWeek() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sqlSumExp =
          'SELECT sum(amount) AS sum_exp FROM $bkTable WHERE category = "expenditure" AND strftime("%W", DATE(created_at)) = strftime("%W", DATE("now", "localtime"))';
      String sqlSumInc =
          'SELECT sum(amount) AS sum_inc FROM $bkTable WHERE category = "income" AND strftime("%W", DATE(created_at)) = strftime("%W", DATE("now", "localtime"))';
      List<Map<String, dynamic>> qResultSumExp = await db.rawQuery(sqlSumExp);
      List<Map<String, dynamic>> qResultSumInc = await db.rawQuery(sqlSumInc);
      return {'sumExpWeek': qResultSumExp[0]['sum_exp'], 'sumIncWeek': qResultSumInc[0]['sum_inc']};
    } else {
      return null;
    }
  } 

  Future getSumByMonth() async {
    final Database? db = await initializeDB();
    if (db != null) {
      String sqlSumExp =
          'SELECT sum(amount) AS sum_exp FROM $bkTable WHERE category = "expenditure" AND strftime("%m", DATE(created_at)) = strftime("%m", DATE("now", "localtime"))';
      String sqlSumInc =
          'SELECT sum(amount) AS sum_inc FROM $bkTable WHERE category = "income" AND strftime("%m", DATE(created_at)) = strftime("%m", DATE("now", "localtime"))';
      List<Map<String, dynamic>> qResultSumExp = await db.rawQuery(sqlSumExp);
      List<Map<String, dynamic>> qResultSumInc = await db.rawQuery(sqlSumInc);
      return {'sumExp': qResultSumExp[0]['sum_exp'], 'sumInc': qResultSumInc[0]['sum_inc']};
    } else {
      return null;
    }
  }
}
