// This file contains the View of the application
// Responsible for the user interface
import 'package:flutter/material.dart';
import '../services/feedback_service.dart';
import '../viewmodels/feedback_viewmodel.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // Controllers read the text from the input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  // ViewModel contains the logic and state for this page
  late final FeedbackViewModel viewModel;

  @override
  void initState() {
    super.initState();

    // Create the ViewModel and give it the FeedbackService
    viewModel = FeedbackViewModel(feedbackService: FeedbackService());

    // Rebuild the UI whenever the ViewModel changes
    viewModel.addListener(() {
      setState(() {});
    });
  }

  // Clears the input fields
  void clearFields() {
    if (!mounted) return;

    nameController.clear();
    feedbackController.clear();
  }

  @override
  void dispose() {
    // Dispose controllers and ViewModel when the page is removed
    nameController.dispose();
    feedbackController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Feedback App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              style: TextStyle(fontSize: 18),
              "Please enter your name and feedback:",
            ),

            const SizedBox(height: 20),

            // Input field - user name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Input field - feedback
            TextField(
              controller: feedbackController,
              decoration: const InputDecoration(
                labelText: "Feedback",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            // Feedback button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 86, 129, 168),
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight(700)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(6),
                ),
              ),
              // If isLoading is true, the button is disabled
              // If isLoading is false, the button calls the sendFeedback function
              onPressed: viewModel.isLoading
                  ? null
                  : () {
                      viewModel.sendFeedback(
                        name: nameController.text,
                        feedback: feedbackController.text,
                        clearFields: clearFields,
                      );
                    },
              child: viewModel.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Send feedback"),
            ),

            const SizedBox(height: 26),

            // Shows success or error message
            Text(viewModel.responseMessage, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
