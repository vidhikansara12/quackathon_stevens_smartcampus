import 'package:flutter/material.dart';
import 'package:stevens_smartcampus/components/app_bar.dart';
// import 'package:stevens_smartcampus/components/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE9E9E9),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(), // Using custom app bar here
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shuttle Services',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: const Text(
                            'Schedule',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: const Text(
                            'Book your shuttle 3hrs prior and go hustle free',
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 3,
                        color: const Color(0xFFFFDADA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: const Text('Instant shuttle booking'),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Campus Navigation',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: const Text('Find a classroom'),
                          subtitle: const Text('Navigate inside the campus'),
                          trailing: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/classroom.png',
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 60,
                                height: 40,
                                color: Colors.grey[300],
                                child: const Icon(Icons.meeting_room),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: const Text('Navigate'),
                          subtitle: const Text('Roam around the campus'),
                          trailing: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/campus.png',
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 60,
                                height: 40,
                                color: Colors.grey[300],
                                child: const Icon(Icons.landscape),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.headset_mic,
                                      color: Colors.blue,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Customer Service for Shuttles:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.circle, size: 8),
                                        SizedBox(width: 8),
                                        Text('201.474.3376'),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.circle, size: 8),
                                        SizedBox(width: 8),
                                        Text('support-stevens@ridewithvia.com'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomPage(
      //   selectedIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
