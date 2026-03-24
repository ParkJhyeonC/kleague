import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/league_data.dart';
import '../../../core/models/match_info.dart';
import '../../onboarding/providers/app_state.dart';
import 'match_detail_page.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final teamName = appState.selectedTeam?.name ?? '선호팀 없음';

    return Scaffold(
      appBar: AppBar(title: const Text('경기 일정')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('선택한 팀: $teamName', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _MiniCalendar(matches: LeagueData.sampleMatches),
            const SizedBox(height: 16),
            const Text('경기 목록', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: LeagueData.sampleMatches.length,
                itemBuilder: (_, index) {
                  final match = LeagueData.sampleMatches[index];
                  return Card(
                    child: ListTile(
                      title: Text('${match.home} vs ${match.away}'),
                      subtitle: Text('${match.date.year}.${match.date.month}.${match.date.day}'),
                      trailing: Text('${match.homeScore}:${match.awayScore}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MatchDetailPage(match: match)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniCalendar extends StatelessWidget {
  const _MiniCalendar({required this.matches});

  final List<MatchInfo> matches;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: matches
            .map(
              (match) => Chip(
                label: Text('${match.date.month}/${match.date.day} ${match.home}'),
              ),
            )
            .toList(),
      ),
    );
  }
}
