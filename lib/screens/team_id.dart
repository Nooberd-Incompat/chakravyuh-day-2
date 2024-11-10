import 'package:flutter/material.dart';
import 'package:chakravyuh/screens/start_screen.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  @override
  void initState() {
    super.initState();
    _loadCSVData();
  }

  Future<void> _loadCSVData() async {
    final csvData = await rootBundle.loadString('assets/teamId.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

    for (var i = 1; i < rows.length; i++) {
      String teamId = rows[i][0];
      int value = rows[i][1];
      teamData[teamId] = value;
    }
  }

  void _updateTeamID(String value) {
    setState(() {
      teamID = value;
      n = teamData[teamID];
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
                    if (!teamData.containsKey(value)) {
                      return 'Invalid Team ID';
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