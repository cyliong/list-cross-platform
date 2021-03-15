// @dart=2.9

import 'package:flutter/widgets.dart';
import 'package:items/bloc/list_bloc.dart';

class ListBlocProvider extends InheritedWidget {
  final ListBloc listBloc;

  const ListBlocProvider({Key key, Widget child, this.listBloc})
      : super(key: key, child: child);

  static ListBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListBlocProvider>();
  }

  @override
  bool updateShouldNotify(ListBlocProvider old) => listBloc != old.listBloc;
}
