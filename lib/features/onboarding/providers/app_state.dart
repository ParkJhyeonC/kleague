import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/league.dart';
import '../../../core/models/team.dart';

class AppState {
  const AppState({this.selectedLeague, this.selectedTeam});

  final League? selectedLeague;
  final Team? selectedTeam;

  AppState copyWith({League? selectedLeague, Team? selectedTeam, bool clearTeam = false}) {
    return AppState(
      selectedLeague: selectedLeague ?? this.selectedLeague,
      selectedTeam: clearTeam ? null : (selectedTeam ?? this.selectedTeam),
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void selectLeague(League league) {
    state = state.copyWith(selectedLeague: league, clearTeam: true);
  }

  void selectTeam(Team team) {
    state = state.copyWith(selectedTeam: team);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
