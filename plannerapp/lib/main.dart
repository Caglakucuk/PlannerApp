import 'package:flutter/material.dart';
import 'package:plannerapp/loginpage.dart';
import 'package:plannerapp/splashscreen.dart';
import 'firstpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splash',
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Firstpage(), 
      routes: {
        '/login': (context) => LoginPage(),
        'splash': (context) => Splashpage(),        
      },
    );
  }
}
