import 'package:flutter/material.dart';
import 'package:watchit_flutter_app/add_guardian_page.dart';
import 'package:watchit_flutter_app/add_inmate_page.dart';
import 'package:watchit_flutter_app/inmates_details_page.dart';
import 'package:watchit_flutter_app/recordings_page.dart';
import 'package:watchit_flutter_app/video_recording_page.dart';
import 'package:watchit_flutter_app/settings_page.dart';
import 'package:watchit_flutter_app/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    DashboardContent(),
    SettingsPage(),
    LoginPage(),
  ];

  @override
  void initState() {
    super.initState();
    // _scheduleFallDetectionNotifications();
  }


  void _onItemTapped(int index) {
    if (index == 2) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Logout", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guardian Menu"),
        backgroundColor: Colors.blueGrey,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/dummy_profile.jpg'), // Dummy profile picture
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DashboardButton(title: "Show Recordings", icon: Icons.video_library, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RecordingsPage()));
          }),
          DashboardButton(title: "Live Recording", icon: Icons.videocam, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoRecordingPage()));
          }),
          DashboardButton(title: "Add Guardian", icon: Icons.person_add, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddGuardianPage()));
          }),
          DashboardButton(title: "Inmates Details", icon: Icons.people, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => InmatesDetailsPage()));
          }),
          DashboardButton(title: "Add Inmate", icon: Icons.person_add, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddInmatePage()));
          }),
        ],
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardButton({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 28, color: Colors.white),
          label: Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}