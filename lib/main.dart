import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}