import 'dart:convert';

import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TeamsLocalDataSource {
  /// Gets the cached [TeamModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<List<APITeam>> getTeams();

  Future<void> saveTeams(List<APITeam> teams);
}

const CACHED_TEAMS = 'CACHED_TEAMS';

class TeamsLocalDataSourceImpl implements TeamsLocalDataSource {
  final SharedPreferences sharedPreferences;

  TeamsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<APITeam>> getTeams() {
    final jsonString = sharedPreferences.get(CACHED_TEAMS);

    if (jsonString != null) {
      return Future.value(json
          .decode(jsonString)
          .cast<Map<String, dynamic>>()
          .map<APITeam>((json) => APITeam.fromJson(json))
          .toList());
    } else {
      throw NoLocalDataException();
    }
  }

  @override
  Future<void> saveTeams(List<APITeam> teams) {
    return sharedPreferences.setString(
      CACHED_TEAMS,
      json.encode(teams),
    );
  }
}
