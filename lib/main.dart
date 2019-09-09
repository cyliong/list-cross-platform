import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';
import 'package:items/page/home_page.dart';

void main() => runApp(App(items: ListItem.findAll()));

class App extends StatelessWidget {
  App({Key key, this.items}) : super(key: key);

  final Future<List<ListItem>> items;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Items',
      theme: ThemeData.dark(),
      home: HomePage(title: 'List', items: items),
      debugShowCheckedModeBanner: false,
    );
  }
}
