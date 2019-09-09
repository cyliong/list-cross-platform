import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static const databaseName = 'app.db';

  static final _lock = Lock();

  static Database _database;

  static Future<Database> get database async {
    if (_database == null) {
      await _lock.synchronized(() async {
        if (_database == null) {
          _database = await openDatabase(databaseName, version: 1,
              onCreate: (db, version) async {
            await db.execute(
                'CREATE TABLE list_item (id INTEGER PRIMARY KEY NOT NULL, title TEXT NOT NULL)');
          });
        }
      });
    }
    return _database;
  }
}
