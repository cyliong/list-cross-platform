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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                key: Key('item_text_field'),
                controller: widget._controller,
                autofocus: true,
                decoration: InputDecoration(hintText: widget.hint),
                onSubmitted: (text) => _save(context, text),
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(BuildContext context, String text) {
    if (text?.trim()?.isEmpty ?? true) return;

    Navigator.pop(
        context,
        widget.item == null ? ListItem(title: text) : widget.item
          ..title = text);
  }
}
