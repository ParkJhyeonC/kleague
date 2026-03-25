import 'package:flutter/foundation.dart';

import '../../../core/models/match.dart';
import '../data/match_repository.dart';

enum ScheduleStatus {
  loading,
  error,
  empty,
  loaded,
}

class ScheduleViewModel extends ChangeNotifier {
  ScheduleViewModel(this._repository);

  final MatchRepository _repository;

  ScheduleStatus _status = ScheduleStatus.empty;
  List<MatchModel> _matches = const [];
  MatchModel? _selectedMatch;
  String? _errorMessage;

  ScheduleStatus get status => _status;
  List<MatchModel> get matches => _matches;
  MatchModel? get selectedMatch => _selectedMatch;
  String? get errorMessage => _errorMessage;

  Future<void> loadTeamSchedule({
    required String teamId,
    required DateTime month,
  }) async {
    _setLoading();

    try {
      final response = await _repository.fetchTeamSchedule(
        teamId: teamId,
        month: month,
      );

      if (response.isEmpty) {
        _matches = const [];
        _selectedMatch = null;
        _status = ScheduleStatus.empty;
      } else {
        _matches = response;
        _status = ScheduleStatus.loaded;
      }
      _errorMessage = null;
    } catch (e) {
      _status = ScheduleStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> loadMatchResult({required String matchId}) async {
    _setLoading();

    try {
      _selectedMatch = await _repository.fetchMatchResult(matchId: matchId);
      _status = ScheduleStatus.loaded;
      _errorMessage = null;
    } catch (e) {
      _status = ScheduleStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void _setLoading() {
    _status = ScheduleStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }
}
