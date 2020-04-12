import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/network/network_info.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_local_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_remote_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class TeamsRepositoryImpl implements TeamsRepository {
  final TeamsRemoteDataSource remoteDataSource;
  final TeamsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TeamsRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, List<APITeam>>> getTeamsByLeague(
      String leagueId) async {
    if (await networkInfo.isConnected) {
      try {
        final teamsByLeague = await remoteDataSource.getTeamsByLeague(leagueId);
//        localDataSource.cacheNumberTrivia(remoteTrivia);

        return Right(teamsByLeague);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<APITeamEvents>>> getTeamEvents(
      String teamId) async {
    if (await networkInfo.isConnected) {
      try {
        final teamEvents = await remoteDataSource.getTeamEvents(teamId);

        return Right(teamEvents);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
