import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';

class ItemPage extends StatelessWidget {
  ItemPage({this.title, this.hint, this.item})
      : _controller = TextEditingController(text: item?.title);

  final String title;
  final String hint;
  final ListItem item;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: TextField(
          key: Key('item_text_field'),
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(hintText: hint),
          onSubmitted: (text) => _save(context, text),
        ),
        actions: <Widget>[
          FlatButton(
            key: Key('cancel_button'),
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            key: Key('save_button'),
            child: Text('Save'),
            onPressed: () => _save(context, _controller.text),
          )
        ]);
  }

  void _save(BuildContext context, String text) {
    if (text?.trim()?.isEmpty ?? true) return;

    Navigator.pop(
        context,
        item == null ? ListItem(title: text) : item
          ..title = text);
  }
}
