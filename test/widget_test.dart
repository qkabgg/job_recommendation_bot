import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_recommendation_bot/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const JobRecommendationApp());

    // You can add your widget tests here
    // For example:
    expect(find.text('Job Recommendation Bot'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}