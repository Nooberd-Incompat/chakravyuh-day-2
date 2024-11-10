import 'package:chakravyuh/screens/image_screen.dart';
import 'package:chakravyuh/screens/next_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building NotesScreen"); // Debugging line to check if the widget is being built.

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView( 
        // Wrap the entire body in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:30),
            // Title or Instructions Text
            Text(
              'Read the notes below to find the key to the mighty warrior mentioned in the riddle:',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Notes (A to F)
            NoteCard(noteLabel: 'A', noteText: 'A warrior like no other, born of a union between a mighty hero and a mystical creature. His presence on the battlefield was like a storm, striking fear into the hearts of his enemies. Though his lineage was extraordinary, it was his actions that sealed his place in history. He may have been the son of a Pandava, but he had the power of a Rakshasa coursing through his veins.'),
            NoteCard(noteLabel: 'B', noteText: 'In the battle of Kurukshetra, he was one of the fiercest warriors, using his inherited powers to wreak havoc among the Kauravas. His physical prowess was unmatched, and his magical abilities allowed him to take on many forms. But it was his selfless act of sacrifice that would make him a hero in the eyes of his family.'),
            NoteCard(noteLabel: 'C', noteText: 'This warrior’s powers were not only derived from his mighty heritage but from his heart, which was pure and loyal to the Pandavas. The war saw many heroic figures, but none as selfless as him, who, despite knowing the odds were against him, chose to fight for his family with everything he had.'),
            NoteCard(noteLabel: 'D', noteText: 'Though he was raised among humans, his true nature was revealed when he fought to defend his family. His bloodline gave him power, but it was his courage and love for his family that made him a hero in the epic saga of the Mahabharata.'),
            NoteCard(noteLabel: 'E', noteText: 'Born of Bhima and the Rakshasi Hidimbi, his life was filled with struggle and duty. On the battlefield, his power was immense, and his presence alone could turn the tide. Yet, it was his death at the hands of the Kauravas, under the curse of their weapons, that became one of the most tragic yet heroic moments of the war.'),
            NoteCard(noteLabel: 'F', noteText: 'Ghatotkacha, the son of Bhima and Hidimbi, was a warrior whose strength, magic, and devotion to his family were unmatched. In the Kurukshetra War, he fought valiantly, and when the Kauravas used their most powerful weapon to defeat him, he sacrificed his life to save his family and allies, cementing his legacy as a true hero'), // This note contains the solution
            // Next Button to proceed
            NextButton(nextScreen: ImageGridScreen(title: 'ImageGrid')), // Assuming the NextScreen is the next step in the app
          ],
        ),
      ),
    );
  }
}

// Widget to display each note
class NoteCard extends StatelessWidget {
  final String noteLabel;
  final String noteText;

  const NoteCard({required this.noteLabel, required this.noteText});

  @override
  Widget build(BuildContext context) {
    print("Building NoteCard for $noteLabel"); // Debugging line to check if cards are being built.

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: Color.fromARGB(255, 242, 242, 242),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Note $noteLabel:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              noteText,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
