// This file contains the ViewModel for the feedback page
// Handles UI state and application logic and connects the View with the Service
import 'package:flutter/material.dart';
import '../models/feedback_request.dart';
import '../services/feedback_service.dart';

class FeedbackViewModel extends ChangeNotifier {
  FeedbackViewModel({required this.feedbackService});

  // Service that sends data to the backend
  final FeedbackService feedbackService;

  // Message shown in the UI after success or error
  String responseMessage = "";
  // Tells the UI if the app is currently waiting for the backend response
  bool isLoading = false;

  // Sends feedback and updates UI state
  Future<void> sendFeedback({
    required String name,
    required String feedback,
    required VoidCallback clearFields,
  }) async {
    // Start loading state
    isLoading = true;
    responseMessage = "";
    notifyListeners();

    try {
      // Create a model object from user input
      final request = FeedbackRequest(name: name, feedback: feedback);
      // Send the request to the backend and wait for the response
      final String message = await feedbackService.sendFeedback(request);

      responseMessage = message; // Save the success message from the backend
      notifyListeners();

      // Clear input fields after successful request
      Future.delayed(const Duration(seconds: 5), () {
        clearFields();
        responseMessage = "";
        notifyListeners();
      });
    } catch (error) {
      // If something goes wrong, show the error message
      responseMessage = error.toString();
      notifyListeners();
    } finally {
      // Stop loading state
      isLoading = false;
      notifyListeners();
    }
  }
}
