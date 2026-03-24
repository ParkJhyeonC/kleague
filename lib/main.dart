import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/onboarding/pages/league_select_page.dart';
import 'features/onboarding/pages/team_select_page.dart';
import 'features/onboarding/providers/app_state.dart';
import 'features/schedule/pages/schedule_page.dart';

void main() {
  runApp(const ProviderScope(child: KLeagueApp()));
}

class KLeagueApp extends ConsumerWidget {
  const KLeagueApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    return MaterialApp(
      title: 'K League Companion',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: switch ((appState.selectedLeague, appState.selectedTeam)) {
        (null, _) => const LeagueSelectPage(),
        (_, null) => const TeamSelectPage(),
        (_, _) => const SchedulePage(),
      },
    );
  }
}
