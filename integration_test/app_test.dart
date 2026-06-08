// Integration test
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_app_2026/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("User can send feedback and get success message", (tester) async {
    // Load app widget
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(); // Wait until the UI is built

    // Check that the feedback page is visible
    expect(find.text("Feedback App"), findsOneWidget);
    expect(find.text("Please enter your name and feedback:"), findsOneWidget);

    // Enter text into the input fields
    await tester.enterText(find.byType(EditableText).at(0), "Gerli");
    await tester.enterText(
      find.byType(EditableText).at(1),
      "Integration test - testing",
    );

    await tester.pump(); // Updates the UI

    // Tap the send button and updates the UI
    await tester.tap(find.text("Send feedback"));
    await tester.pump();

    // Wait until the success message appears
    for (int i = 0; i < 20; i++) {
      await tester.pump(const Duration(seconds: 2));

      // If the success message is found in the UI, stop the waiting loop
      if (find.textContaining("Thank you Gerli").evaluate().isNotEmpty) {
        break;
      }
    }

    // Check that the backend response is shown in the UI
    expect(find.textContaining("Thank you Gerli"), findsOneWidget);
  });
}
