import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _confirmDelete = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Confirm before deleting'),
            value: _confirmDelete,
            onChanged: (bool value) {
              setState(() {
                _confirmDelete = value;
              });
            },
            secondary: const Icon(Icons.warning_amber_rounded),
          ),
        ],
      ),
    );
  }
}
