import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetTeamsByLeagueInteractor implements Interactor<List<APITeam>, LeagueParams> {
  final TeamsRepository repository;

  GetTeamsByLeagueInteractor(this.repository);

  @override
  Future<Either<Failure, List<APITeam>>> call(LeagueParams params) async =>
      await repository.getTeamsByLeague(params.leagueId);
}

class LeagueParams extends Equatable {
  final String leagueId;

  LeagueParams({@required this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
