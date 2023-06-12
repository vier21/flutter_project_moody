import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes_satu/textbox.dart';
import 'textbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //users
  final currentuser = FirebaseAuth.instance.currentUser!;

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
                const Icon(
                  Icons.person,
                  size: 72,
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
                  text: 'dika',
                  sectionName: 'username',
                  onPressed: () => editField('username'),
                ),
                //Mobile number
                MyTextBox(
                  text: '12345',
                  sectionName: 'mobileNumber',
                  onPressed: () => editField('mobileNumber'),
                ),
                const SizedBox(height: 50),

                //user post
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My details',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('Data tidak ditemukan'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
