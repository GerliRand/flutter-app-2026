// This is the application main file - starts the app and opens the FeedbackPage view
import 'package:flutter/material.dart';
import 'views/feedback_page.dart';

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
      // Basic theme for the app (color)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 90, 140, 186),
        ),
      ),
      // First page that is shown when the app starts
      home: const FeedbackPage(),
    );
  }
}
