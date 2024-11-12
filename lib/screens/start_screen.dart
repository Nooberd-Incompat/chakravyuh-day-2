import 'package:chakravyuh/screens/instruction_screen.dart';
import 'package:chakravyuh/screens/pattern_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final int n;

  const StartScreen({super.key, required this.n});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/GDGxIOTA.png',
              width: 600.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/Chakravyuh.png',
              width: 300.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40),

            // Display dynamic +n
            Text(
              '+$n',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InstructionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
