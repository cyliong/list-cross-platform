import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = 'app.db';

  static Future<Database> _database;

  static Future<Database> get database {
    if (_database == null) {
      _database =
          openDatabase(databaseName, version: 1, onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE list_item (id INTEGER PRIMARY KEY NOT NULL, title TEXT NOT NULL)');
      });
    }
    return _database;
  }
}
