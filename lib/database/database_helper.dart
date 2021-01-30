import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = 'app.db';

  static final _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._();

  Future<Database> _database;

  Future<Database> get database {
    if (_database == null) {
      _database = openDatabase(
        databaseName,
        version: 2,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE list_item (
            id INTEGER PRIMARY KEY NOT NULL,
            title TEXT NOT NULL,
            note TEXT
          )''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion == 1) {
            await db.execute('ALTER TABLE list_item ADD note TEXT');
          }
        },
      );
    }
    return _database;
  }
}
