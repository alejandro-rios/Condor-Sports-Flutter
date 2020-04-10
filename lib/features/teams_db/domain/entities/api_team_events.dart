import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'api_team_events.freezed.dart';
part 'api_team_events.g.dart';

@freezed
abstract class APITeamEvents with _$APITeamEvents {
  const factory APITeamEvents({
    @nullable @required String strHomeTeam,
    @nullable @required String strAwayTeam,
    @nullable @required String dateEvent,
    @nullable @required String idHomeTeam,
    @nullable @required String idAwayTeam,
  }) = _APITeamEvents;

  factory APITeamEvents.fromJson(Map<String, dynamic> json) => _$APITeamEventsFromJson(json);
}
