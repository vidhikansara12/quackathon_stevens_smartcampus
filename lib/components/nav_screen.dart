import 'package:flutter/material.dart';
import 'package:stevens_smartcampus/components/bottom_bar.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomPage(
      selectedIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
