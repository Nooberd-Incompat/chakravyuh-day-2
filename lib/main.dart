import 'package:chakravyuh/screens/team_id.dart';
import 'package:flutter/material.dart';

String id = "";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chakravyuh Day 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 214, 145, 49)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const TeamID(title: 'Team ID'),
    );
  }
}
