import 'package:flutter/material.dart';

import 'league.dart';

/// Domain model for each selectable team.
///
/// [id] is a stable internal identifier used for API integration.
class Team {
  const Team({
    required this.id,
    required this.league,
    required this.name,
    required this.characterAsset,
    required this.primaryColor,
  });

  final String id;
  final LeagueType league;
  final String name;
  final String characterAsset;
  final Color primaryColor;
}
