import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:dartz/dartz.dart';

abstract class TeamsRepository {
  Future<Either<Failure, List<APITeam>>> getTeamsByLeague(String leagueId);

  Future<Either<Failure, List<APITeamEvents>>> getTeamEvents(String teamId);
}
