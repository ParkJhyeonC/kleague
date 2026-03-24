import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/league_data.dart';
import '../../../core/models/team.dart';
import '../../schedule/pages/schedule_page.dart';
import '../providers/app_state.dart';

class TeamSelectPage extends ConsumerWidget {
  const TeamSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final league = appState.selectedLeague;

    if (league == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('팀 선택')),
        body: const Center(child: Text('먼저 리그를 선택해주세요.')),
      );
    }

    final teams = LeagueData.teamsByLeague(league);

    return Scaffold(
      appBar: AppBar(title: Text('${league.label} 팀 선택')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: teams.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          final team = teams[index];
          return _TeamCard(
            team: team,
            onTap: () {
              ref.read(appStateProvider.notifier).selectTeam(team);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SchedulePage()),
              );
            },
          );
        },
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({required this.team, required this.onTap});

  final Team team;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(team.name),
        subtitle: Text('캐릭터: ${team.character}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
