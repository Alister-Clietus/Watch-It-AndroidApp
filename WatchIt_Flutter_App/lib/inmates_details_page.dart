import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // Import DashboardPage for navigation

class InmatesDetailsPage extends StatelessWidget {
  // Dummy data for inmates
  final List<Map<String, String>> inmates = [
    {"name": "John Doe", "email": "john.doe@example.com", "phone": "+91 9876543210", "age": "65"},
    {"name": "Sarah Smith", "email": "sarah.smith@example.com", "phone": "+91 8765432109", "age": "70"},
    {"name": "Robert Brown", "email": "robert.brown@example.com", "phone": "+91 7654321098", "age": "68"},
    {"name": "Linda Johnson", "email": "linda.johnson@example.com", "phone": "+91 6543210987", "age": "72"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
    {"name": "Michael Williams", "email": "michael.williams@example.com", "phone": "+91 5432109876", "age": "66"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inmates Details"),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: inmates.length,
        itemBuilder: (context, index) {
          final inmate = inmates[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(inmate["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${inmate["email"]}"),
                  Text("Phone: ${inmate["phone"]}"),
                  Text("Age: ${inmate["age"]} years"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
