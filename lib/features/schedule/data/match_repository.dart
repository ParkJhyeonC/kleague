import '../../../core/models/match.dart';

abstract interface class MatchRepository {
  Future<List<MatchModel>> fetchTeamSchedule({
    required String teamId,
    required DateTime month,
  });

  Future<MatchModel> fetchMatchResult({required String matchId});
}
