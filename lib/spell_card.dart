import 'package:flutter/material.dart';
import 'package:igme_project_2/data/spell.dart';

class SpellCard extends StatelessWidget {
  final Spell spell;
  bool favorited;

  SpellCard({super.key, required this.spell, required this.favorited});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 58, 58, 58),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(spell.name!),
        subtitle: Text("FP: ${spell.fp}, Slots: ${spell.slot}"),
        trailing: IconButton(
          onPressed: () {
            favorited = !favorited;
          },
          icon: Icon(favorited ? Icons.star : Icons.star_border),
        ),
        leading:
            spell.image != null
                ? Image.network(
                  spell.image!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                : Icon(Icons.image_not_supported),

        /// Popup dialog with more details
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  children: [
                    spell.image != null
                        ? Image.network(spell.image!, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    SizedBox(height: 16),
                    Text(
                      spell.name!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      spell.description ?? "No description available.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Location: ${spell.location ?? "Unknown"}",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
