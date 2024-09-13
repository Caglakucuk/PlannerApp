import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String apiUrl = "https://v1.nocodeapi.com/cagllkck/airtable/coXlQqussjiWIkKo?tableName=users"; 

  Future<void> signup() async {
    try {
      var dio = Dio();
      var response = await dio.post(
        apiUrl,
        data: {
          "fields": {
            "firstname": nameController.text,
            "lastname": surnameController.text,
            "email": emailController.text,
            "password": passwordController.text,
          }
        },
      );

      if (response.statusCode == 200) {
        print("Kayıt başarılı!");
      } else {
        print("Kayıt başarısız: ${response.statusMessage}");
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up"),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Text(
              'If you don\'t have an account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 24,
                color: Colors.purple[900],
              ),
            ),
            Text(
              'Please sign up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 24,
                color: Colors.purple[900],
              ),
            ),
            SizedBox(height: 60),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
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
            SizedBox(height: 50),
            TextFormField(
              controller: surnameController,
              decoration: InputDecoration(
                hintText: 'Surname',
                labelText: 'Surname',
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
            SizedBox(height: 50),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email Address',
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
            SizedBox(height: 50),
            TextFormField(
              controller: passwordController,
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
              obscureText: true,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                signup();
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
