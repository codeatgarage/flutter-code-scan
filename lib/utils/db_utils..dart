import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  /* *
   * Configuration values for db
   * */
  static const String scanner_db_name = 'scanner.db';
  static const String report_table_name = 'Report';


  static DbUtils _cartDbHandlerInstance;

  static Database _cartDatabase;

  DbUtils.internal();

  factory DbUtils() {
    if (_cartDbHandlerInstance == null) {
      _cartDbHandlerInstance = new DbUtils.internal();
    }
    return _cartDbHandlerInstance;
  }

  Future<Database> get db async {
    if (_cartDatabase != null) return _cartDatabase;
    _cartDatabase = await initiateDb();
    return _cartDatabase;
  }

  initiateDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, scanner_db_name);
    var scannerDb = await openDatabase(path, version: 1, onCreate: createReportTable);
    return scannerDb;
  }

  // Create table to store reports
  void createReportTable(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $report_table_name ( id INTEGER PRIMARY KEY AUTOINCREMENT, eanCode TEXT, cDate INTEGER )");
  }

  // remove report base on id
  void deleteReport(reportId) async {
    var dbClient = await db;
    dbClient.rawDelete("DELETE FROM $report_table_name WHERE id = ?", [reportId]);
  }

  // Insert item or report to cart
  void saveReport(report) async {
    var dbClient = await db;
    dbClient.rawInsert("INSERT INTO $report_table_name (eanCode, cDate) VALUES (?, strftime(?,'now'))", [report.eanCode, report.cDate]);
  }

  // Clear report db
  void clearReport() async {
    var dbClient = await db;
    dbClient.execute("DELETE FROM $report_table_name");
  }

  // load all available reports from db
  Future<List<Map<String, dynamic>>> getReports() async {
    var dbClient = await db;
    return await dbClient.rawQuery("select *, datetime(cDate, 'unixepoch') as date from $report_table_name");
  }

  // get report by eancode
  Future<List<Map<String, dynamic>>> getReportByEan(eanCode) async {
    var dbClient = await db;
    return await dbClient.rawQuery("select * from $report_table_name where eanCode=$eanCode");
  }

}


/* *
 * How to handle the date's in sql lite
 *  ## Create table query
 * CREATE TABLE IF NOT EXISTS datetime_int (d1 int);
 *  ## Insert query
 * INSERT INTO datetime_int (d1) VALUES (strftime('%s','now'));
 *  ## Select query
 * SELECT datetime(d1,'unixepoch') FROM datetime_int;
 * * * * */