import 'package:flutter/material.dart';

class ValorantAgent {
  // Agent Properties
  final String name;
  final Image agentIcon;
  final Image ultimateIcon;
  final int ultimatePoints;
  final String ultimateName;

  // Ability 1 Properties
  final String abilityCName;
  final Image abilityCIcon;
  final int abilityCMaxCharges;
  int abilityCCurrentCharges;

  // Ability 2 Properties
  final String abilityQName;
  final Image abilityQIcon;
  final int abilityQMaxCharges;
  int abilityQCurrentCharges;

  // Ability 3 Properties
  final String abilityEName;
  final Image abilityEIcon;
  final int abilityEMaxCharges;
  int abilityECurrentCharges;

  // Constructor
  ValorantAgent({
    required this.name,
    required this.agentIcon,
    required this.ultimateIcon,
    required this.ultimatePoints,
    required this.ultimateName,
    required this.abilityCName,
    required this.abilityCIcon,
    required this.abilityCMaxCharges,
    required this.abilityQName,
    required this.abilityQIcon,
    required this.abilityQMaxCharges,
    required this.abilityEName,
    required this.abilityEIcon,
    required this.abilityEMaxCharges,
  })  : abilityCCurrentCharges = abilityCMaxCharges,
        abilityQCurrentCharges = abilityQMaxCharges,
        abilityECurrentCharges = abilityEMaxCharges;
}
