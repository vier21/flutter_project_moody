import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  String? _selectedHealthStatus;
  final List<String> _healthStatuses = [
    'Sehat',
    'Sangat Sehat',
    'Kurang Sehat',
    'Tidak Sehat'
  ];
  final Map<String, String> _healthStatusDetails = {
    'Sehat': 'Makanan sehat, tidur cukup, olahraga teratur',
    'Sangat Sehat':
        'Makanan sehat, tidur cukup, olahraga teratur, vitamin, dan suplemen',
    'Kurang Sehat': 'Kurang tidur, kurang olahraga, makanan tidak seimbang',
    'Tidak Sehat': 'Makanan tidak sehat, kurang tidur, kurang olahraga'
  };

  void _onHealthStatusSelected(String status) {
    setState(() {
      _selectedHealthStatus = status;
    });
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(status),
          content: Text(_healthStatusDetails[status]!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Ok'),
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
        title: Text('Kesehatan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Pilih Status Kesehatan',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _healthStatuses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_healthStatuses[index]),
                  selected: _healthStatuses[index] == _selectedHealthStatus,
                  onTap: () {
                    _onHealthStatusSelected(_healthStatuses[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
