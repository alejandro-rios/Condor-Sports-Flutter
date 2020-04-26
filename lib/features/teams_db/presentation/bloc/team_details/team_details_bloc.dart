import 'dart:async';

import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_team_events_interactor.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class TeamDetailsBloc extends Bloc<TeamDetailsEvent, TeamDetailsState> {
  final GetTeamEventsInteractor getTeamEventsInteractor;

  TeamDetailsBloc({
    @required GetTeamEventsInteractor teamEvents,
  })  : assert(teamEvents != null),
        getTeamEventsInteractor = teamEvents;

  @override
  TeamDetailsState get initialState => EmptyDetails();

  @override
  Stream<TeamDetailsState> mapEventToState(
    TeamDetailsEvent event,
  ) async* {
    if (event is GetEventsByTeamEvent) {
      yield LoadingDetails();
      final failureOrTeams =
          await getTeamEventsInteractor(TeamParams(teamId: event.teamId));

      yield* _eitherLoadedTeamsOrErrorState(failureOrTeams);
    } else {
      throw UnimplementedError();
    }
  }
}

Stream<TeamDetailsState> _eitherLoadedTeamsOrErrorState(
  Either<Failure, List<APITeamEvents>> failureOrEvents,
) async* {
  yield failureOrEvents.fold(
    (failure) => ErrorDetails(message: _mapFailureToMessage(failure)),
    (teams) => LoadedDetails(events: teams),
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
