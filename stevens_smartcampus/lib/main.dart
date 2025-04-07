import 'package:flutter/material.dart';
import 'package:stevens_smartcampus/components/nav_screen.dart';
import 'package:stevens_smartcampus/screens/welcome_screen.dart';
import 'package:stevens_smartcampus/screens/login_screen.dart';
import 'package:stevens_smartcampus/screens/okta_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stevens SmartCampus',
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/verify': (context) => const OktaVerifyPage(),
        '/nav': (context) => const NavScreen(), 
      },
    );
  }
}
