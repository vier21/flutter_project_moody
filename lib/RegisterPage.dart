import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = '';
  String email = '';
  String mobileNumber = '';
  String password = '';
  Future<void> _handleRegister() async {
    if (name.isEmpty ||
        email.isEmpty ||
        mobileNumber.isEmpty ||
        password.isEmpty) {
      final snackBar = SnackBar(content: Text('Semua Kolom harus diisi'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Akun berhasil dibuat!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        CollectionReference users =
            await FirebaseFirestore.instance.collection('pengguna');
        await users.add({
          'email': email,
          'mobileNumber': mobileNumber,
          'name': name,
          'password': password,
          'uid': user.user!.uid
        }).
        then((value) => print("User Added"))
        .catchError((error) => 
        print("Failed to add user: $error"));
      } catch (err) {
        final snackBar = SnackBar(content: Text(err.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 126, 79, 24)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: height * 0.15, bottom: height * 0.15),
              height: height * 0.7,
              decoration: BoxDecoration(
                  color: Color.fromARGB(194, 167, 169, 45),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: ListView(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    'Signup'.toUpperCase(),
                    style: GoogleFonts.alkalami(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        letterSpacing: 5),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: width * 0.8,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 9, 0, 250)),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid, color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 9, 0, 250)),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid, color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            mobileNumber = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "MobileNumber",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 9, 0, 250)),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid, color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 9, 0, 250)),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                style: BorderStyle.solid, color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Center(
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 64, 130, 218),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: _handleRegister,
                        child: Text('Register',
                            style: GoogleFonts.oswald(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                                letterSpacing: 2)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
