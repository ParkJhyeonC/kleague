class MatchModel {
  const MatchModel({
    required this.matchId,
    required this.league,
    required this.round,
    required this.kickoffAt,
    required this.homeTeamId,
    required this.awayTeamId,
    this.homeScore,
    this.awayScore,
    required this.status,
  });

  final String matchId;
  final String league;
  final String round;
  final DateTime kickoffAt;
  final String homeTeamId;
  final String awayTeamId;
  final int? homeScore;
  final int? awayScore;
  final MatchStatus status;

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchId: json['matchId'] as String,
      league: json['league'] as String,
      round: json['round'] as String,
      kickoffAt: DateTime.parse(json['kickoffAt'] as String),
      homeTeamId: json['homeTeamId'] as String,
      awayTeamId: json['awayTeamId'] as String,
      homeScore: json['homeScore'] as int?,
      awayScore: json['awayScore'] as int?,
      status: MatchStatusX.fromWireValue(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'league': league,
      'round': round,
      'kickoffAt': kickoffAt.toIso8601String(),
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'homeScore': homeScore,
      'awayScore': awayScore,
      'status': status.wireValue,
    };
  }
}

enum MatchStatus {
  scheduled,
  live,
  finished,
  postponed,
  canceled,
}

extension MatchStatusX on MatchStatus {
  String get wireValue {
    switch (this) {
      case MatchStatus.scheduled:
        return 'SCHEDULED';
      case MatchStatus.live:
        return 'LIVE';
      case MatchStatus.finished:
        return 'FINISHED';
      case MatchStatus.postponed:
        return 'POSTPONED';
      case MatchStatus.canceled:
        return 'CANCELED';
    }
  }

  static MatchStatus fromWireValue(String value) {
    switch (value.toUpperCase()) {
      case 'SCHEDULED':
        return MatchStatus.scheduled;
      case 'LIVE':
        return MatchStatus.live;
      case 'FINISHED':
        return MatchStatus.finished;
      case 'POSTPONED':
        return MatchStatus.postponed;
      case 'CANCELED':
        return MatchStatus.canceled;
      default:
        throw FormatException('Unknown match status: $value');
    }
  }
}
