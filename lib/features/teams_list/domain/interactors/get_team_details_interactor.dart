import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/core/util/freezed_classes.dart';
import 'package:condor_sports_flutter/features/teams_list/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetTeamDetailsInteractor implements Interactor<APITeam, Params> {
  final TeamsRepository repository;

  GetTeamDetailsInteractor(this.repository);

  @override
  Future<Either<Failure, APITeam>> call(Params params) async =>
      await repository.getTeamDetails(params.teamId);
}

class Params extends Equatable {
  final String teamId;

  Params({@required this.teamId});

  @override
  List<Object> get props => [teamId];
}
