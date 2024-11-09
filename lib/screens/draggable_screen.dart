import 'package:flutter/material.dart';

class DraggableScreen extends StatefulWidget {
  @override
  _DraggableScreenState createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {
  final List<Map<String, String>> sentenceWords = [
    {'word': 'Mahabharat', 'code': ''},
    {'word': 'is', 'code': ''},
    {'word': 'an', 'code': ''},
    {'word': 'epic', 'code': ''},
    {'word': 'story', 'code': ''},
    {'word': 'from', 'code': ''},
    {'word': 'India', 'code': 'K'}, // Special case for 'India'
    {'word': 'about', 'code': ''},
    {'word': 'the', 'code': ''},
    {'word': 'Kurukshetra', 'code': ''},
  ];

  final Map<String, bool> wordRevealed = {};
  bool showNextButton = false; // Control the visibility of the "Next" button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Text(
              'Drag and Drop the Words to Reveal Their Hidden Code!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(height: 20),
            
            // Non-scrollable draggable words with Wrap
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: sentenceWords.map((wordData) {
                String word = wordData['word']!;
                String code = wordData['code']!;
                return Draggable<String>(
                  data: code,
                  child: _buildDraggableWord(word, isFeedback: false),
                  feedback: _buildDraggableWord(word, isFeedback: true),
                  childWhenDragging: Container(),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Drop the words in the correct zones below to reveal the hidden letter code.',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 133, 132, 132)),
            ),
            const SizedBox(height: 10),

            // Scrollable drop zones
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 3,
                ),
                itemCount: sentenceWords.length,
                itemBuilder: (context, index) {
                  String word = sentenceWords[index]['word']!;
                  String code = sentenceWords[index]['code']!;

                  return DragTarget<String>(
                    onAccept: (receivedCode) {
                      if (receivedCode == code) {
                        setState(() {
                          wordRevealed[word] = true;
                          if (word == 'India') {
                            showNextButton = true; // Show "Next" button after "India" is revealed
                          }
                        });
                      }
                    },
                    builder: (context, acceptedItems, rejectedItems) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 251, 251, 251),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              word,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (wordRevealed[word] == true)
                              Text(
                                sentenceWords[index]['code']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 58, 141, 137),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Conditionally display the "Next" button
            if (showNextButton)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Define what happens when "Next" is pressed
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceeding to the next step!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Button color
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableWord(String word, {bool isFeedback = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isFeedback ? Colors.yellow.withOpacity(0.8) : Colors.orange,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Text(
        word,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
