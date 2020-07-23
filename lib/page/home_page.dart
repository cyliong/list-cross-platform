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
              final items = snapshot.data;
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
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: Key('item_dismissible_${item.id}'),
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete this item?'),
                    content: Text('${item.title}'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ],
                  );
                });
          },
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
          child: Card(
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
