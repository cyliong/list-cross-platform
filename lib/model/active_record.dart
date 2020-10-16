import 'package:items/database/database_helper.dart';

abstract class ActiveRecord {
  ActiveRecord({this.id});

  int id;

  static const _idColumn = 'id';

  String get tableName;
  String get idColumn => _idColumn;

  ActiveRecord.fromMap(Map<String, dynamic> map) {
    id = map[idColumn];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  Future<int> insert() async {
    final database = await DatabaseHelper().database;
    final id = await database.insert(tableName, toMap());
    if (id > 0) this.id = id;
    return id;
  }

  Future<int> update() => DatabaseHelper().database.then((database) => database
      .update(tableName, toMap(), where: '$idColumn = ?', whereArgs: [id]));

  static Future<int> delete(String tableName, int id, [String idColumn]) async {
    final database = await DatabaseHelper().database;
    return database.delete(tableName,
        where: '${_idColumnName(idColumn)} = ?', whereArgs: [id]);
  }

  static Future<int> deleteAll(String tableName) =>
      DatabaseHelper().database.then((database) => database.delete(tableName));

  static Future<T> find<T extends ActiveRecord>(
      String tableName, int id, T createModel(Map<String, dynamic> map),
      [String idColumn]) async {
    final database = await DatabaseHelper().database;
    final maps = await database.query(tableName,
        where: '${_idColumnName(idColumn)} = ?', whereArgs: [id], limit: 1);
    return maps.length == 0 ? null : createModel(maps.first);
  }

  static Future<List<T>> findAll<T extends ActiveRecord>(
      String tableName, T createModel(Map<String, dynamic> map)) async {
    final database = await DatabaseHelper().database;
    final maps = await database.query(tableName);
    return maps.map((m) => createModel(m)).toList();
  }

  static String _idColumnName(idColumn) => idColumn ?? _idColumn;
}
