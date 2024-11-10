import 'package:chakravyuh/screens/question_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({super.key});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Before the games begin...',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "In this stage, just like Arjuna never let his aim falter on the battlefield of Kurukshetra, it's time for you to focus and keep your eyes sharp. \n Beware of the letter trickery — not all is as it seems! Words may appear as deceptive as the illusions created by Duryodhana, but with the wisdom of Krishna guiding your mind, you'll spot the right ones! \n So, channel your inner Pandava, outsmart the puzzles, and uncover the secret key that awaits.\n May the letters align in your favor, and remember — even Draupadi had to play her cards wisely!\n Like how the Kauravs recieved the army of Krishna, we provide you with the first letter of your crusade!\nMay you be victorious\n",
                        style: TextStyle(
                            fontSize: 16, height: 1.4, color: Colors.black54),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\"c\"",
                            style: TextStyle(
                                fontSize: 40,
                                height: 1.4,
                                color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const NextButton(
                nextScreen: QuestionScreen(title: "Question"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
