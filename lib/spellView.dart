import 'package:flutter/material.dart';

class SpellView extends StatefulWidget {
  final String url;
  final String name;

  const SpellView({Key? key, required this.url, required this.name})
    : super(key: key);

  @override
  _SpellViewState createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spell View')),
      body: SingleChildScrollView(
        child: Column(children: [Text(widget.name), Text(widget.url)]),
      ),
    );
  }
}
