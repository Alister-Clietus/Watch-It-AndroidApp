import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Old Age Home App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: LoginPage(), // Set login page as the first screen
    );
  }
}
