import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Widget nextScreen;
  final bool isEnabled;

  const NextButton({super.key, required this.nextScreen, this.isEnabled = false});

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: isEnabled ? () => _navigateToNextScreen(context) : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          backgroundColor: isEnabled ? const Color.fromARGB(255, 246, 189, 115) : Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), 
          ),
        ),
        child: const Text(
          "Next",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
