import 'package:flutter/material.dart';
import 'package:chakravyuh/screens/start_screen.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

int? n;

class TeamID extends StatefulWidget {
  const TeamID({super.key, required this.title});

  final String title;

  @override
  State<TeamID> createState() => _TeamIDState();
}

class _TeamIDState extends State<TeamID> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamIDController = TextEditingController();
  String teamID = '';
  Map<String, int> teamData = {};

  int hashToInt1To26(String input) {
    // Step 1: Create a SHA-256 hash of the input string
    var bytes = utf8.encode(input); // Convert string to UTF-8 byte array
    var hash = sha256.convert(bytes); // Hash the byte array using SHA-256

    // Step 2: Convert the hash to an integer
    var hashInt =
        hash.bytes.fold<int>(0, (previous, element) => previous + element);

    // Step 3: Map the integer to a range between 1 and 26
    return (hashInt % 26) + 1;
  }

  void _updateTeamID(String value) {
    setState(() {
      teamID = value;
      n = hashToInt1To26(teamID);
    });
  }

  void _validateAndProceed() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartScreen(n: n ?? 0),
        ),
      );
    }
  }

  @override
  void dispose() {
    _teamIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Please enter your TeamID to proceed',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _teamIDController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Team ID',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _updateTeamID,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Team ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateAndProceed,
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
