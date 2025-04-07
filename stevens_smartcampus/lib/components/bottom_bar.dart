import 'package:flutter/material.dart';
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
    Placeholder(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
