import 'package:equatable/equatable.dart';

abstract class TeamDetailsEvent extends Equatable {
  const TeamDetailsEvent();
}

class GetEventsByTeamEvent extends TeamDetailsEvent {
  final String teamId;

  GetEventsByTeamEvent(this.teamId);

  @override
  List get props => [teamId];
}
