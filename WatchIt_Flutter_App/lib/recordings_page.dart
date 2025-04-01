import 'package:flutter/material.dart';

class RecordingsPage extends StatelessWidget {
  // Dummy recordings data
  final List<Map<String, String>> recordings = [
    {"title": "Recording 1", "date": "March 03, 2025"},
    {"title": "Recording 2", "date": "March 04, 2025"},
    {"title": "Recording 3", "date": "March 05, 2025"},
    {"title": "Recording 4", "date": "March 06, 2025"},
    {"title": "Recording 5", "date": "March 07, 2025"},
    {"title": "Recording 6", "date": "March 08, 2025"},
    {"title": "Recording 7", "date": "March 09, 2025"},
    {"title": "Recording 8", "date": "March 10, 2025"},
    {"title": "Recording 9", "date": "March 11, 2025"},
    {"title": "Recording 10", "date": "March 12, 2025"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recordings"),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to Dashboard
          },
        ),
      ),
      body: recordings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "No Recordings Available",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: recordings.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.videocam, size: 40, color: Colors.blueGrey),
                    title: Text(recordings[index]["title"]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text("Date: ${recordings[index]["date"]!}"),
                    onTap: () {
                      // Future: Implement video playback
                      print("Tapped on ${recordings[index]["title"]}");
                    },
                  ),
                );
              },
            ),
    );
  }
}
