import 'package:chakravyuh/screens/notes_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class DraggableScreen extends StatefulWidget {
  @override
  _DraggableScreenState createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {
  List<LetterBox> letterBoxes = [];
  bool isSDragged = false;

  @override
  void initState() {
    super.initState();

    const letters = ['BHEEM', 'ARJUN', 'KRISHNA', 'BHEESMA', 'KARNA', 'DURYODHAN'];

    int maxLength = letters.map((e) => e.length).reduce((a, b) => a > b ? a : b);

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
    double totalWidth = (letterBoxes[0].width * lettersPerRow) + (spacing * (lettersPerRow - 1));
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
          SizedBox(height: 100),

          Padding(
            padding: const EdgeInsets.all(16.0),
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

          SizedBox(height: 50),

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
                              style: TextStyle(fontSize: 20, color: Colors.white),
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
                        if (box.letter == 'BHEESMA') {
                          setState(() {
                            isSDragged = true;
                          });
                        }
                      },
                      onDragEnd: (_) {
                        if (box.letter == 'BHEESMA') {
                          setState(() {
                            isSDragged = false;
                          });
                        }
                      },
                      child: Container(
                        width: box.width,
                        height: boxHeight,
                        color: Color.fromARGB(255, 86, 28, 145),
                        child: Center(
                          child: Text(
                            box.letter,
                            style: TextStyle(fontSize: 25, color: Colors.white),
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

                if (isSDragged)
                  Positioned(
                    top: letterBoxes[3].position.dy,
                    left: letterBoxes[3].position.dx,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotesScreen()), // Navigate to NotesScreen
                        );
                      },
                      child: Text(
                        'b',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 83, 2, 86),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 20), // Add space for the button

          // Add the NextButton here
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: NextButton(nextScreen: NotesScreen()),  
          ),
        ],
      ),
    );
  }
}

class LetterBox {
  final int id;
  final String letter;
  final bool isKey;
  final double width;
  Offset position;

  LetterBox({
    required this.id,
    required this.letter,
    required this.isKey,
    required this.width,
    Offset? position,
  }) : position = position ?? Offset(100.0, 100.0);
}
