import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to Dashboard
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            subtitle: Text("Manage notification settings"),
            onTap: () {
              // Add functionality later
              print("Notifications clicked");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.palette),
            title: Text("Theme"),
            subtitle: Text("Switch between light and dark mode"),
            onTap: () {
              // Add theme change functionality
              print("Theme clicked");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy"),
            subtitle: Text("Manage data and privacy settings"),
            onTap: () {
              // Add privacy settings functionality
              print("Privacy clicked");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help & Support"),
            subtitle: Text("Get help or contact support"),
            onTap: () {
              // Add help and support functionality
              print("Help & Support clicked");
            },
          ),
        ],
      ),
    );
  }
}
