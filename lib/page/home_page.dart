import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';
import 'package:items/page/item_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.items}) : super(key: key);

  final String title;
  final Future<List<ListItem>> items;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: FutureBuilder<List<ListItem>>(
          future: widget.items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildListView(snapshot.data);
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
            hint: 'Enter a new item',
            action: (newItem) async {
              await newItem.insert();
              final items = await widget.items;
              setState(() {
                items.add(newItem);
              });
            }),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildListView(List<ListItem> items) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: Key('item_dismissible_${item.id}'),
          onDismissed: (direction) async {
            await ListItem.delete(item.id);
            setState(() {
              items.removeAt(index);
            });

            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Item deleted"),
              duration: Duration(seconds: 1),
            ));
          },
          background: Container(color: Colors.redAccent),
          child: ListTile(
            title: Text('${item.title}'),
            onTap: () => _showInputDialog(
                title: 'Edit Item',
                item: item,
                action: (newItem) async {
                  await newItem.update();
                  setState(() {
                    item.title = newItem.title;
                  });
                }),
          ),
        );
      },
    );
  }

  void _showInputDialog(
      {String title,
      String hint,
      ListItem item,
      Function(ListItem) action}) async {
    final savedItem = await showDialog<ListItem>(
        context: context,
        builder: (BuildContext context) =>
            ItemPage(title: title, hint: hint, item: item));
    if (savedItem != null) {
      action(savedItem);
    }
  }
}
