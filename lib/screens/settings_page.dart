import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  void _removeAccount() {
    // Handle "Remove Account" confirmation and action here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(
            'General',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10.0),
          ListTile(
            title: const Text('Theme'),
            trailing: Switch(
              value: _isDarkTheme,
              onChanged: (value) => _toggleTheme,
            ),
          ),
          // More settings options here...

          const Divider(),
          Text(
            'Account',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10.0),
          ListTile(
            title: const Text('Remove Account'),
            trailing: const Icon(Icons.delete_outline),
            onTap: _removeAccount,
            // Add confirmation dialog before calling _removeAccount
          ),
        ],
      ),
    );
  }
}
