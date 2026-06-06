// This file defines the data model for feedback
// The model stores the name and feedback text before sending them to the backend
class FeedbackRequest {
  const FeedbackRequest({required this.name, required this.feedback});

  final String name;
  final String feedback;

  // Converts the Dart object into JSON format (backend expects JSON data)
  Map<String, String> toJson() {
    return {"name": name, "feedback": feedback};
  }
}
