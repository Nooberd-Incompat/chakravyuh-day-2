import 'package:flutter/material.dart';
import 'package:chakravyuh/screens/crossword_screen.dart'; // Assuming this is your next screen

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.title});

  final String title;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int? _selectedOption;
  final int correctAnswerIndex = 0; // "Yudhishthira" is the correct answer at index 0

  void _handleOptionSelected(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  void _checkAnswer() {
    if (_selectedOption == correctAnswerIndex) {
      // Navigate to another screen if the answer is correct
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CrosswordPage(title: "CROSSWORD")), // Replace with your target screen
      );
    } else {
      // Show a dialog if the answer is incorrect
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Incorrect Answer"),
          content: const Text("Please try again!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212), // Dark gray background (not pure black)
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100), // Adjust space at the top

            // Card for the question
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(0xFF2A2A2A), // Slightly lighter dark color
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Question 1:',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Color(0xFFD4D2D2),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Who was the eldest Pandava?',
                      style: TextStyle(fontSize: 22, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // List of options
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _handleOptionSelected(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _selectedOption == index ? Color(0xFF333333) : Color(0xFF1E1E1E), // Darker option colors
                      border: Border.all(
                        color: _selectedOption == index ? Color.fromARGB(255, 182, 134, 255) : Color(0xFF444444),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      options[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _selectedOption == index ? Colors.white : Colors.white70, // Light text
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Next button
            Center(
              child: ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255), // Soft amber button color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

// Options for the question
List<String> options = [
  "Yudhishthira",
  "Bhima",
  "Arjuna",
  "Nakul"
];
