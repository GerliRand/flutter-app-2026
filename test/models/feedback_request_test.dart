import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_2026/models/feedback_request.dart';

void main() {
  group("FeedbackRequest", () {
    test("Should convert name and feedback into JSON format", () {
      // Test data is generated
      final request = FeedbackRequest(
        name: "Gerli",
        feedback: "This app is great",
      );

      // Calls models toJson() method
      final json = request.toJson();

      // These check that the JSON contains the correct values
      expect(json["name"], "Gerli");
      expect(json["feedback"], "This app is great");
    });
  });
}
