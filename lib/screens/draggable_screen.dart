import 'package:chakravyuh/screens/notes_screen.dart';
import 'package:chakravyuh/screens/pattern_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class DraggableScreen extends StatefulWidget {
  const DraggableScreen({super.key});

  @override
  _DraggableScreenState createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {
  List<LetterBox> letterBoxes = [];

  @override
  void initState() {
    super.initState();

    const letters = [
      'BHEEM',
      'ARJUN',
      'KRISHNA',
      'BHEESMA',
      'KARNA',
      'DURYODHAN'
    ];
    int maxLength =
        letters.map((e) => e.length).reduce((a, b) => a > b ? a : b);

    letterBoxes = List.generate(letters.length, (index) {
      return LetterBox(
        id: index,
        letter: letters[index],
        isKey: letters[index] == 'BHEESMA',
        width: maxLength * 30.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boxHeight = 60.0;
    const double spacing = 10.0;
    int lettersPerRow = 1;
    double totalWidth = (letterBoxes[0].width * lettersPerRow) +
        (spacing * (lettersPerRow - 1));
    double xOffset = (screenWidth - totalWidth) / 2;
    double yOffset = 50.0;

    for (int i = 0; i < letterBoxes.length; i++) {
      double x = xOffset;
      double y = yOffset + i * (boxHeight + spacing);
      letterBoxes[i].position = Offset(x, y);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 100),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'The one who stood still for his vow will guide you forward',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 50),

          Expanded(
            child: Stack(
              children: [
                ...letterBoxes.map((box) {
                  return Positioned(
                    top: box.position.dy,
                    left: box.position.dx,
                    child: Draggable<LetterBox>(
                      data: box,
                      feedback: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: box.width,
                          height: boxHeight,
                          color: Colors.purple,
                          child: Center(
                            child: Text(
                              box.letter,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        width: box.width,
                        height: boxHeight,
                        color: Colors.grey,
                      ),
                      onDragStarted: () {
                        setState(() {
                          box.isBeingDragged = true;
                        });
                      },
                      onDragEnd: (_) {
                        setState(() {
                          box.isBeingDragged = false;
                        });
                      },
                      child: Container(
                        width: box.width,
                        height: boxHeight,
                        color: const Color.fromARGB(255, 86, 28, 145),
                        child: Center(
                          child: Text(
                            box.letter,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      onDraggableCanceled: (velocity, offset) {
                        setState(() {
                          box.position = offset;
                        });
                      },
                    ),
                  );
                }).toList(),
                ..._buildSingleLetterButtons(),
              ],
            ),
          ),

          const SizedBox(height: 20), // Add space for the button

          // Add the NextButton here
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: NextButton(nextScreen: PatternLockScreen()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSingleLetterButtons() {
    // Map each character to its corresponding word
    const letterMap = {
      'H': 'BHEEM',
      'R': 'ARJUN',
      'I': 'KRISHNA',
      'B': 'BHEESMA',
      'N': 'KARNA',
      'U': 'DURYODHAN',
    };

    // Generate TextButtons for each box being dragged
    return letterBoxes.where((box) => box.isBeingDragged).map((box) {
      final singleLetter = letterMap.keys
          .firstWhere((key) => letterMap[key] == box.letter, orElse: () => '');

      if (singleLetter.isNotEmpty) {
        return Positioned(
          top: box.position.dy,
          left: box.position.dx,
          child: TextButton(
            onPressed: () {
              if (singleLetter == 'B') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen()),
                );
              }
            },
            child: Text(
              singleLetter,
              style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 83, 2, 86),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }).toList();
  }
}

class LetterBox {
  final int id;
  final String letter;
  final bool isKey;
  final double width;
  bool isBeingDragged = false; // Track dragging state
  Offset position;

  LetterBox({
    required this.id,
    required this.letter,
    required this.isKey,
    required this.width,
    Offset? position,
  }) : position = position ?? const Offset(100.0, 100.0);
}
