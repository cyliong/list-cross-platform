import 'package:flutter/material.dart';
import 'package:items/model/list_item.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, this.item})
      : isNew = item == null,
        super(key: key);

  final ListItem? item;
  final bool isNew;

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
        title: Text('${widget.isNew ? 'New' : 'Edit'} Item'),
        leading: IconButton(
          icon: const Icon(Icons.close),
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  key: Key('item_text_field'),
                  controller: _titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    errorStyle: TextStyle(
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
        widget.isNew ? ListItem(title: title) : widget.item!
          ..title = title,
      );
    }
  }
}
