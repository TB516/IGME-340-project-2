import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:igme_project_2/data/spell.dart';
import 'package:http/http.dart' as http;

class SpellView extends StatefulWidget {
  final String url;
  final String name;

  const SpellView({super.key, required this.url, required this.name});

  @override
  _SpellViewState createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {
  final _formId = GlobalKey<FormState>();
  int? _slotsValue;
  int? _fpValue;
  String _spellName = "";
  List<Spell> _spells = [];

  List<Spell> createSpellsList(String json) {
    dynamic data = jsonDecode(json);
    List<Spell> spells = [];

    for (var spell in data) {
      spells.add(Spell(json: spell));
    }

    return spells;
  }

  /// Makes http request to fetch spells from the API and populates the list of spells
  void fetchSpells() async {
    String url = "${widget.url}?";

    if (_spellName.isNotEmpty) {
      url += "name=$_spellName&";
    }
    if (_fpValue != null) {
      url += "fp=$_fpValue&";
    }
    if (_slotsValue != null) {
      url += "slots=$_slotsValue&";
    }

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Spell> spells = createSpellsList(response.body);
      setState(() {
        _spells = spells;
      });
    } else {
      _spells = [];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error fetching spells"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formId,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    /// Search bar for name of spell
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              label: Text("Spell name"),
                              hintText: 'Search for ${widget.name}',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              _spellName = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    // Dropdown for spell FP cost and num of slots
                    Row(
                      children: [
                        /// Dropdown for FP cost
                        Row(
                          children: [
                            Text("FP cost:"),
                            DropdownButton<int?>(
                              value: _fpValue,
                              items: [
                                DropdownMenuItem(value: null, child: Text('')),
                                ...List.generate(
                                  65,
                                  (index) => DropdownMenuItem(
                                    value: index + 1,
                                    child: Text((index + 1).toString()),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _fpValue = value;
                                });
                              },
                            ),
                          ],
                        ),

                        /// Radio button for slots
                        Row(
                          children: [
                            Text("Slots:"),
                            Radio<int?>(
                              value: null,
                              groupValue: _slotsValue,
                              onChanged: (value) {
                                _slotsValue = value;
                                setState(() {});
                              },
                            ),
                            Text('Any'),
                            Radio<int>(
                              value: 1,
                              groupValue: _slotsValue,
                              onChanged: (value) {
                                _slotsValue = value;
                                setState(() {});
                              },
                            ),
                            Text('1'),
                            Radio<int>(
                              value: 2,
                              groupValue: _slotsValue,
                              onChanged: (value) {
                                _slotsValue = value;
                                setState(() {});
                              },
                            ),
                            Text('2'),
                            Radio<int>(
                              value: 3,
                              groupValue: _slotsValue,
                              onChanged: (value) {
                                _slotsValue = value;
                                setState(() {});
                              },
                            ),
                            Text('3'),
                          ],
                        ),
                      ],
                    ),

                    // Button controls
                    Row(
                      children: [
                        /// Reset Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _formId.currentState?.reset();
                                _slotsValue = null;
                                _fpValue = null;
                                _spellName = "";
                                _spells = [];
                              });
                            },
                            child: Text("Reset"),
                          ),
                        ),

                        /// Search Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              setState(() {
                                fetchSpells();
                              });
                            },
                            child: Text("Search"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Divider(thickness: 2, color: Colors.black),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _spells.length,
              itemBuilder: (context, index) {
                final spell = _spells[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(spell.name!),
                    subtitle: Text("FP: ${spell.fp}, Slots: ${spell.slot}"),
                    leading:
                        spell.image != null
                            ? Image.network(
                              spell.image!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                            : Icon(Icons.image_not_supported),
                    onTap: () {
                      // Handle tap on spell item
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
