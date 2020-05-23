import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TeamDetailsState extends Equatable {
  const TeamDetailsState();
}

class EmptyDetails extends TeamDetailsState {
  @override
  List get props => [];
}

class LoadingDetails extends TeamDetailsState {
  @override
  List get props => [];
}

class LoadedDetails extends TeamDetailsState {
  final List<APITeamEvents> events;

  LoadedDetails({@required this.events});

  @override
  List get props => [events];
}

class LoadedTeams extends TeamDetailsState {
  final List<APITeam> teams;

  LoadedTeams({@required this.teams});

  @override
  List get props => [teams];
}

class ErrorDetails extends TeamDetailsState {
  final String message;

  ErrorDetails({@required this.message});

  @override
  List get props => [message];
}
