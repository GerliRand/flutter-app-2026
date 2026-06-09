// This file handles communication with the backend
// It sends feedback data to the Flask API using an HTTP POST request
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feedback_request.dart';

class FeedbackService {
  // Android emulator use localhost
  static const String baseUrl = "http://10.0.2.2:5000";

  // Localhost - when using the mobile
  //static const String baseUrl = "http://127.0.0.1:5000";

  // Sends feedback data to the backend with a POST request
  Future<String> sendFeedback(FeedbackRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/feedback"),
      // Tells the backend that the request body is JSON.
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      // Converts Dart data into JSON format
      body: jsonEncode(request.toJson()),
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
