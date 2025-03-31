import 'dart:core';

class Spell {
  String? id;
  String? name;
  String? image;
  String? description;
  String? effect;
  String? fp;
  int? slot;
  int? intelligence;
  int? faith;
  int? arc;
  String? bonus;
  String? location;
  int? stamina;

  Spell({required Map json}) {
    id = json["m_id"];
    name = json["m_name"];
    image = json["m_image"];
    description = json["m_description"];
    effect = json["m_effect"];
    fp = json["m_fp"];
    slot = json["m_slot"];
    intelligence = json["m_int"];
    faith = json["m_faith"];
    arc = json["m_arc"];
    bonus = json["m_bonus"];
    location = json["m_location"];
    stamina = json["m_stamina"];
  }
}
