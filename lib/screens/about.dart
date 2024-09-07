import 'package:flutter/material.dart';
import 'package:pro/shared/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About This App"),
        backgroundColor: Colors.purple,
      ),
      body : const Center(child: Text('HEY THIS A REAL TIME QUIZ APP'
      ,style: TextStyle(fontWeight: FontWeight.bold),)),
      bottomNavigationBar: const AppBottomNav());
  }
}
