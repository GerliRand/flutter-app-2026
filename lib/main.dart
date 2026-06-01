import 'package:flutter/material.dart';
import 'services/feedback_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 90, 140, 186),
        ),
      ),
      home: const FeedbackPage(),
    );
  }
}

// Page where the user can send feedback
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // Controllers read the text from input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  // Service class that handles the HTTP POST request
  final FeedbackService feedbackService = FeedbackService();

  String responseMessage = "";
  bool isLoading = false;

  // Sends feedback data to the backend
  Future<void> sendFeedback() async {
    setState(() {
      isLoading = true;
      responseMessage = "";
    });

    try {
      // Waits for the backend response
      final String message = await feedbackService.sendFeedback(
        name: nameController.text,
        feedback: feedbackController.text,
      );

      // Shows success message from the backend
      setState(() {
        responseMessage = message;
      });
      // Clear the inputs fields after 5 sek.
      Future.delayed(const Duration(seconds: 5), () {
        // prevents an error if the user leaves the page (before 5 sek.)
        if (!mounted) return;

        nameController.clear();
        feedbackController.clear();

        setState(() {
          responseMessage = "";
        });
      });
    } catch (error) {
      // Shows error message if something goes wrong
      setState(() {
        responseMessage = error.toString();
      });
    } finally {
      // Stops loading state after request is completed
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Releases controller resources when the widget is removed
    nameController.dispose();
    feedbackController.dispose();
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
              onPressed: isLoading ? null : sendFeedback,
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Send feedback"),
            ),

            const SizedBox(height: 26),

            Text(responseMessage, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
