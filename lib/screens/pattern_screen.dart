import 'package:chakravyuh/screens/crossword_screen.dart';
import 'package:crossword/crossword.dart';
import 'package:flutter/material.dart';

class PatternLockScreen extends StatefulWidget {
  const PatternLockScreen({super.key});

  @override
  _PatternLockScreenState createState() => _PatternLockScreenState();
}

class _PatternLockScreenState extends State<PatternLockScreen> {
  // Updated grid size and pattern
  final int gridSize = 5;
  List<int> selectedPattern = [];

  // Pattern for first, middle, and last rows in a 5x5 grid
  final List<int> correctPattern = [
    0, 1, 2, 3, 4, // first row,
    5,
    10, 11, 12, 13, 14, // middle row (3rd row)
    15,
    20, 21, 22, 23, 24 // last row
  ];

  void onDotTap(int index) {
    setState(() {
      // Toggle the selection state of the dot
      if (selectedPattern.contains(index)) {
        selectedPattern.remove(index); // Deselect if already selected
      } else {
        selectedPattern.add(index); // Select if not already selected
      }

      // Print the selected dots (for testing)
      print("Selected Dots: $selectedPattern");
    });
  }

  bool isPatternCorrect() {
    return selectedPattern.length == correctPattern.length &&
        selectedPattern.every((index) => correctPattern.contains(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text above the pattern
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Choose the right pattern to proceed",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Grid of dots
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              padding: EdgeInsets.all(20),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onDotTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedPattern.contains(index)
                          ? const Color.fromARGB(255, 243, 173, 33)
                          : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          // Next button
          ElevatedButton(
            onPressed: isPatternCorrect()
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CrosswordPage()),
                    );
                  }
                : null,
            child: Text("Next"),
          ),
        ],
      ),
    );
  }
}
