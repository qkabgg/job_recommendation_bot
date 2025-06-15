import 'package:flutter_test/flutter_test.dart';

import 'package:job_recommendation_bot/main.dart';  // Make sure this import matches your package name

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());  // Changed from JobRecommendationApp to MyApp

    // You can add your test cases here
    // For example:
    expect(find.text('Job Matches'), findsOneWidget);
    expect(find.text('Find your perfect role'), findsOneWidget);
  });
}