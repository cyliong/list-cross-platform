import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';

class ItemPage extends StatefulWidget {
  ItemPage({required this.title, this.hint, this.item});

  final String title;
  final String? hint;
  final ListItem? item;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final title = widget.item?.title;
    if (title != null) _titleController.text = title;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            key: Key('save_button'),
            child: const Text('SAVE'),
            onPressed: () => _save(context),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  key: Key('item_text_field'),
                  controller: _titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    errorStyle: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  validator: (text) => text?.trim().isEmpty ?? true
                      ? 'Please enter a title'
                      : null,
                  onFieldSubmitted: (_) => _save(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      Navigator.pop(
        context,
        widget.item == null ? ListItem(title: title) : widget.item!
          ..title = title,
      );
    }
  }
}
