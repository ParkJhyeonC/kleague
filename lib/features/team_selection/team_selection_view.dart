import 'package:flutter/material.dart';

import '../../core/data/team_catalog.dart';
import '../../core/models/league.dart';
import '../../core/models/team.dart';
import 'widgets/team_selection_card.dart';

/// Team selection UI that exposes cards (character + name) instead of plain text.
///
/// Returns stable [Team.id] in [onTeamSelected] for API consumption.
class TeamSelectionView extends StatefulWidget {
  const TeamSelectionView({
    super.key,
    required this.league,
    this.initialTeamId,
    required this.onTeamSelected,
  });

  final LeagueType league;
  final String? initialTeamId;
  final ValueChanged<String> onTeamSelected;

  @override
  State<TeamSelectionView> createState() => _TeamSelectionViewState();
}

class _TeamSelectionViewState extends State<TeamSelectionView> {
  late String? _selectedTeamId = widget.initialTeamId;

  @override
  Widget build(BuildContext context) {
    final teams = TeamCatalog.teamsFor(widget.league);

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final team = teams[index];
        return TeamSelectionCard(
          team: team,
          isSelected: team.id == _selectedTeamId,
          onTap: () => _onTeamTap(team),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: teams.length,
    );
  }

  void _onTeamTap(Team team) {
    setState(() {
      _selectedTeamId = team.id;
    });
    widget.onTeamSelected(team.id);
  }
}
