// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_team_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_APITeamEvents _$_$_APITeamEventsFromJson(Map<String, dynamic> json) {
  return _$_APITeamEvents(
    strHomeTeam: json['strHomeTeam'] as String,
    strAwayTeam: json['strAwayTeam'] as String,
    dateEvent: json['dateEvent'] as String,
    idHomeTeam: json['idHomeTeam'] as String,
    idAwayTeam: json['idAwayTeam'] as String,
  );
}

Map<String, dynamic> _$_$_APITeamEventsToJson(_$_APITeamEvents instance) =>
    <String, dynamic>{
      'strHomeTeam': instance.strHomeTeam,
      'strAwayTeam': instance.strAwayTeam,
      'dateEvent': instance.dateEvent,
      'idHomeTeam': instance.idHomeTeam,
      'idAwayTeam': instance.idAwayTeam,
    };
