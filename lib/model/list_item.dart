import 'package:items/model/active_record.dart';
import 'package:meta/meta.dart';

class ListItem extends ActiveRecord {
  ListItem({int id, @required this.title}) : super(id: id);

  String title;

  static const _tableName = 'list_item';
  static const _titleColumn = "title";

  @override
  String get tableName => _tableName;

  ListItem.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    title = map[_titleColumn];
  }

  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map[_titleColumn] = title;
    return map;
  }

  static Future<int> delete(int id) => ActiveRecord.delete(_tableName, id);

  static Future<int> deleteAll() => ActiveRecord.deleteAll(_tableName);

  static Future<ListItem> find(int id) =>
      ActiveRecord.find(_tableName, id, (map) => ListItem.fromMap(map));

  static Future<List<ListItem>> findAll() =>
      ActiveRecord.findAll(_tableName, (map) => ListItem.fromMap(map));
}
