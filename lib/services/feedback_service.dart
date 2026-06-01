import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedbackService {
  // Android emulator use localhost
  static const String baseUrl = "http://10.0.2.2:5000";

  // Sends name and feedback data to the backend with a POST request
  Future<String> sendFeedback({
    required String name,
    required String feedback,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/feedback"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      // Converts Dart data into JSON format
      body: jsonEncode(<String, String>{"name": name, "feedback": feedback}),
    );

    // Converts the JSON response from the backend into a Dart Map
    final Map<String, dynamic> responseData =
        jsonDecode(response.body) as Map<String, dynamic>;

    // If the request is OK - then return the backend message
    if (response.statusCode == 200) {
      return responseData["message"] ?? "Feedback sent successfully.";
    } else {
      // If the backend returns an error - then throw an exception
      throw Exception(responseData["error"] ?? "Failed to send feedback.");
    }
  }
}
