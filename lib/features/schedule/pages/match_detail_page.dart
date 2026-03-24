import 'package:flutter/material.dart';

import '../../../core/models/match_info.dart';

class MatchDetailPage extends StatelessWidget {
  const MatchDetailPage({super.key, required this.match});

  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('경기 상세')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${match.home} ${match.homeScore} : ${match.awayScore} ${match.away}',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text('경기일: ${match.date.year}년 ${match.date.month}월 ${match.date.day}일'),
            const SizedBox(height: 20),
            const Text('한 줄평', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(match.review, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
