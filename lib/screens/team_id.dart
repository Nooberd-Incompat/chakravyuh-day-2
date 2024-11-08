import 'package:chakravyuh/screens/next_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class TeamID extends StatefulWidget {
  const TeamID({super.key, required this.title});

  final String title;

  @override
  State<TeamID> createState() => _TeamIDState();
}

class _TeamIDState extends State<TeamID> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NextButton(
              nextScreen: NextScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
