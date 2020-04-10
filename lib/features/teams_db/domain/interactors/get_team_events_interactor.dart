import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetTeamEventsInteractor
    implements Interactor<List<APITeamEvents>, TeamParams> {
  final TeamsRepository repository;

  GetTeamEventsInteractor(this.repository);

  @override
  Future<Either<Failure, List<APITeamEvents>>> call(TeamParams params) async =>
      await repository.getTeamEvents(params.teamId);
}

class TeamParams extends Equatable {
  final String teamId;

  TeamParams({@required this.teamId});

  @override
  List<Object> get props => [teamId];
}
