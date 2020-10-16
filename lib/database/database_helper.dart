import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = 'app.db';

  static final _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> _database;

  Future<Database> get database {
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
