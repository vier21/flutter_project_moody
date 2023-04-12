import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/mood.jpg'),
                  width: 200,
                  height: 150,
                ),
                SizedBox(height: 16),
                Text(
                  'Rick Shancez',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'rick@example.com',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Saya adalah scientist yang moodyan',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Hobby',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSkillChip(context, 'Makan'),
                      SizedBox(width: 8),
                      _buildSkillChip(context, 'Tidur'),
                      SizedBox(width: 8),
                      _buildSkillChip(context, 'Minum'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String skillName) {
    return Chip(
      label: Text(skillName),
      backgroundColor: Colors.grey[300],
    );
  }
}