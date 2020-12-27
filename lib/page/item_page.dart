import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';

class ItemPage extends StatefulWidget {
  ItemPage({this.title, this.hint, this.item})
      : _controller = TextEditingController(text: item?.title);

  final String title;
  final String hint;
  final ListItem item;

  final TextEditingController _controller;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title),
        content: TextField(
          key: Key('item_text_field'),
          controller: widget._controller,
          autofocus: true,
          decoration: InputDecoration(hintText: widget.hint),
          onSubmitted: (text) => _save(context, text),
        ),
        actions: <Widget>[
          TextButton(
            key: Key('cancel_button'),
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            key: Key('save_button'),
            child: Text('Save'),
            onPressed: () => _save(context, widget._controller.text),
          )
        ]);
  }

  void _save(BuildContext context, String text) {
    if (text?.trim()?.isEmpty ?? true) return;

    Navigator.pop(
        context,
        widget.item == null ? ListItem(title: text) : widget.item
          ..title = text);
  }
}
