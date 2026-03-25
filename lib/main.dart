import 'package:flutter/material.dart';

void main() {
  runApp(const KleagueApp());
}

class KleagueApp extends StatelessWidget {
  const KleagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K리그 캐릭터 일정',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ScheduleHomePage(),
    );
  }
}

enum League { k1, k2 }

enum MatchStatus { scheduled, finished }

class TeamCharacter {
  const TeamCharacter({
    required this.id,
    required this.league,
    required this.name,
    required this.character,
    required this.mascot,
  });

  final String id;
  final League league;
  final String name;
  final String character;
  final String mascot;
}

class MatchResult {
  const MatchResult({
    required this.id,
    required this.league,
    required this.round,
    required this.kickoff,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.homeScore,
    required this.awayScore,
    required this.status,
  });

  final String id;
  final League league;
  final int round;
  final DateTime kickoff;
  final String homeTeamId;
  final String awayTeamId;
  final int? homeScore;
  final int? awayScore;
  final MatchStatus status;
}

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  League selectedLeague = League.k1;
  TeamCharacter? selectedTeam;

  late final List<TeamCharacter> teams = _buildTeams();
  late final Future<List<MatchResult>> matchResultsFuture = _fetchResults();

  @override
  void initState() {
    super.initState();
    selectedTeam = teams.where((team) => team.league == selectedLeague).first;
  }

  @override
  Widget build(BuildContext context) {
    final leagueTeams = teams.where((team) => team.league == selectedLeague).toList();

    selectedTeam ??= leagueTeams.first;

    return Scaffold(
      appBar: AppBar(title: const Text('K리그 캐릭터 일정/결과')),
      body: FutureBuilder<List<MatchResult>>(
        future: matchResultsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('결과를 불러오지 못했습니다.'));
          }

          final matches = snapshot.data!
              .where((match) => match.league == selectedLeague)
              .toList()
            ..sort((a, b) => a.kickoff.compareTo(b.kickoff));

          final myMatches = matches
              .where(
                (match) =>
                    match.homeTeamId == selectedTeam!.id ||
                    match.awayTeamId == selectedTeam!.id,
              )
              .toList();

          final otherResults = matches
              .where(
                (match) =>
                    match.status == MatchStatus.finished &&
                    match.homeTeamId != selectedTeam!.id &&
                    match.awayTeamId != selectedTeam!.id,
              )
              .toList();

          final MatchResult? highlightedMatch = myMatches.isEmpty
              ? null
              : myMatches.firstWhere(
                  (match) => match.status == MatchStatus.finished,
                  orElse: () => myMatches.first,
                );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSelectorCard(leagueTeams),
              const SizedBox(height: 16),
              if (highlightedMatch != null)
                _MascotHighlightCard(
                  selectedTeam: selectedTeam!,
                  focusMatch: highlightedMatch,
                  myMatches: myMatches,
                  teams: teams,
                ),
              if (myMatches.isNotEmpty) const SizedBox(height: 16),
              _SectionTitle(title: '내 팀 일정 (${selectedTeam!.character})'),
              if (myMatches.isEmpty)
                const Card(child: ListTile(title: Text('등록된 일정이 없습니다.')))
              else
                ...myMatches.map((match) => _MatchTile(match: match, teams: teams)),
              const SizedBox(height: 16),
              const _SectionTitle(title: '다른 팀 경기 결과'),
              if (otherResults.isEmpty)
                const Card(child: ListTile(title: Text('확인 가능한 다른 팀 결과가 없습니다.')))
              else
                ...otherResults.map((match) => _MatchTile(match: match, teams: teams)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSelectorCard(List<TeamCharacter> leagueTeams) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1) 리그 선택'),
            DropdownButton<League>(
              value: selectedLeague,
              isExpanded: true,
              onChanged: (league) {
                if (league == null) return;
                setState(() {
                  selectedLeague = league;
                  selectedTeam = teams.firstWhere((team) => team.league == league);
                });
              },
              items: const [
                DropdownMenuItem(value: League.k1, child: Text('K리그1')),
                DropdownMenuItem(value: League.k2, child: Text('K리그2')),
              ],
            ),
            const SizedBox(height: 12),
            const Text('2) 내 팀(캐릭터) 선택'),
            DropdownButton<TeamCharacter>(
              value: selectedTeam,
              isExpanded: true,
              onChanged: (team) {
                if (team == null) return;
                setState(() {
                  selectedTeam = team;
                });
              },
              items: leagueTeams
                  .map(
                    (team) => DropdownMenuItem(
                      value: team,
                      child: Text('${team.mascot} ${team.name} (${team.character})'),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  static List<TeamCharacter> _buildTeams() {
    return const [
      // K리그1 (12팀)
      TeamCharacter(id: 'anyang', league: League.k1, name: 'FC안양', character: '보라사자', mascot: '🦁'),
      TeamCharacter(id: 'bucheon', league: League.k1, name: '부천FC1995', character: '붉은여우', mascot: '🦊'),
      TeamCharacter(id: 'daejeon', league: League.k1, name: '대전하나시티즌', character: '보라독수리', mascot: '🦅'),
      TeamCharacter(id: 'gangwon', league: League.k1, name: '강원FC', character: '곰돌이', mascot: '🐻'),
      TeamCharacter(id: 'gimcheon', league: League.k1, name: '김천상무', character: '불사조', mascot: '🔥'),
      TeamCharacter(id: 'gwangju', league: League.k1, name: '광주FC', character: '빛고을호랑이', mascot: '🐯'),
      TeamCharacter(id: 'incheon', league: League.k1, name: '인천유나이티드', character: '갈매기', mascot: '🐦'),
      TeamCharacter(id: 'jeju', league: League.k1, name: '제주SK', character: '흑돼지전사', mascot: '🐗'),
      TeamCharacter(id: 'jeonbuk', league: League.k1, name: '전북현대', character: '초록전사', mascot: '🟢'),
      TeamCharacter(id: 'pohang', league: League.k1, name: '포항스틸러스', character: '강철전사', mascot: '🛡️'),
      TeamCharacter(id: 'seoul', league: League.k1, name: 'FC서울', character: '수호신', mascot: '🦅'),
      TeamCharacter(id: 'ulsan', league: League.k1, name: '울산HD', character: '호랑이', mascot: '🐯'),

      // K리그2 (17팀)
      TeamCharacter(id: 'ansan', league: League.k2, name: '안산그리너스', character: '초록늑대', mascot: '🐺'),
      TeamCharacter(id: 'busan', league: League.k2, name: '부산아이파크', character: '바다전사', mascot: '🌊'),
      TeamCharacter(id: 'cheonan', league: League.k2, name: '천안시티FC', character: '유니콘', mascot: '🦄'),
      TeamCharacter(id: 'chungbuk', league: League.k2, name: '충북청주FC', character: '청주표범', mascot: '🐆'),
      TeamCharacter(id: 'chungnam', league: League.k2, name: '충남아산FC', character: '용맹이', mascot: '🐉'),
      TeamCharacter(id: 'daegu', league: League.k2, name: '대구FC', character: '푸른독수리', mascot: '🦅'),
      TeamCharacter(id: 'gimpo', league: League.k2, name: '김포FC', character: '바다매', mascot: '🐦'),
      TeamCharacter(id: 'gimhae', league: League.k2, name: '김해FC2008', character: '가야전사', mascot: '⚔️'),
      TeamCharacter(id: 'gyeongnam', league: League.k2, name: '경남FC', character: '붉은독수리', mascot: '🦅'),
      TeamCharacter(id: 'hwaseong', league: League.k2, name: '화성FC', character: '우주전사', mascot: '🚀'),
      TeamCharacter(id: 'jeonnam', league: League.k2, name: '전남드래곤즈', character: '황금용', mascot: '🐲'),
      TeamCharacter(id: 'paju', league: League.k2, name: '파주프런티어', character: '수리매', mascot: '🦅'),
      TeamCharacter(id: 'seongnam', league: League.k2, name: '성남FC', character: '까치', mascot: '🐦'),
      TeamCharacter(id: 'seouleland', league: League.k2, name: '서울이랜드', character: '표범', mascot: '🐆'),
      TeamCharacter(id: 'suwonsamsung', league: League.k2, name: '수원삼성블루윙즈', character: '푸른날개', mascot: '💙'),
      TeamCharacter(id: 'suwonfc', league: League.k2, name: '수원FC', character: '날개사자', mascot: '🦁'),
      TeamCharacter(id: 'yongin', league: League.k2, name: '용인FC', character: '백호', mascot: '🐯'),
    ];
  }

  static Future<List<MatchResult>> _fetchResults() async {
    // NOTE:
    // K리그 공식 공개 API가 없는 환경을 가정한 샘플입니다.
    // 실제 서비스에서는 앱이 직접 외부 사이트를 파싱하지 말고,
    // 중간 백엔드(BFF)의 /matches API를 호출하도록 교체하세요.
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return [
      MatchResult(
        id: 'k1-r1-1',
        league: League.k1,
        round: 1,
        kickoff: DateTime(2026, 3, 1, 14, 0),
        homeTeamId: 'ulsan',
        awayTeamId: 'seoul',
        homeScore: 2,
        awayScore: 1,
        status: MatchStatus.finished,
      ),
      MatchResult(
        id: 'k1-r2-1',
        league: League.k1,
        round: 2,
        kickoff: DateTime(2026, 3, 8, 16, 30),
        homeTeamId: 'jeonbuk',
        awayTeamId: 'incheon',
        homeScore: 0,
        awayScore: 0,
        status: MatchStatus.finished,
      ),
      MatchResult(
        id: 'k1-r3-1',
        league: League.k1,
        round: 3,
        kickoff: DateTime(2026, 3, 29, 15, 0),
        homeTeamId: 'ulsan',
        awayTeamId: 'jeonbuk',
        homeScore: null,
        awayScore: null,
        status: MatchStatus.scheduled,
      ),
      MatchResult(
        id: 'k2-r1-1',
        league: League.k2,
        round: 1,
        kickoff: DateTime(2026, 3, 2, 14, 0),
        homeTeamId: 'busan',
        awayTeamId: 'anyang',
        homeScore: 1,
        awayScore: 3,
        status: MatchStatus.finished,
      ),
      MatchResult(
        id: 'k2-r2-1',
        league: League.k2,
        round: 2,
        kickoff: DateTime(2026, 3, 10, 19, 0),
        homeTeamId: 'seongnam',
        awayTeamId: 'suwonfc',
        homeScore: 2,
        awayScore: 2,
        status: MatchStatus.finished,
      ),
      MatchResult(
        id: 'k2-r3-1',
        league: League.k2,
        round: 3,
        kickoff: DateTime(2026, 3, 30, 13, 30),
        homeTeamId: 'suwonfc',
        awayTeamId: 'anyang',
        homeScore: null,
        awayScore: null,
        status: MatchStatus.scheduled,
      ),
    ];
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _MascotHighlightCard extends StatelessWidget {
  const _MascotHighlightCard({
    required this.selectedTeam,
    required this.focusMatch,
    required this.myMatches,
    required this.teams,
  });

  final TeamCharacter selectedTeam;
  final MatchResult focusMatch;
  final List<MatchResult> myMatches;
  final List<TeamCharacter> teams;

  @override
  Widget build(BuildContext context) {
    final homeTeam = teams.firstWhere((team) => team.id == focusMatch.homeTeamId);
    final awayTeam = teams.firstWhere((team) => team.id == focusMatch.awayTeamId);
    final startDate = focusMatch.kickoff.subtract(Duration(days: focusMatch.kickoff.weekday % 7));
    final weekDates = List<DateTime>.generate(7, (index) => startDate.add(Duration(days: index)));

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 760;

            final left = _MascotWeekCalendar(
              focusMatch: focusMatch,
              weekDates: weekDates,
              myMatches: myMatches,
              selectedTeam: selectedTeam,
            );

            final right = _VersusPanel(
              focusMatch: focusMatch,
              homeTeam: homeTeam,
              awayTeam: awayTeam,
              selectedTeam: selectedTeam,
            );

            if (compact) {
              return Column(
                children: [
                  left,
                  const Divider(height: 32),
                  right,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const VerticalDivider(width: 24),
                Expanded(child: right),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MascotWeekCalendar extends StatelessWidget {
  const _MascotWeekCalendar({
    required this.focusMatch,
    required this.weekDates,
    required this.myMatches,
    required this.selectedTeam,
  });

  final MatchResult focusMatch;
  final List<DateTime> weekDates;
  final List<MatchResult> myMatches;
  final TeamCharacter selectedTeam;

  static const List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${focusMatch.kickoff.year}년 ${focusMatch.kickoff.month}월',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            weekDates.length,
            (index) => Expanded(
              child: Text(
                weekdays[index],
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: weekDates
              .map(
                (date) => Expanded(
                  child: _CalendarDateCell(
                    date: date,
                    isFocused: _isSameDay(date, focusMatch.kickoff),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          children: weekDates
              .map(
                (date) => Expanded(
                  child: _CalendarMascotCell(
                    mascot: _mascotForDate(date),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  String _mascotForDate(DateTime date) {
    for (final match in myMatches) {
      if (_isSameDay(match.kickoff, date)) {
        return selectedTeam.mascot;
      }
    }
    return '';
  }
}

class _CalendarDateCell extends StatelessWidget {
  const _CalendarDateCell({required this.date, required this.isFocused});

  final DateTime date;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isFocused ? const Color(0xFFF05D5E) : const Color(0xFFF5F5F5),
        ),
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: isFocused ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CalendarMascotCell extends StatelessWidget {
  const _CalendarMascotCell({required this.mascot});

  final String mascot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Center(
        child: Text(
          mascot,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class _VersusPanel extends StatelessWidget {
  const _VersusPanel({
    required this.focusMatch,
    required this.homeTeam,
    required this.awayTeam,
    required this.selectedTeam,
  });

  final MatchResult focusMatch;
  final TeamCharacter homeTeam;
  final TeamCharacter awayTeam;
  final TeamCharacter selectedTeam;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TeamFace(team: homeTeam),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            _TeamFace(team: awayTeam),
          ],
        ),
        const SizedBox(height: 10),
        if (focusMatch.status == MatchStatus.finished)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDDF4E8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _resultLabel(),
              style: const TextStyle(
                color: Color(0xFF319D72),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        else
          const Text('경기 예정', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Text(
          focusMatch.status == MatchStatus.finished
              ? '${focusMatch.homeScore} : ${focusMatch.awayScore}'
              : '- : -',
          style: const TextStyle(fontSize: 46, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  String _resultLabel() {
    if (focusMatch.homeScore == focusMatch.awayScore) return '무승부';
    final selectedIsHome = focusMatch.homeTeamId == selectedTeam.id;
    final won = selectedIsHome
        ? focusMatch.homeScore! > focusMatch.awayScore!
        : focusMatch.awayScore! > focusMatch.homeScore!;
    return won ? '승리' : '패배';
  }
}

class _TeamFace extends StatelessWidget {
  const _TeamFace({required this.team});

  final TeamCharacter team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFF1F1F1),
          child: Text(team.mascot, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 8),
        Text(team.name, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

class _MatchTile extends StatelessWidget {
  const _MatchTile({required this.match, required this.teams});

  final MatchResult match;
  final List<TeamCharacter> teams;

  @override
  Widget build(BuildContext context) {
    final home = teams.firstWhere((team) => team.id == match.homeTeamId);
    final away = teams.firstWhere((team) => team.id == match.awayTeamId);

    final dateText =
        '${match.kickoff.year}.${match.kickoff.month.toString().padLeft(2, '0')}.${match.kickoff.day.toString().padLeft(2, '0')} '
        '${match.kickoff.hour.toString().padLeft(2, '0')}:${match.kickoff.minute.toString().padLeft(2, '0')}';

    final scoreText = match.status == MatchStatus.finished
        ? '${match.homeScore} : ${match.awayScore}'
        : '경기 예정';

    return Card(
      child: ListTile(
        title: Text('${home.mascot} ${home.name} vs ${away.mascot} ${away.name}'),
        subtitle: Text('R${match.round} · $dateText'),
        trailing: Text(scoreText),
      ),
    );
  }
}
