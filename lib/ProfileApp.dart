import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'ResultPage.dart';
import 'StoryPage.dart';

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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final fileName = path.basename(imageFile.path);
      setState(() {
        print(_image);
        _image = imageFile;
      });
    }
  }

  Future<void> _changeProfilePicture() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Sumber Gambar"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: Text("Kamera"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: Text("Galeri"),
            ),
          ],
        );
      },
    );
  }

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
                GestureDetector(
                  onTap: _changeProfilePicture,
                  child: CircleAvatar(
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : AssetImage('assets/images/mood.jpg'),
                    radius: 75,
                  ),
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
                  //Cuman buat akses result page biar bisa coba coba *darrel
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultPage()),
                      );
                    },
                    child: Text('Navigate Result Page - page darrel'),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text('Navigate Home Page - page xavier'),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StoryPage()),
                      );
                    },
                    child: Text('Navigate Story Page - page Fathur'),
                  ),
                  //Segini doang yang kuedit
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeProfilePicture,
        tooltip: 'Ganti Foto',
        child: Icon(Icons.edit),
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
