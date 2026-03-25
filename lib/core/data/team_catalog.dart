import 'package:flutter/material.dart';

import '../models/league.dart';
import '../models/team.dart';

/// Static team catalog grouped by league.
///
/// Team [id] values are immutable internal identifiers used by API requests.
class TeamCatalog {
  const TeamCatalog._();

  static const Map<LeagueType, List<Team>> teamsByLeague = {
    LeagueType.kLeague1: kLeague1Teams,
    LeagueType.kLeague2: kLeague2Teams,
  };

  static const List<Team> kLeague1Teams = [
    Team(
      id: 'K1-ANY',
      league: LeagueType.kLeague1,
      name: 'FC 안양',
      characterAsset: 'assets/characters/kleague1/fc_anyang.png',
      primaryColor: Color(0xFF5E2B97),
    ),
    Team(
      id: 'K1-BCN',
      league: LeagueType.kLeague1,
      name: '부천 FC 1995',
      characterAsset: 'assets/characters/kleague1/bucheon_fc_1995.png',
      primaryColor: Color(0xFFB71C1C),
    ),
    Team(
      id: 'K1-DAE',
      league: LeagueType.kLeague1,
      name: '대전 하나 시티즌',
      characterAsset: 'assets/characters/kleague1/daejeon_hana_citizen.png',
      primaryColor: Color(0xFF7A4B2A),
    ),
    Team(
      id: 'K1-GAN',
      league: LeagueType.kLeague1,
      name: '강원 FC',
      characterAsset: 'assets/characters/kleague1/gangwon_fc.png',
      primaryColor: Color(0xFFFF6F00),
    ),
    Team(
      id: 'K1-GIM',
      league: LeagueType.kLeague1,
      name: '김천 상무',
      characterAsset: 'assets/characters/kleague1/gimcheon_sangmu.png',
      primaryColor: Color(0xFFB71C1C),
    ),
    Team(
      id: 'K1-GWJ',
      league: LeagueType.kLeague1,
      name: '광주 FC',
      characterAsset: 'assets/characters/kleague1/gwangju_fc.png',
      primaryColor: Color(0xFFFFD54F),
    ),
    Team(
      id: 'K1-INC',
      league: LeagueType.kLeague1,
      name: '인천 유나이티드',
      characterAsset: 'assets/characters/kleague1/incheon_united.png',
      primaryColor: Color(0xFF1E3A8A),
    ),
    Team(
      id: 'K1-JEJ',
      league: LeagueType.kLeague1,
      name: '제주 SK',
      characterAsset: 'assets/characters/kleague1/jeju_sk.png',
      primaryColor: Color(0xFFFF8F00),
    ),
    Team(
      id: 'K1-JBK',
      league: LeagueType.kLeague1,
      name: '전북 현대 모터스',
      characterAsset: 'assets/characters/kleague1/jeonbuk_hyundai_motors.png',
      primaryColor: Color(0xFF2E7D32),
    ),
    Team(
      id: 'K1-POH',
      league: LeagueType.kLeague1,
      name: '포항 스틸러스',
      characterAsset: 'assets/characters/kleague1/pohang_steelers.png',
      primaryColor: Color(0xFFC62828),
    ),
    Team(
      id: 'K1-SEO',
      league: LeagueType.kLeague1,
      name: 'FC 서울',
      characterAsset: 'assets/characters/kleague1/fc_seoul.png',
      primaryColor: Color(0xFF212121),
    ),
    Team(
      id: 'K1-ULS',
      league: LeagueType.kLeague1,
      name: '울산 HD',
      characterAsset: 'assets/characters/kleague1/ulsan_hd.png',
      primaryColor: Color(0xFF003A70),
    ),
  ];

