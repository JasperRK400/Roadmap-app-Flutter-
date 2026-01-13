import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RoadmapScreen(),
    );
  }
}

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  String result = "Press button to generate roadmap";

  Future<void> generateRoadmap() async {
    final response = await http.post(
      Uri.parse("https://rodmap-backend-faspapi-1.onrender.com"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "goal": "Learn DevOps",
        "current_level": "Beginner",
        "timeline_months": 6
      }),
    );

    setState(() {
      result = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Roadmap Generator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: generateRoadmap,
              child: const Text("Generate Roadmap"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(child: Text(result)),
            )
          ],
        ),
      ),
    );
  }
}
