// Widget test - UI
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_2026/views/feedback_page.dart';

void main() {
  testWidgets("Feedback page shows all elements", (tester) async {
    // MaterialApp because FeedbackPage use Material-widgets
    await tester.pumpWidget(const MaterialApp(home: FeedbackPage()));

    // Create the Finders
    final titleFinder = find.text("Feedback App");
    final instructionFinder = find.text("Please enter your name and feedback:");
    final nameFieldFinder = find.text("Name");
    final feedbackFieldFinder = find.text("Feedback");
    final buttonFinder = find.text("Send feedback");

    // Checing that all important UI elements are found
    expect(titleFinder, findsOneWidget);
    expect(instructionFinder, findsOneWidget);
    expect(nameFieldFinder, findsOneWidget);
    expect(feedbackFieldFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
