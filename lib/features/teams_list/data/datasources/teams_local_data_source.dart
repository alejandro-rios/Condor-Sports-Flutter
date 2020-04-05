import 'dart:convert';

import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/features/teams_list/data/models/team_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TeamsLocalDataSource {
  /// Gets the cached [TeamModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<TeamModel> getTeamById(String teamId);

  Future<void> saveTeams(TeamModel teams);
}

const CACHED_TEAMS = 'CACHED_TEAMS';

class TeamsLocalDataSourceImpl implements TeamsLocalDataSource {
  final SharedPreferences sharedPreferences;

  TeamsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<TeamModel> getTeamById(String teamId) {
    final jsonString = sharedPreferences.getString(CACHED_TEAMS);

    if (jsonString != null) {
      return Future.value(TeamModel.fromJson(json.decode(jsonString)));
    } else {
      throw NoLocalDataException();
    }
  }

  @override
  Future<void> saveTeams(TeamModel teams) {
    return sharedPreferences.setString(
      CACHED_TEAMS,
      json.encode(teams.toJson()),
    );
  }
}
