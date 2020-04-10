import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TeamsDbState extends Equatable {
  const TeamsDbState();
}

class Empty extends TeamsDbState {
  @override
  List get props => [];
}

class Loading extends TeamsDbState {
  @override
  List get props => [];
}

class Loaded extends TeamsDbState {
  final List<APITeam> teams;

  Loaded({@required this.teams});

  @override
  List get props => [teams];
}

//class Loaded extends TeamsDbState {
//  final List<APITeamEvents> teams;
//
//  Loaded({@required this.teams});
//
//  @override
//  List get props => [teams];
//}

class Error extends TeamsDbState {
  final String message;

  Error({@required this.message});

  @override
  List get props => [message];
}
