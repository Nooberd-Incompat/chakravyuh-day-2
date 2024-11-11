import 'package:chakravyuh/screens/team_id.dart';
import 'package:flutter/material.dart';
import 'package:chakravyuh/screens/start_screen.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({super.key});

  @override
  _EndScreenState createState() => _EndScreenState();
}

String shiftStringByK(String input, int k) {
  return input
      .split('')
      .map((char) {
        if (char.contains(RegExp(r'[a-zA-Z]'))) {
          int code = char.codeUnitAt(0);

          // Shift uppercase letters (A-Z)
          if (code >= 65 && code <= 90) {
            return String.fromCharCode(65 + (code - 65 + k) % 26);
          }
          // Shift lowercase letters (a-z)
          else if (code >= 97 && code <= 122) {
            return String.fromCharCode(97 + (code - 97 + k) % 26);
          }
        }
        // Non-alphabetic characters remain unchanged
        return char;
      })
      .join('')
      .toLowerCase();
}

class _EndScreenState extends State<EndScreen> {
  final TextEditingController _keyController = TextEditingController();
  final String correctKey = shiftStringByK("cbbkejlf",
      n!);
  String? feedbackMessage;

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  void _validateKey() {
    setState(() {
      if (_keyController.text == correctKey) {
        feedbackMessage =
            "Correct! Show this key (${_keyController.text}) to the lead to proceed to the next round.";
      } else {
        feedbackMessage =
            "Incorrect key. Hint: The number in the start, shift your answer by it to get your unique key.";
      }
    });
  }

  void _retry() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartScreen(
          n: n ?? 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(correctKey);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "You have reached the end! Do you have the key to proceed?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Form field for entering the key
              TextField(
                controller: _keyController,
                decoration: InputDecoration(
                  labelText: 'Enter your key',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: const OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Submit button to validate the key
              ElevatedButton(
                onPressed: _validateKey,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text("Submit"),
              ),

              const SizedBox(height: 20),

              // Display feedback message
              if (feedbackMessage != null)
                Text(
                  feedbackMessage!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 20),

              // Retry button to go back to the start screen
              if (feedbackMessage != null &&
                  feedbackMessage!.contains("Incorrect"))
                ElevatedButton(
                  onPressed: _retry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Retry"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
