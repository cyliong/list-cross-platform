import 'package:flutter/material.dart';
import 'package:items/page/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Items',
      theme: ThemeData.dark(),
      home: HomePage(title: 'List'),
      debugShowCheckedModeBanner: false,
    );
  }
}
