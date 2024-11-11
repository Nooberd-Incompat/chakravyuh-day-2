import 'dart:math';
import 'package:chakravyuh/screens/image_screen.dart';
import 'package:crossword/crossword.dart';
import 'package:flutter/material.dart';

class CrosswordPage extends StatefulWidget {
  const CrosswordPage({super.key});

  @override
  State<CrosswordPage> createState() => _CrosswordPageState();
}

class _CrosswordPageState extends State<CrosswordPage> {
  List<List<String>> letters = [];
  List<Color> lineColors = [];

  String word = "";
  bool isFirstWordGuessedCorrectly = false;

  Color generateRandomColor() {
    Random random = Random();
    int r = random.nextInt(128) + 128; // Red component between 128 and 255
    int g = random.nextInt(128) + 128; // Green component between 128 and 255
    int b = random.nextInt(128) + 128; // Blue component between 128 and 255
    return Color.fromARGB(255, r, g, b);
  }

  @override
  void initState() {
    super.initState();
    lineColors = List.generate(100, (_) => generateRandomColor());
  }

  void checkGuess(String guessedWord) {
    if (guessedWord.toUpperCase() == "KRISHNA" &&
        !isFirstWordGuessedCorrectly) {
      setState(() {
        word = guessedWord;
        isFirstWordGuessedCorrectly = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      "Hint:",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Who is the charioteer of Ar",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "j", // Make the "j" italic
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: "una in the Mahabharata?",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              // Word Display Section
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  word,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Crossword Grid Section (10x10 Grid)
              Expanded(
                child: Crossword(
                  letterPopDecoration: const LetterPopDecoration(
                    onTouchPopScaleFactor: 1.5,
                    duration: Duration(milliseconds: 200),
                    onTouchLetterFontStyle: FontStyle.italic,
                  ),
                  allowOverlap: false,
                  letters: const [
                    ["T", "H", "F", "P", "S", "M", "G", "Q", "A", "L"],
                    ["K", "R", "I", "S", "H", "N", "A", "Z", "D", "P"],
                    ["F", "O", "L", "A", "V", "C", "O", "T", "E", "X"],
                    ["L", "D", "P", "Q", "Y", "O", "R", "B", "J", "N"],
                    ["E", "T", "A", "I", "Z", "K", "W", "U", "C", "L"],
                    ["O", "C", "N", "F", "I", "R", "R", "S", "Q", "A"],
                    ["G", "Y", "D", "W", "A", "J", "I", "E", "M", "O"],
                    ["W", "R", "B", "J", "L", "T", "V", "P", "F", "D"],
                    ["X", "M", "L", "E", "W", "D", "S", "Z", "K", "Q"],
                    ["P", "B", "F", "A", "H", "Y", "L", "O", "J", "R"]
                  ],
                  spacing: const Offset(30, 30),
                  onLineUpdate: (String guessedWord, List<String> words,
                      bool isLineDrawn) {
                    if (isLineDrawn) {
                      checkGuess(
                          guessedWord); // Check if the guessed word is correct
                    } else {
                      setState(() => word = guessedWord);
                    }
                  },
                  addIncorrectWord: true,
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 185, 51, 41),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  lineDecoration: const LineDecoration(
                    lineGradientColors: [
                      [
                        Color.fromARGB(255, 236, 198, 144),
                        Color.fromARGB(255, 248, 202, 102),
                        Color.fromARGB(255, 240, 176, 74)
                      ],
                    ],
                    strokeWidth: 26,
                    lineTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  hints: const [""],
                ),
              ),
              // Next Button Section (Visible from the start, but enabled only if the word is guessed correctly)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: isFirstWordGuessedCorrectly
                      ? () {
                          // Navigate to ImageGridScreen
                          Navigator.push(
                            context,
                          );
                        }
                      : null, // Disabled initially until the word "KRISHNA" is guessed
                  child: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 186, 96),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}