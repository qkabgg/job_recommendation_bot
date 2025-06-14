import 'package:flutter/material.dart';

void main() {
  runApp(const JobRecommendationApp());
}

class JobRecommendationApp extends StatelessWidget {
  const JobRecommendationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Recommendation Bot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Recommendation Bot'),
      ),
      body: const Center(
        child: Text('Welcome to Job Recommendation Bot'),
      ),
    );
  }
}