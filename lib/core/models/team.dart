import 'league.dart';

class Team {
  const Team({
    required this.id,
    required this.name,
    required this.character,
    required this.league,
  });

  final String id;
  final String name;
  final String character;
  final League league;
}
