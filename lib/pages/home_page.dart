import 'package:flutter/material.dart';

import '../components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 

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
       

        // Set a custom height for the AppBar
        toolbarHeight: 100.0, // Adjust the value according to your needs
      ),
      drawer: MyDrawer(),
    );
  }
}
