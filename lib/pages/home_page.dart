import 'package:chat_app/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    //get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout),iconSize: 30,),
        ],
        // Set a custom height for the AppBar
        toolbarHeight: 100.0, // Adjust the value according to your needs
      ),
    );
  }
}
