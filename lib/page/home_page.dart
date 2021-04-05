import 'package:flutter/material.dart';
import 'package:items/bloc/list_bloc.dart';
import 'package:items/bloc/list_bloc_provider.dart';
import 'package:items/model/list_item.dart';
import 'package:items/page/item_page.dart';
import 'package:items/repository/settings_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ListBloc _listBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listBloc = ListBlocProvider.of(context).listBloc;
  }

  @override
  void dispose() {
    _listBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          key: Key('list_title'),
        ),
      ),
      body: Center(
        child: StreamBuilder<List<ListItem>>(
          stream: _listBloc.listStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return items.isEmpty
                  ? Text('No Items',
                      style: TextStyle(fontSize: 30, color: Colors.grey))
                  : _buildListView(items);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('add_button'),
        onPressed: () => _showInputDialog(
          title: 'New Item',
          hint: 'Title',
          action: (newItem) => _listBloc.insert(newItem),
        ),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildListView(List<ListItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: Key('item_dismissible_${item.id}'),
          confirmDismiss: (_) async {
            final confirmDelete = await SettingsRepository().isConfirmDelete();
            if (confirmDelete) {
              return await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete this item?'),
                      content: Text('${item.title}'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('No'),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ],
                    );
                  });
            } else {
              return true;
            }
          },
          onDismissed: (direction) {
            _listBloc.delete(item.id!);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Item deleted"),
              duration: Duration(seconds: 1),
            ));
          },
          background: Container(color: Colors.redAccent),
          child: Card(
            child: ListTile(
              title: Text('${item.title}'),
              onTap: () => _showInputDialog(
                title: 'Edit Item',
                item: item,
                action: (newItem) => _listBloc.update(newItem),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInputDialog({
    required String title,
    String? hint,
    ListItem? item,
    required Function(ListItem) action,
  }) async {
    final savedItem = await showDialog<ListItem>(
        context: context,
        builder: (BuildContext context) =>
            ItemPage(title: title, hint: hint, item: item));
    if (savedItem != null) {
      action(savedItem);
    }
  }
}
