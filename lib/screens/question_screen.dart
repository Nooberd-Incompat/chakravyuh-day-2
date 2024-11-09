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
        MaterialPageRoute(builder: (context) => const CrosswordPage(title:"CROSSWORD")), // Replace with your target screen
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Color.fromARGB(255, 248, 224, 209),
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
                        color: Color.fromARGB(255, 246, 189, 115),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Who was the eldest Pandava?',
                      style: TextStyle(fontSize: 22, color: Color.fromARGB(221, 2, 2, 2)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _handleOptionSelected(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _selectedOption == index ? Color.fromARGB(255, 248, 224, 209) : Colors.white,
                      border: Border.all(
                        color: _selectedOption == index ? const Color.fromARGB(255, 246, 189, 115) : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      options[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _selectedOption == index ? const Color.fromARGB(255, 246, 189, 115): Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 186, 96),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18)),
              ),
            ),
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
