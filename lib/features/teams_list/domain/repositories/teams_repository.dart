import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/util/freezed_classes.dart';
import 'package:dartz/dartz.dart';

abstract class TeamsRepository {
  Future<Either<Failure, List<APITeam>>> getTeamsByLeague(String leagueId);

  Future<Either<Failure, APITeam>> getTeamDetails(String teamId);
}
