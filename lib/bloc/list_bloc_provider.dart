import 'package:flutter/widgets.dart';
import 'package:items/bloc/list_bloc.dart';

class ListBlocProvider extends InheritedWidget {
  final ListBloc listBloc;

  const ListBlocProvider(
      {Key? key, required Widget child, required this.listBloc})
      : super(key: key, child: child);

  static ListBlocProvider of(BuildContext context) {
    final listBlocProvider =
        context.dependOnInheritedWidgetOfExactType<ListBlocProvider>();
    assert(listBlocProvider != null, 'No ListBlocProvider found in context');
    return listBlocProvider!;
  }

  @override
  bool updateShouldNotify(ListBlocProvider old) => listBloc != old.listBloc;
}
