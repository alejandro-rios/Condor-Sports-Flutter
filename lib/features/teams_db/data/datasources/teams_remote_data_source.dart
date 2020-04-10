import 'dart:convert';

import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class TeamsRemoteDataSource {
  /// Calls the https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=4328 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<APITeam>> getTeamsByLeague(String leagueId);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<APITeamEvents>> getTeamEvents(String teamId);
}

const TEAMS_BY_LEAGUE_URL =
    'https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=';

const EVENTS_BY_TEAM_URL =
    'https://www.thesportsdb.com/api/v1/json/1/eventsnext.php?id=';

class TeamsRemoteDataSourceImpl implements TeamsRemoteDataSource {
  final http.Client client;

  TeamsRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<APITeam>> getTeamsByLeague(String leagueId) async {
    final response =
        await client.get('$TEAMS_BY_LEAGUE_URL$leagueId', headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['teams'].cast<Map<String, dynamic>>();

      return parsed.map<APITeam>((json) => APITeam.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<APITeamEvents>> getTeamEvents(String teamId) async {
    final response = await client.get('$EVENTS_BY_TEAM_URL$teamId', headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['events'].cast<Map<String, dynamic>>();

      return parsed
          .map<APITeamEvents>((json) => APITeamEvents.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