  static const List<Team> kLeague2Teams = [
    Team(
      id: 'K2-ASG',
      league: LeagueType.kLeague2,
      name: '안산 그리너스',
      characterAsset: 'assets/characters/kleague2/ansan_greeners.png',
      primaryColor: Color(0xFF2E7D32),
    ),
    Team(
      id: 'K2-BUS',
      league: LeagueType.kLeague2,
      name: '부산 아이파크',
      characterAsset: 'assets/characters/kleague2/busan_ipark.png',
      primaryColor: Color(0xFFD32F2F),
    ),
    Team(
      id: 'K2-CHE',
      league: LeagueType.kLeague2,
      name: '천안시티 FC',
      characterAsset: 'assets/characters/kleague2/cheonan_city.png',
      primaryColor: Color(0xFF1A237E),
    ),
    Team(
      id: 'K2-CBC',
      league: LeagueType.kLeague2,
      name: '충북청주 FC',
      characterAsset: 'assets/characters/kleague2/chungbuk_cheongju.png',
      primaryColor: Color(0xFF00ACC1),
    ),
    Team(
      id: 'K2-CNA',
      league: LeagueType.kLeague2,
      name: '충남아산 FC',
      characterAsset: 'assets/characters/kleague2/chungnam_asan.png',
      primaryColor: Color(0xFF1565C0),
    ),
    Team(
      id: 'K2-DGU',
      league: LeagueType.kLeague2,
      name: '대구 FC',
      characterAsset: 'assets/characters/kleague2/daegu_fc.png',
      primaryColor: Color(0xFF4FC3F7),
    ),
    Team(
      id: 'K2-GMH',
      league: LeagueType.kLeague2,
      name: '김해 FC 2008',
      characterAsset: 'assets/characters/kleague2/gimhae_fc_2008.png',
      primaryColor: Color(0xFF424242),
    ),
    Team(
      id: 'K2-GPO',
      league: LeagueType.kLeague2,
      name: '김포 FC',
      characterAsset: 'assets/characters/kleague2/gimpo_fc.png',
      primaryColor: Color(0xFFFFA000),
    ),
    Team(
      id: 'K2-GYE',
      league: LeagueType.kLeague2,
      name: '경남 FC',
      characterAsset: 'assets/characters/kleague2/gyeongnam_fc.png',
      primaryColor: Color(0xFFEC407A),
    ),
    Team(
      id: 'K2-HWA',
      league: LeagueType.kLeague2,
      name: '화성 FC',
      characterAsset: 'assets/characters/kleague2/hwaseong_fc.png',
      primaryColor: Color(0xFFFF7043),
    ),
    Team(
      id: 'K2-JND',
      league: LeagueType.kLeague2,
      name: '전남 드래곤즈',
      characterAsset: 'assets/characters/kleague2/jeonnam_dragons.png',
      primaryColor: Color(0xFFFFD600),
    ),
    Team(
      id: 'K2-PAJ',
      league: LeagueType.kLeague2,
      name: '파주 프론티어',
      characterAsset: 'assets/characters/kleague2/paju_frontier.png',
      primaryColor: Color(0xFF6D4C41),
    ),
    Team(
      id: 'K2-SNM',
      league: LeagueType.kLeague2,
      name: '성남 FC',
      characterAsset: 'assets/characters/kleague2/seongnam_fc.png',
      primaryColor: Color(0xFF111111),
    ),
    Team(
      id: 'K2-SEL',
      league: LeagueType.kLeague2,
      name: '서울 이랜드 FC',
      characterAsset: 'assets/characters/kleague2/seoul_eland_fc.png',
      primaryColor: Color(0xFF0D47A1),
    ),
    Team(
      id: 'K2-SFC',
      league: LeagueType.kLeague2,
      name: '수원 FC',
      characterAsset: 'assets/characters/kleague2/suwon_fc.png',
      primaryColor: Color(0xFF2E7D32),
    ),
    Team(
      id: 'K2-SSB',
      league: LeagueType.kLeague2,
      name: '수원 삼성 블루윙즈',
      characterAsset: 'assets/characters/kleague2/suwon_samsung_bluewings.png',
      primaryColor: Color(0xFF0D47A1),
    ),
    Team(
      id: 'K2-YON',
      league: LeagueType.kLeague2,
      name: '용인 FC',
      characterAsset: 'assets/characters/kleague2/yongin_fc.png',
      primaryColor: Color(0xFF8E24AA),
    ),
  ];

  static List<Team> teamsFor(LeagueType league) =>
      teamsByLeague[league] ?? const [];

  static Team? findById(String id) {
    for (final teams in teamsByLeague.values) {
      for (final team in teams) {
        if (team.id == id) {
          return team;
        }
      }
    }
    return null;
  }
}
