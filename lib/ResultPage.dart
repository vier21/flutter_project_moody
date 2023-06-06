import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  DateTime _selectedDate = DateTime.now();
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

   _getStory() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final storyRef = db.collection('story');
    return  storyRef.where("uid", isEqualTo: uid).limit(1);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.amber,
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selected Date:',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.grey[300],
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Longitude Latitude",
              ),
            ), // You can replace this with your own widget
          ),
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.blue,
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Intense - Type Feel",
              ),
            ), // You can replace this with your own widget
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.blueGrey,
            child: TextFormField(
              initialValue:"",
              readOnly: true,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.left,
              maxLines: null,
              minLines: null,
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Cerita",
              ),
            ),
          ) // You can replace this with your own widget
              ),
        ],
      ),
    );
  }
}
