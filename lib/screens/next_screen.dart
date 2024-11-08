// Example of a target screen to navigate to
import 'package:flutter/material.dart';
//this is a dummy next screen made for just testing the next button. Please delete this after other screens are implemented

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Screen"),
      ),
      body: Center(
        child: Text("Welcome to the Next Screen!"),
      ),
    );
  }
}
