import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';
import 'package:items/page/item_page.dart';
import 'package:items/page/settings_page.dart';
import 'package:items/repository/settings_repository.dart';
import 'package:items/view_model/list_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = ListViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          key: Key('list_title'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ChangeNotifierProvider.value(
          value: _viewModel,
          child: Consumer<ListViewModel>(
            builder: (_, viewModel, __) {
              final items = viewModel.items;
              return items.isEmpty
                  ? const Text(
                      'No Items',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                    )
                  : _buildListView(items);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('add_button'),
        onPressed: () => _showInputDialog(
          action: (newItem) => _viewModel.insert(newItem),
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
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
                      title: const Text('Delete this item?'),
                      content: Text('${item.title}'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          child: const Text('Yes'),
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
            _viewModel.delete(index);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Item deleted"),
              duration: Duration(seconds: 1),
            ));
          },
          background: Container(color: Colors.redAccent),
          child: Card(
            child: ListTile(
              title: Text('${item.title}'),
              onTap: () => _showInputDialog(
                item: item,
                action: (updatedItem) => _viewModel.update(index, updatedItem),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInputDialog({
    ListItem? item,
    required Function(ListItem) action,
  }) async {
    final savedItem = await showDialog<ListItem>(
      context: context,
      builder: (BuildContext context) => ItemPage(item: item),
    );
    if (savedItem != null) {
      action(savedItem);
    }
  }
}
