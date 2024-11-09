import 'package:chakravyuh/screens/question_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({super.key, required this.title});

  final String title;

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Dark background color for dark theme
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.grey[800], // Dark card color
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome to the Quiz!',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), // White text for dark background
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Please read the instructions carefully before proceeding:',
                        style: TextStyle(fontSize: 16, color: Colors.white70), // Light color text
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. Each question has a time limit.\n'
                        '2. You cannot go back to previous questions.\n'
                        '3. Try to answer each question within the given time.',
                        style: TextStyle(fontSize: 16, height: 1.4, color: Colors.white60), // Lighter color text
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              NextButton(
                nextScreen: QuestionScreen(title:"Question"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
