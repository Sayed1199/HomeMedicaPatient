import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CardModel {
  String spciality;
  int cardBackground;
  var cardIcon;

  CardModel(this.spciality, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
new CardModel("Cardiologist", 0xFFec407a, CupertinoIcons.heart),
new CardModel("Dentist", 0xFF5c6bc0, FontAwesomeIcons.tooth),
new CardModel("Eye Special", 0xFFfbc02d, FontAwesomeIcons.eye),
new CardModel("Orthopaedic", 0xFF1565C0, Icons.wheelchair_pickup_sharp),
new CardModel("Paediatrician", 0xFF2E7D32, FontAwesomeIcons.baby),
];

// Cardiology, Dentistry, Pediatrics, ophthalmology, orthopaedics