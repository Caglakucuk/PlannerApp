import 'package:flutter/material.dart';
import 'dart:async'; 

import 'firstpage.dart';

class Splashpage extends StatefulWidget {
  @override
  _SplashpageState createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Firstpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageIcon(AssetImage('images/logo.png'), color: Colors.purple,size: 24,),
            SizedBox(width: 10), 
            Text(
              'To-Do Calendar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ),
    );
  }
}
