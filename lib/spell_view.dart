import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:igme_project_2/data/spell.dart';
import 'package:http/http.dart' as http;
import 'package:igme_project_2/spell_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpellView extends StatefulWidget {
  final String url;
  final String name;

  const SpellView({super.key, required this.url, required this.name});

  @override
  _SpellViewState createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {
  final TextEditingController _searchController = TextEditingController();
  int? _slotsValue;
  int? _fpValue;
  String _spellName = "";
  List<Spell> _spells = [];

  late SharedPreferences prefs;

  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    String? lastSearchTerm = prefs.getString('lastSearchTerm${widget.name}');
    if (lastSearchTerm != null) {
      setState(() {
        _spellName = lastSearchTerm;
        _searchController.value = TextEditingValue(text: lastSearchTerm);
      });
    }
  }

  /// Creates a list of spells from the JSON response
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
      url += "slot=$_slotsValue&";
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
            /// App form controls
            Form(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    /// Search bar for name of spell
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              label: Text("Spell name"),
                              hintText: 'Search for ${widget.name}',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
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
                                _searchController.clear();
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

                              await prefs.setString(
                                'lastSearchTerm${widget.name}',
                                _spellName,
                              );
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

            Divider(thickness: 4, color: const Color.fromARGB(255, 58, 58, 58)),

            /// Visual representation of spells
            Column(
              children: [
                /// Provide indication that no spells are loaded currently
                _spells.isEmpty
                    ? Text("No ${widget.name} Found!")
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _spells.length,
                      itemBuilder: (context, index) {
                        final spell = _spells[index];
                        return SpellCard(spell: spell, favorited: false);
                      },
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
