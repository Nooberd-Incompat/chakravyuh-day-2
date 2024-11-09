import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Widget nextScreen;
  const NextButton({super.key, required this.nextScreen});

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _navigateToNextScreen(context),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        backgroundColor: const Color(0xFFF5E6D3), // Cream color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Optional: adds rounded corners
        ),
      ),
      child: const Text(
        "Next",
        style: TextStyle(
          color: Color(0xFF8B4513), // Brown color for text
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
