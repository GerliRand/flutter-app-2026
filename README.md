# Flutter App

This is a simple Flutter feedback application for the Cross-Platform Mobile Application Development course.

The application sends feedback data to a Flask backend using an HTTP POST request.

## Features
- Name input field
- Feedback input field
- Send feedback button
- HTTP POST request to backend
- Basic error handling
- Success and error messages shown in the UI

## Technologies
- Flutter
- Dart
- http package

## Backend
This Flutter app uses a separate Flask backend: https://github.com/GerliRand/flutter-app-backend2026

When running the app in an Android emulator, the backend URL is:

```text
http://10.0.2.2:5000/feedback
```

## Setup
Install dependencies:

```bash
flutter pub get
```

## Run the app
```bash
flutter run
```
