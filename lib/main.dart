import 'package:flutter/material.dart';
import 'package:igme_project_2/spell_view.dart';

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
      theme: ThemeData(colorScheme: ColorScheme.dark()),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Elden Ring Spell Viewer'),
            bottom: TabBar(
              tabs: [Tab(text: 'Sorceries'), Tab(text: 'Incantations')],
            ),
          ),
          body: TabBarView(
            children: [
              SpellView(
                url: "https://api.eldenring.thomasberrios.com/sorceries",
                name: "Sorceries",
              ),
              SpellView(
                url: "https://api.eldenring.thomasberrios.com/incantations",
                name: "Incantations",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
