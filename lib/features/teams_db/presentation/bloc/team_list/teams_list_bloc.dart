import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_by_league_interactor.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String LOCAL_STORAGE_FAILURE_MESSAGE = 'Local Storage Failure';

class TeamsListBloc extends Bloc<TeamsListEvent, TeamsListState> {
  final GetTeamsByLeagueInteractor getTeamsByLeagueInteractor;

  TeamsListBloc({
    @required GetTeamsByLeagueInteractor teamsByLeague,
  })  : assert(teamsByLeague != null),
        getTeamsByLeagueInteractor = teamsByLeague;

  @override
  TeamsListState get initialState => Empty();

  @override
  Stream<TeamsListState> mapEventToState(
    TeamsListEvent event,
  ) async* {
    if (event is GetTeamsByLeagueEvent) {
      yield Loading();
      final failureOrTeams = await getTeamsByLeagueInteractor(
          LeagueParams(leagueId: event.leagueId));

      yield* _eitherLoadedTeamsOrErrorState(failureOrTeams);
    } else {
      throw UnimplementedError();
    }
  }
}

Stream<TeamsListState> _eitherLoadedTeamsOrErrorState(
  Either<Failure, List<APITeam>> failureOrTeams,
) async* {
  yield failureOrTeams.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (teams) => Loaded(teams: teams),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case NoLocalDataFailure:
      return LOCAL_STORAGE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
