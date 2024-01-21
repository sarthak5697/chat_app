import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginPage(),
      theme: lightMode,
    );
  }
}