import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String email = '';
  String password = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _handleLogin() async {
    if (email.isEmpty || password.isEmpty) {
      final snackBar = SnackBar(content: Text('Username dan Password harus diisi'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          final snackBar = SnackBar(content: Text('Berhasil login'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          });
        }
      } catch (e) {
        final snackBar = SnackBar(content: Text('Gagal login: ${e.toString()}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 187, 186, 186),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            //logo
            const Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(
              height: 50,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'email',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Password',
                ),
              ),
            ),

            Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: _handleLogin,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const SizedBox(
              height: 30,
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Text(
                'Register',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 28, 28), fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
