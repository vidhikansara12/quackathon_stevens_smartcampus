import 'package:flutter/material.dart';
import 'package:stevens_smartcampus/components/chat_scaffold.dart';
import 'home_page_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatScaffold(
      body: HomePageContent(),
    );
  }
}
