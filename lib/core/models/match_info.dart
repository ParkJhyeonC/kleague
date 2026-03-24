class MatchInfo {
  const MatchInfo({
    required this.id,
    required this.date,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    required this.review,
  });

  final String id;
  final DateTime date;
  final String home;
  final String away;
  final int homeScore;
  final int awayScore;
  final String review;
}
