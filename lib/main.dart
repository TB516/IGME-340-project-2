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
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Elden Ring Spell Viewer'),
            bottom: TabBar(
              tabs: [Tab(text: 'Sorceries'), Tab(text: 'Incantations')],
            ),
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Elden Ring Spell Viewer'),
                            content: const SingleChildScrollView(
                              child: Text('''
The process of creating the app went pretty smoothly for the most part. I started off with the controls, then moved over to the cards, then wrapped everything up with the favorites feature. I did encounter some errors which prolonged my dev time a fair bit, but they weren't apart of the app itself. They were actually related to the API I was using. The issues were due to bad data for some image urls. As I'm the owner of that API, I was able to find out the issue once I realized it was an API issue, so that was good at least. For meeting the requirements, on either of the main screens, you can see multiple form controls, and there aren't many errors to encounter as the main search is a filter instead of a direct search. Overall I think the app turned out pretty nice, though I think a separate section for the bookmarks could be useful and tuning the styling couldn't hurt.
                            '''),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.info),
                  );
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              /// Sorceries tab for displaying sorceries
              SpellView(
                url: "https://api.eldenring.thomasberrios.com/sorceries",
                name: "Sorceries",
              ),

              /// Incantations tab for displaying incantations
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
