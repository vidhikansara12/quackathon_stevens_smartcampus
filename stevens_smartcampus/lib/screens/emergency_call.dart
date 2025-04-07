import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text("Confirm Call"),
        content: Text("Do you want to call $number?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final Uri url = Uri(scheme: 'tel', path: number);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Could not call $number")));
              }
            },
            child: Text("Call"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.25,
          child: Image.asset(
            'assets/images/WhatsApp Image 2025-04-03 at 01.31.47.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: contacts.map((contact) {
                  return Card(
                    color: Colors.red[100],
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(contact['title']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          if (contact['location']!.isNotEmpty)
                            Text(contact['location']!,
                                style: TextStyle(color: Colors.black54)),
                          GestureDetector(
                            onTap: () => _confirmAndCall(
                                context, contact['phone']!),
                            child: Text(
                              contact['phone']!,
                              style: TextStyle(
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
          ),
        )
      ],
    );
  }
}