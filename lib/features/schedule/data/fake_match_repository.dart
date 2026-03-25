import '../../../core/models/match.dart';
import 'match_repository.dart';

class FakeMatchRepository implements MatchRepository {
  FakeMatchRepository({List<MatchModel>? seedData})
      : _seedData = seedData ?? _defaultSeedData;

  final List<MatchModel> _seedData;

  static final List<MatchModel> _defaultSeedData = [
    MatchModel(
      matchId: 'match-1001',
      league: 'K League 1',
      round: '1',
      kickoffAt: DateTime(2026, 3, 1, 5),
      homeTeamId: 'ulsan',
      awayTeamId: 'seoul',
      homeScore: 2,
      awayScore: 1,
      status: MatchStatus.finished,
    ),
    MatchModel(
      matchId: 'match-1002',
      league: 'K League 1',
      round: '2',
      kickoffAt: DateTime(2026, 3, 8, 5),
      homeTeamId: 'seoul',
      awayTeamId: 'daejeon',
      homeScore: null,
      awayScore: null,
      status: MatchStatus.scheduled,
    ),
  ];

  @override
  Future<List<MatchModel>> fetchTeamSchedule({
    required String teamId,
    required DateTime month,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    return _seedData.where((match) {
      final isTargetTeam =
          match.homeTeamId == teamId || match.awayTeamId == teamId;
      final isTargetMonth =
          match.kickoffAt.year == month.year && match.kickoffAt.month == month.month;
      return isTargetTeam && isTargetMonth;
    }).toList(growable: false);
  }

  @override
  Future<MatchModel> fetchMatchResult({required String matchId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _seedData.firstWhere(
      (match) => match.matchId == matchId,
      orElse: () => throw StateError('Match not found: $matchId'),
    );
  }
}
