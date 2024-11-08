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
    return Center(
      child: TextButton(
        onPressed: () => _navigateToNextScreen(context),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
        child: const Text(
          "Next",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
