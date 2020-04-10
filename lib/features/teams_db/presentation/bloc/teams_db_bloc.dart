import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_team_events_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_by_league_interactor.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String LOCAL_STORAGE_FAILURE_MESSAGE = 'Local Storage Failure';

class TeamsDbBloc extends Bloc<TeamsDbEvent, TeamsDbState> {
  final GetTeamsByLeagueInteractor getTeamsByLeagueInteractor;
  final GetTeamEventsInteractor getTeamEventsInteractor;

  TeamsDbBloc({
    @required GetTeamsByLeagueInteractor teamsByLeague,
    @required GetTeamEventsInteractor teamEvents,
  })  : assert(teamsByLeague != null),
        assert(teamEvents != null),
        getTeamsByLeagueInteractor = teamsByLeague,
        getTeamEventsInteractor = teamEvents;

  @override
  TeamsDbState get initialState => Empty();

  @override
  Stream<TeamsDbState> mapEventToState(
    TeamsDbEvent event,
  ) async* {
    if (event is GetTeamsByLeagueEvent) {
      yield Loading();
      final failureOrTeams = await getTeamsByLeagueInteractor(
          LeagueParams(leagueId: event.leagueId));

      yield* _eitherLoadedTeamsOrErrorState(failureOrTeams);
    } else if (event is GetTeamEventsEvent) {
      throw UnimplementedError();
//      yield Loading();
//      final failureOrEvents =
//          await getTeamEventsInteractor(Params(teamId: event.teamId));
//
//      yield* _eitherLoadedEventsOrErrorState(failureOrEvents);
    }
  }

  Stream<TeamsDbState> _eitherLoadedTeamsOrErrorState(
    Either<Failure, List<APITeam>> failureOrTeams,
  ) async* {
    yield failureOrTeams.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (teams) => Loaded(teams: teams),
    );
  }

//  Stream<TeamsDbState> _eitherLoadedEventsOrErrorState(
//    Either<Failure, List<APITeamEvents>> failureOrEvents,
//  ) async* {
//    yield failureOrEvents.fold(
//      (failure) => Error(message: _mapFailureToMessage(failure)),
//      (teams) => Loaded(: events),
//    );
//  }

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
}
