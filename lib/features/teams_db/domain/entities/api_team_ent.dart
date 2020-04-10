import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class APITeamEnt extends Equatable {
  final String idTeam;
  final String strTeam;
  final String strAlternate;
  final String intFormedYear;
  final String strStadium;
  final String strWebsite;
  final String strFacebook;
  final String strTwitter;
  final String strInstagram;
  final String strDescriptionEN;
  final String strTeamBadge;
  final String strTeamJersey;
  final String strYoutube;

  APITeamEnt({
    this.idTeam,
    @required this.strTeam,
    this.strAlternate,
    @required this.intFormedYear,
    this.strStadium,
    this.strWebsite,
    this.strFacebook,
    this.strTwitter,
    this.strInstagram,
    @required this.strDescriptionEN,
    this.strTeamBadge,
    this.strTeamJersey,
    this.strYoutube,
  });

  @override
  List<Object> get props => [
        idTeam,
        strTeam,
        strAlternate,
        intFormedYear,
        strStadium,
        strWebsite,
        strFacebook,
        strTwitter,
        strInstagram,
        strDescriptionEN,
        strTeamBadge,
        strTeamJersey,
        strYoutube
      ];
}
