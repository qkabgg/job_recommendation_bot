import 'package:flutter/material.dart';

class SkillsInputScreen extends StatelessWidget {
  const SkillsInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Skills'),
      ),
      body: const Center(
        child: Text('Skills Input Screen'),
      ),
    );
  }
}