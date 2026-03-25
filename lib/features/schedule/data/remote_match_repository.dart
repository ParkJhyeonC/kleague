import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/models/match.dart';
import 'match_repository.dart';

class RemoteMatchRepository implements MatchRepository {
  RemoteMatchRepository({
    required this.client,
    required this.baseUrl,
  });

  final http.Client client;
  final String baseUrl;

  @override
  Future<List<MatchModel>> fetchTeamSchedule({
    required String teamId,
    required DateTime month,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/teams/$teamId/schedule?month=${month.toIso8601String()}',
    );

    final response = await _safeGet(uri);
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final items = (decoded['matches'] as List<dynamic>? ?? const []);

    return items
        .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<MatchModel> fetchMatchResult({required String matchId}) async {
    final uri = Uri.parse('$baseUrl/matches/$matchId/result');

    final response = await _safeGet(uri);
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    return MatchModel.fromJson(decoded);
  }

  Future<http.Response> _safeGet(Uri uri) async {
    http.Response response;

    try {
      response = await client.get(uri);
    } on http.ClientException catch (e) {
      throw NetworkException(message: e.message);
    } catch (e) {
      throw NetworkException(message: e.toString());
    }

    if (response.statusCode >= 500) {
      throw ServerException(statusCode: response.statusCode);
    }

    if (response.statusCode >= 400) {
      throw ApiException(statusCode: response.statusCode, body: response.body);
    }

    return response;
  }
}

class ApiException implements Exception {
  ApiException({required this.statusCode, required this.body});

  final int statusCode;
  final String body;
}

class ServerException implements Exception {
  ServerException({required this.statusCode});

  final int statusCode;
}

class NetworkException implements Exception {
  NetworkException({required this.message});

  final String message;
}
