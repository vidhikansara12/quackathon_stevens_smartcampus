import 'package:flutter/material.dart';
import 'package:stevens_smartcampus/screens/booking_shuttle.dart';
import 'package:stevens_smartcampus/screens/emergency_call.dart';
import 'package:stevens_smartcampus/screens/home_screen.dart';
import 'package:stevens_smartcampus/screens/map_screen.dart';
import 'package:stevens_smartcampus/screens/profile_screen.dart';

class BottomPage extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomPage({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    MapPage(),
    EmergencyPage(),
    ShuttleHomeScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // Make the bar black to match your design
        backgroundColor: Colors.black,
        // Keep icons in place, no shifting
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onTap,
        // Hide labels (no text under icons)
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // Override item colors with custom icons; these won't change on selection
        selectedItemColor: Colors.transparent,
        unselectedItemColor: Colors.transparent,
        items: [
          // 1) Home icon (green)
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.green),
            label: '',
          ),
          // 2) Location pin (white)
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, color: Colors.white),
            label: '',
          ),
          // 3) Phone in a red circle
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Icon(Icons.phone, color: Colors.white, size: 20),
              ),
            ),
            label: '',
          ),
          // 4) Bus icon (white)
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus, color: Colors.white),
            label: '',
          ),
          // 5) Profile avatar
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
