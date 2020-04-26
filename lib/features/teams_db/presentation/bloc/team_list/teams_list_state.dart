import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TeamsListState extends Equatable {
  const TeamsListState();
}

class Empty extends TeamsListState {
  @override
  List get props => [];
}

class Loading extends TeamsListState {
  @override
  List get props => [];
}

class Loaded extends TeamsListState {
  final List<APITeam> teams;

  Loaded({@required this.teams});

  @override
  List get props => [teams];
}

class Error extends TeamsListState {
  final String message;

  Error({@required this.message});

  @override
  List get props => [message];
}
