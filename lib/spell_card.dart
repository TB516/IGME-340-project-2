import 'package:flutter/material.dart';
import 'package:igme_project_2/data/spell.dart';

class SpellCard extends StatefulWidget {
  final Spell spell;
  final Function(bool, Spell) onFavoriteToggle;
  bool favorited;

  SpellCard({
    super.key,
    required this.spell,
    required this.favorited,
    required this.onFavoriteToggle,
  });

  @override
  _SpellCardState createState() => _SpellCardState();
}

class _SpellCardState extends State<SpellCard> {
  @override
  Widget build(BuildContext context) {
    /// Card widget to display spell information
    /// The card contains a title, subtitle, and an icon button to toggle favorite status
    return Card(
      color: const Color.fromARGB(255, 58, 58, 58),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(widget.spell.name!),
        subtitle: Text("FP: ${widget.spell.fp}, Slots: ${widget.spell.slot}"),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              widget.favorited = !widget.favorited;
              widget.onFavoriteToggle(widget.favorited, widget.spell);
            });
          },
          icon: Icon(
            widget.favorited ? Icons.star : Icons.star_border,
            color: widget.favorited ? Colors.yellow : Colors.grey,
          ),
        ),
        leading:
            widget.spell.image != null
                ? Image.network(
                  widget.spell.image!,
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
                    widget.spell.image != null
                        ? Image.network(widget.spell.image!, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    SizedBox(height: 16),
                    Text(
                      widget.spell.name!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.spell.description!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Location: ${widget.spell.location!}",
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
