import 'dart:convert';

import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main(){
  final tTeam = APITeam(
    idTeam: "133604",
    strTeam: "Arsenal",
    strAlternate: "Gunners",
    intFormedYear: "1892",
    strStadium: "Emirates Stadium",
    strWebsite: "www.arsenal.com",
    strFacebook: "www.facebook.com/Arsenal",
    strTwitter: "twitter.com/arsenal",
    strInstagram: "instagram.com/arsenal",
    strDescriptionEN: "some description for the team",
    strTeamBadge: "some team badge",
    strTeamJersey: "some team jersey",
    strYoutube: "www.youtube.com/user/ArsenalTour",
  );

  group('fromJson', () {
    test(
      'given a JSON team when APITeam.fromJson is called then should return a valid APITeam model',
          () async {
        // Given
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('api_team.json'));

        // When
        final result = APITeam.fromJson(jsonMap);

        // Then
        expect(result, tTeam);
      },
    );
  });

  group('toJson', () {
    test(
      'given a APITeam model when json.encode is called then should return a valid JSON',
          () async {
        // When
        final result = tTeam.toJson();

        // Then
        final expectedMap = {
          "idTeam": "133604",
          "strTeam": "Arsenal",
          "strAlternate": "Gunners",
          "intFormedYear": "1892",
          "strStadium": "Emirates Stadium",
          "strWebsite": "www.arsenal.com",
          "strFacebook": "www.facebook.com/Arsenal",
          "strTwitter": "twitter.com/arsenal",
          "strInstagram": "instagram.com/arsenal",
          "strDescriptionEN": "some description for the team",
          "strTeamBadge": "some team badge",
          "strTeamJersey": "some team jersey",
          "strYoutube": "www.youtube.com/user/ArsenalTour"
        };
        expect(result, expectedMap);
      },
    );
  });
}
