import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:igme_project_2/data/spell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elden Ring Spell Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Elden Ring Spell Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  final response = await http.get(
                    Uri.parse(
                      "https://api.eldenring.thomasberrios.com/sorceries/Glintstone%20Nail",
                    ),
                  );

                  Spell spell = Spell(json: jsonDecode(response.body));

                  print("${spell.name} int requirement: ${spell.intelligence}");
                },
                child: Text("Sorcery Button demo"),
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  final response = await http.get(
                    Uri.parse(
                      "https://api.eldenring.thomasberrios.com/incantations/Black%20Flame",
                    ),
                  );

                  Spell spell = Spell(json: jsonDecode(response.body));

                  print("${spell.name} faith requirement: ${spell.faith}");
                },
                child: Text("Incant Button demo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
