import 'package:items/model/active_record.dart';

class ListItem extends ActiveRecord {
  ListItem({
    int? id,
    required this.title,
    this.note,
  }) : super(id: id);

  String title;
  String? note;

  static const _tableName = 'list_item';
  static const _titleColumn = "title";
  static const _noteColumn = "note";

  @override
  String get tableName => _tableName;

  ListItem.fromMap(Map<String, Object?> map)
      : title = map[_titleColumn] as String,
        note = map[_noteColumn] as String?,
        super.fromMap(map);

  Map<String, Object?> toMap() => {
        ...super.toMap(),
        ...{
          _titleColumn: title,
          _noteColumn: note,
        },
      };

  static Future<int> delete(int id) => ActiveRecord.delete(_tableName, id);

  static Future<int> deleteAll() => ActiveRecord.deleteAll(_tableName);

  static Future<ListItem?> find(int id) =>
      ActiveRecord.find(_tableName, id, (map) => ListItem.fromMap(map));

  static Future<List<ListItem>> findAll() =>
      ActiveRecord.findAll(_tableName, (map) => ListItem.fromMap(map));
}
