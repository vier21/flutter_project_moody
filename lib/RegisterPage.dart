import 'package:flutter/material.dart';
import 'HomePage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Full Name',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Password',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Confirm Password',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm your password',
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
