import 'package:flutter/material.dart';
import 'package:items/bloc/list_bloc.dart';
import 'package:items/bloc/list_bloc_provider.dart';
import 'package:items/page/home_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Items',
      theme: ThemeData.dark(),
      home: ListBlocProvider(
        listBloc: ListBloc(),
        child: const HomePage(title: 'List'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
