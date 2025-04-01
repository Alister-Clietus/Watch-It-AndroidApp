import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // Import DashboardPage for navigation

class AddInmatePage extends StatefulWidget {
  @override
  _AddInmatePageState createState() => _AddInmatePageState();
}

class _AddInmatePageState extends State<AddInmatePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController guardianNameController = TextEditingController();
  final TextEditingController joinedDateController = TextEditingController();
  final TextEditingController lastMedicalCheckupController = TextEditingController();

  String? diabetesStatus; // Dropdown for Diabetes (Yes/No)

  void _addInmate() {
    if (_formKey.currentState!.validate() && diabetesStatus != null) {
      // Show confirmation popup
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Inmate added successfully!"),
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
        title: Text("Add Inmate"),
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
              _buildTextField(nameController, "Inmate Name"),
              _buildTextField(emailController, "Email"),
              _buildTextField(phoneController, "Phone Number"),
              _buildTextField(ageController, "Age"),
              _buildTextField(guardianNameController, "Guardian Name"),
              _buildTextField(joinedDateController, "Joined Date (DD-MM-YYYY)"),
              _buildDropdownField("Diabetes", ["Yes", "No"]),
              _buildTextField(lastMedicalCheckupController, "Last Medical Checkup (DD-MM-YYYY)"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addInmate,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Add Inmate", style: TextStyle(color: Colors.white)),
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

  Widget _buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        value: diabetesStatus,
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            diabetesStatus = newValue;
          });
        },
        validator: (value) => value == null ? "Please select $label" : null,
      ),
    );
  }
}
