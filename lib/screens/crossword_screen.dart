import 'dart:math';
import 'package:chakravyuh/screens/image_screen.dart';
import 'package:crossword/crossword.dart';
import 'package:flutter/material.dart';

class CrosswordPage extends StatefulWidget {
  const CrosswordPage({super.key, required this.title});

  final String title;
  @override
  State<CrosswordPage> createState() => _CrosswordPageState();
}

class _CrosswordPageState extends State<CrosswordPage> {
  List<List<String>> letters = [];
  List<Color> lineColors = [];
  List<int> letterGrid = [11, 14];
  GlobalKey<CrosswordState> crosswordState = GlobalKey<CrosswordState>();
  String word = "";
  bool isFirstWordGuessedCorrectly = false;
  bool isSecondWordGuessedCorrectly = false;

  List<List<String>> generateRandomLetters() {
    final random = Random();
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(
      letterGrid.first,
      (_) => List.generate(letterGrid.last, (_) => letters[random.nextInt(letters.length)]),
    );
  }

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
    if (guessedWord.toUpperCase() == "ARJUN" && !isFirstWordGuessedCorrectly) {
      setState(() {
        word = guessedWord;
        isFirstWordGuessedCorrectly = true;
      });
    } else if (guessedWord.toUpperCase() == "DRAUPADI" && !isSecondWordGuessedCorrectly) {
      setState(() {
        word = guessedWord;
        isSecondWordGuessedCorrectly = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hint Section
              Padding(
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
                    Text(
                      "Two major characters of Mahabharat",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 147, 147, 147),
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                    color: Colors.black,
                  ),
                ),
              ),
              // Crossword Grid Section
              Expanded(
                child: Crossword(
                  letterPopDecoration: const LetterPopDecoration(
                    onTouchPopScaleFactor: 1.5,
                    duration: Duration(milliseconds: 200),
                    onTouchLetterFontStyle: FontStyle.italic,
                  ),
                  revealLetterDecoration: const RevealLetterDecoration(shakeOffset: Offset(10, 20)),
                  key: crosswordState,
                  allowOverlap: false,
                  letters: const [
                    ["S", "A", "M", "R", "N", "I", "G", "K", "P", "U", "H", "T"],
                    ["U", "K", "A", "U", "I", "S", "A", "N", "R", "J", "P", "L"],
                    ["R", "N", "J", "B", "A", "U", "M", "O", "D", "E", "L", "A"],
                    ["N", "R", "D", "A", "Y", "R", "D", "K", "E", "A", "N", "I"],
                    ["A", "R", "O", "T", "N", "S", "R", "I", "J", "P", "D", "Y"],
                    ["L", "T", "A", "M", "K", "R", "A", "R", "U", "A", "R", "D"],
                    ["A", "V", "A", "S", "U", "B", "U", "A", "D", "A", "V", "P"],
                    ["H", "K", "R", "M", "E", "I", "P", "N", "A", "H", "A", "C"],
                    ["A", "A", "K", "R", "D", "M", "A", "G", "H", "U", "N", "Y"],
                    ["A", "H", "R", "I", "T", "S", "D", "D", "B", "N", "Y", "O"],
                    ["B", "H", "R", "E", "T", "A", "I", "L", "E", "S", "T", "M"]
                  ],
                  spacing: const Offset(30, 30),
                  onLineUpdate: (String guessedWord, List<String> words, bool isLineDrawn) {
                    if (isLineDrawn) {
                      checkGuess(guessedWord);
                    } else {
                      setState(() => word = guessedWord);
                    }
                  },
                  addIncorrectWord: false,
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
                  hints: const [
                    "ARJUN", "DRAUPADI" // Add more hints here if needed
                  ],
                ),
              ),
              // Next Button Section (Visible from the start, but enabled only if both words are guessed correctly)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: isFirstWordGuessedCorrectly && isSecondWordGuessedCorrectly
                      ? () {
                          // Navigate to ImageGridScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ImageGridScreen(title:"AVATARS")),
                          );
                        }
                      : null, // Disabled initially until both words are correct
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
