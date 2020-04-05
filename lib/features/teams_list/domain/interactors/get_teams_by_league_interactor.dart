import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/core/util/freezed_classes.dart';
import 'package:condor_sports_flutter/features/teams_list/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetTeamsByLeagueInteractor implements Interactor<List<APITeam>, Params> {
  final TeamsRepository repository;

  GetTeamsByLeagueInteractor(this.repository);

  @override
  Future<Either<Failure, List<APITeam>>> call(Params params) async =>
      await repository.getTeamsByLeague(params.leagueId);
}

class Params extends Equatable {
  final String leagueId;

  Params({@required this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
