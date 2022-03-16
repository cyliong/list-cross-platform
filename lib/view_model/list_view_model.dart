import 'package:flutter/foundation.dart';
import 'package:items/model/list_item.dart';

class ListViewModel extends ChangeNotifier {
  List<ListItem> _items = [];

  List<ListItem> get items => _items;

  void loadItems() async {
    _items = await ListItem.findAll();
    notifyListeners();
  }

  void insert(ListItem item) async {
    await item.insert();
    _items.add(item);
    notifyListeners();
  }

  void update(int index, ListItem updatedItem) async {
    await updatedItem.update();
    _items[index] = updatedItem;
    notifyListeners();
  }

  void delete(int index) async {
    final id = items[index].id;
    if (id != null) {
      await ListItem.delete(id);
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
