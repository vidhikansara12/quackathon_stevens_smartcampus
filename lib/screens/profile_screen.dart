import 'package:flutter/material.dart';
import 'package:stevens_smartcampus/components/chat_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _wheelchairAccess = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ChatScaffold(
      body: Stack(
        children: [
          // Background image with dynamic dimensions
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/images/WhatsApp Image 2025-04-03 at 01.31.47.jpeg',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover,
            ),
          ),
          // Main content wrapped in SafeArea & SingleChildScrollView
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard("Name:", "Robinhood"),
                  _buildInfoCard("CWID:", "20034545"),
                  _buildInfoCard("Email:", "rhod23@stevens.edu"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Wheelchair accessibility",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Switch(
                        value: _wheelchairAccess,
                        onChanged: (value) {
                          setState(() {
                            _wheelchairAccess = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Logged Out"),
                          content: const Text("You have been logged out."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Navigate to the login page and remove all previous routes
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              },
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text("LOGOUT", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
