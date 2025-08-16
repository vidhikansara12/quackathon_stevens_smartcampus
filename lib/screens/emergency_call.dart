import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stevens_smartcampus/components/chat_scaffold.dart';

class EmergencyPage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {
      'title': 'Campus Police',
      'location': 'Kidde Building, Ground Floor',
      'phone': '2012163911',
    },
    {
      'title': 'Health Care',
      'location': 'Student Wellness Center',
      'phone': '2012165678',
    },
    {
      'title': 'Domestic Violence Helpline',
      'location': '',
      'phone': '2013335700',
    },
  ];

  EmergencyPage({super.key});

  void _confirmAndCall(BuildContext context, String number) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Call"),
        content: Text("Do you want to call $number?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final Uri url = Uri(scheme: 'tel', path: number);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Could not call $number")),
                );
              }
            },
            child: const Text("Call"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Colors.red[600],
        leading: BackButton(),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/images/WhatsApp Image 2025-04-03 at 01.31.47.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/appbar_logo.png',
                            width: 65,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'SmartCampus',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: contacts.map((contact) {
                          return Card(
                            color: Colors.red[100],
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(contact['title']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  if (contact['location']!.isNotEmpty)
                                    Text(contact['location']!,
                                        style: const TextStyle(
                                            color: Colors.black54)),
                                  GestureDetector(
                                    onTap: () =>
                                        _confirmAndCall(context, contact['phone']!),
                                    child: Text(
                                      contact['phone']!,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
