import 'dart:async';

import 'package:items/model/list_item.dart';

class ListBloc {
  final _listController = StreamController<List<ListItem>>();

  Stream<List<ListItem>> get listStream => _listController.stream;

  ListBloc() {
    _loadItems();
  }

  void dispose() {
    _listController.close();
  }

  void _loadItems() async {
    final items = await ListItem.findAll();
    _listController.sink.add(items);
  }
}
