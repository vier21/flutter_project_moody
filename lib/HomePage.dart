import 'package:flutter/material.dart';
import 'ProfileApp.dart';
import 'StoryPage.dart';
import 'ResultPage.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIntensity = 1;
  String _selectedMood = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> _buildIntensityButtons() {
    return List.generate(5, (index) {
      int intensity = index + 1;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedIntensity = intensity;
            });
          },
          child: Text('$intensity'),
          style: ElevatedButton.styleFrom(
            primary:
                _selectedIntensity == intensity ? Colors.blue : Colors.grey,
            onPrimary: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.all(20.0),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32.0),
              Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 24.0),
              ),
              EmojiFeedback(
                onChanged: (value) {
                  if (value == 1) {
                  } else if (value == 2) {
                    _selectedMood = "Terrible";
                  } else if (value == 3) {
                    _selectedMood = "Bad";
                  } else if (value == 4) {
                    _selectedMood = "Good";
                  } else if (value == 5) {
                    _selectedMood = "Very good";
                  }
                  print(_selectedMood);
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 32.0),
              Text(
                'How intense is that feeling?',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildIntensityButtons(),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => StoryPage()));
                  // TODO: save mood and intensity to database
                  User? user = _auth.currentUser;
                  if (user != null) {
                    String uid = user.uid;
                    FirebaseFirestore.instance
                        .collection('moods')
                        .add({
                          'uid':
                              uid, // Include the UID in the Firestore document
                          'mood': _selectedMood,
                          'intensity': _selectedIntensity,
                        })
                        .then((value) =>
                            print('Mood and intensity saved to Firestore'))
                        .catchError((error) =>
                            print('Failed to save mood and intensity: $error'));
                  } else {
                    print('User not authenticated');
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
