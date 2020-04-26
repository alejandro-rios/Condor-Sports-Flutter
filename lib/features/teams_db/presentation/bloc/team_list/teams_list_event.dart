import 'package:equatable/equatable.dart';

abstract class TeamsListEvent extends Equatable {
  const TeamsListEvent();
}

class GetTeamsByLeagueEvent extends TeamsListEvent {
  final String leagueId;

  GetTeamsByLeagueEvent(this.leagueId);

  @override
  List get props => [leagueId];
}
