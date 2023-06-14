import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes_satu/textbox.dart';
import 'package:image_picker/image_picker.dart';
import 'HomePage.dart';
import 'ResultPage.dart';
import 'StoryPage.dart';
import 'textbox.dart';
import 'package:path/path.dart' as path;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //image picker
  File? _image;

  CollectionReference users = FirebaseFirestore.instance.collection('pengguna');

  Future<String?> getEmailFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('pengguna')
        .where('email', isEqualTo: '')
        .get();
    print(snapshot.docs[0]);
    if (snapshot.docs.isNotEmpty) {
      String? email = snapshot.docs[0].data()['email'];
      return email;
    }
    return null;
  }

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

  //users
  final currentuser = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //all user
  final userCollection = FirebaseFirestore.instance.collection("pengguna");
  //edit field
  Future<void> editField(String field) async {
    String newvalue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey,
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newvalue = value;
          },
        ),
        actions: [
          //cancel
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          //save
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newvalue),
          ),
        ],
      ),
    );
    if (newvalue.trim().length > 0) {
      await userCollection.doc(currentuser.email).update({field: newvalue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile page"),
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("pengguna")
            .doc(currentuser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                //profile pic
                GestureDetector(
                  onTap: _changeProfilePicture,
                  child: CircleAvatar(
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : AssetImage('assets/images/mood.jpg'),
                    radius: 75,
                  ),
                ),
                const SizedBox(height: 50),
                //email
                Text(
                  currentuser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 50),

                //details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My details',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                // username
                MyTextBox(
                  text: userData['name'],
                  sectionName: 'username',
                  onPressed: () => editField('username'),
                ),
                //Mobile number
                MyTextBox(
                  text: userData['mobileNumber'] ??
                      '', // Menggunakan null-aware operator untuk mengatasi jika mobileNumber null
                  sectionName: 'mobileNumber',
                  onPressed: () => editField('mobileNumber'),
                ),
                const SizedBox(height: 50),

                //user post
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My posts',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
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
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('Data not found'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeProfilePicture,
        tooltip: 'Ganti Foto',
        child: Icon(Icons.edit),
      ),
    );
  }
}
