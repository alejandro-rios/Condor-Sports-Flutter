import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';

class GetTeamsFromDBInteractor implements Interactor<List<APITeam>, NoParams> {
  final TeamsRepository repository;

  GetTeamsFromDBInteractor(this.repository);

  @override
  Future<Either<Failure, List<APITeam>>> call(params) async =>
      await repository.getTeamsFromDB();
}
