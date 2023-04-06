import 'package:flutter/material.dart';
import 'StoryPage.dart';
import 'ResultPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedMood = 'happy';
  int _selectedIntensity = 1;

  List<String> _moods = [
    'happy',
    'sad',
    'angry',
    'tired',
    'anxious',
    'excited'
  ];

  List<Widget> _buildMoodButtons() {
    return _moods.map((mood) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedMood = mood;
            });
          },
          child: Text(mood),
          style: ElevatedButton.styleFrom(
            primary: _selectedMood == mood ? Colors.blue : Colors.grey,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      );
    }).toList();
  }

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
              SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                children: _buildMoodButtons(),
              ),
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
                  // TODO: save mood and intensity to database
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => StoryPage()));
                },
                child: Text('Ceritakan Hari Anda'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800],
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ResultPage()));
                },
                child: Text('Kualitas Tidur'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 118, 44, 44),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
