import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // Import DashboardPage for navigation

class AddGuardianPage extends StatefulWidget {
  @override
  _AddGuardianPageState createState() => _AddGuardianPageState();
}

class _AddGuardianPageState extends State<AddGuardianPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nativePlaceController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  void _addGuardian() {
    if (_formKey.currentState!.validate()) {
      // Show confirmation popup
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Guardian added successfully!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close popup
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Guardian"),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(nameController, "Guardian Name"),
              _buildTextField(emailController, "Email"),
              _buildTextField(phoneController, "Phone Number"),
              _buildTextField(ageController, "Age"),
              _buildTextField(nativePlaceController, "Native Place"),
              _buildTextField(bloodGroupController, "Blood Group"),
              _buildTextField(experienceController, "Experience (in years)"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addGuardian,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Add Guardian", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
