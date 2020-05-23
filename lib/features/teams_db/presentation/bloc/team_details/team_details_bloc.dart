import 'dart:async';

import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_team_events_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_from_db_interactor.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class TeamDetailsBloc extends Bloc<TeamDetailsEvent, TeamDetailsState> {
  final GetTeamEventsInteractor getTeamEventsInteractor;
  final GetTeamsFromDBInteractor getTeamsFromDBInteractor;

  TeamDetailsBloc({
    @required GetTeamEventsInteractor teamEvents,
    @required GetTeamsFromDBInteractor teamsFromDB,
  })  : assert(teamEvents != null),
        assert(teamsFromDB != null),
        getTeamEventsInteractor = teamEvents,
        getTeamsFromDBInteractor = teamsFromDB;

  @override
  TeamDetailsState get initialState => EmptyDetails();

  @override
  Stream<TeamDetailsState> mapEventToState(
    TeamDetailsEvent event,
  ) async* {
    yield LoadingDetails();
    if (event is GetEventsByTeamEvent) {
      final failureOrEvents =
          await getTeamEventsInteractor(TeamParams(teamId: event.teamId));

      yield* _eitherLoadedEventsOrErrorState(failureOrEvents);
    } else if (event is GetTeamsFromDB) {
      final failureOrTeams = await getTeamsFromDBInteractor(NoParams());

      yield* _eitherLoadedTeamsOrErrorState(failureOrTeams);
    }
  }
}

Stream<TeamDetailsState> _eitherLoadedEventsOrErrorState(
  Either<Failure, List<APITeamEvents>> failureOrEvents,
) async* {
  yield failureOrEvents.fold(
    (failure) => ErrorDetails(message: _mapFailureToMessage(failure)),
    (events) => LoadedDetails(events: events),
  );
}

Stream<TeamDetailsState> _eitherLoadedTeamsOrErrorState(
  Either<Failure, List<APITeam>> failureOrTeams,
) async* {
  yield failureOrTeams.fold(
    (failure) => ErrorDetails(message: _mapFailureToMessage(failure)),
    (teams) => LoadedTeams(teams: teams),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
