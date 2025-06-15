import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_recommendation_bot/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JobRecommendationApp());
    expect(find.text('Find Your Perfect Job'), findsOneWidget);
  });
}