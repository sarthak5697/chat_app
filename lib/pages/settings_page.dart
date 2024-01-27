import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
            )),
        toolbarHeight: 100.0, // Adjust the value according to your needs
      ),
    );
  }
}
