import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TeamsDbEvent extends Equatable {
  const TeamsDbEvent();
}

class GetTeamsByLeagueEvent extends TeamsDbEvent {
  final String leagueId;

  GetTeamsByLeagueEvent(this.leagueId);

  @override
  List get props => [leagueId];
}

class GetTeamEventsEvent extends TeamsDbEvent {
  final String teamId;

  GetTeamEventsEvent(this.teamId);

  @override
  List get props => [teamId];
}
