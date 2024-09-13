import 'package:flutter/material.dart';
import 'package:plannerapp/secondpage.dart';
import 'package:plannerapp/signuppage.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  Dio dio = Dio();

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await dio.get('https://sheetdb.io/api/v1/2at9cnjmppcu6');

      if (response.statusCode == 200) {
        List<dynamic> users = response.data;

        bool found = false;
        for (var user in users) {
          if (user['email'] == email && user['password'] == password) {
            found = true;
            break;
          }
        }

        if (found) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(email: email),
            ),
          );
        } else {
          setState(() {
            errorMessage = 'Incorrect email or password.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to connect to the server.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Text(
              'If you already have an account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 24,
                color: Colors.purple[900],
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              'Please login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 24,
                color: Colors.purple[900],
              ),
            ),
            SizedBox(height: 60),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email address',
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.purple[800]),
                hintStyle: TextStyle(color: Colors.purple[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.purple[800]),
                hintStyle: TextStyle(color: Colors.purple[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            Spacer(),
            ElevatedButton(
              onPressed: login,
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
  ));
}
