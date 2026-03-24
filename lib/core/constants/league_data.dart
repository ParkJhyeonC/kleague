import '../models/league.dart';
import '../models/match_info.dart';
import '../models/team.dart';

class LeagueData {
  static const List<Team> teams = [
    Team(id: 'ulsan', name: '울산 HD', character: '호랑이', league: League.kLeague1),
    Team(id: 'seoul', name: 'FC 서울', character: '황소', league: League.kLeague1),
    Team(id: 'jeonbuk', name: '전북 현대', character: '녹색전사', league: League.kLeague1),
    Team(id: 'suwon_bluewings', name: '수원 삼성', character: '날개사자', league: League.kLeague2),
    Team(id: 'busan', name: '부산 아이파크', character: '갈매기', league: League.kLeague2),
    Team(id: 'gimpo', name: '김포 FC', character: '검독수리', league: League.kLeague2),
  ];

  static final List<MatchInfo> sampleMatches = [
    MatchInfo(
      id: 'm1',
      date: DateTime(2026, 3, 29),
      home: '울산 HD',
      away: 'FC 서울',
      homeScore: 2,
      awayScore: 1,
      review: '후반 막판 역전으로 홈 팬들이 열광한 경기',
    ),
    MatchInfo(
      id: 'm2',
      date: DateTime(2026, 4, 2),
      home: '전북 현대',
      away: '울산 HD',
      homeScore: 0,
      awayScore: 0,
      review: '치열한 중원 싸움 끝에 승점 1점씩 획득',
    ),
    MatchInfo(
      id: 'm3',
      date: DateTime(2026, 4, 6),
      home: 'FC 서울',
      away: '전북 현대',
      homeScore: 3,
      awayScore: 2,
      review: '난타전 끝에 서울이 홈에서 신승',
    ),
  ];

  static List<Team> teamsByLeague(League league) {
    return teams.where((team) => team.league == league).toList();
  }
}
