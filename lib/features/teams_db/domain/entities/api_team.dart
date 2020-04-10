import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'api_team.freezed.dart';
part 'api_team.g.dart';

@freezed
abstract class APITeam with _$APITeam {
  const factory APITeam({
    @required String idTeam,
    @required String strTeam,
    @nullable @required String strAlternate,
    @required String intFormedYear,
    @nullable @required String strStadium,
    @nullable @required String strWebsite,
    @nullable @required String strFacebook,
    @nullable @required String strTwitter,
    @nullable @required String strInstagram,
    @required String strDescriptionEN,
    @nullable @required String strTeamBadge,
    @nullable @required String strTeamJersey,
    @nullable @required String strYoutube,
  }) = _APITeam;

  factory APITeam.fromJson(Map<String, dynamic> json) => _$APITeamFromJson(json);
}
