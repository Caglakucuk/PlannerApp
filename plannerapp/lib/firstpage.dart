 import 'package:flutter/material.dart';

 

 class Firstpage extends StatelessWidget{
  @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/image.png', height: 200,),
              SizedBox(height: 50,),
              Text('Your Planner', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 32),),
              SizedBox(height: 30,),
              Text('This productive tool is designed to help you better manage your task project-wise conveniently', 
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.grey[800]),),
              SizedBox(height: 70),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/login');
              }, 
              child: Text(
                "Let's Start",
                textAlign: TextAlign.center,
                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                 ),
                 style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.purple[800]),
                  ),

            ],
          ),
          ),
        ),
      );
    }
 }