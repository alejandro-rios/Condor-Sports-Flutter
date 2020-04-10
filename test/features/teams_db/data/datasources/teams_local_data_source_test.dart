import 'dart:convert';

import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_local_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixture/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TeamsLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = TeamsLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getTeamData', () {
    final tTeamId = '10';
    final tAPITeam = APITeam.fromJson(json.decode(fixture('api_team.json')));

    test(
        'given local storage when get team data is called then should return TeamModel from SharedPreferences',
        () async {
      // Given
      when(mockSharedPreferences.get(any))
          .thenReturn(fixture('api_team.json'));

      // When
      final result = await dataSource.getTeamById(tTeamId);

      // Then
      verify(mockSharedPreferences.get(CACHED_TEAMS));
      expect(result, equals(tAPITeam));
    });

    test(
        'should return NoLocalStorageException from SharedPreferences when there is not cached value',
        () async {
      // Given
      when(mockSharedPreferences.get(any)).thenReturn(null);

      // When
      final call = dataSource.getTeamById(tTeamId);

      // Then
      expect(() => call, throwsA(isA<NoLocalDataException>()));
    });
  });

  group('saveTeams', () {
    final tTeamModel = APITeam(
        idTeam: "133604",
        strTeam: "Arsenal",
        strAlternate: "Gunners",
        intFormedYear: "1892",
        strStadium: "Emirates Stadium",
        strWebsite: "www.arsenal.com",
        strFacebook: "www.facebook.com/Arsenal",
        strTwitter: "twitter.com/arsenal",
        strInstagram: "instagram.com/arsenal",
        strDescriptionEN:
            "Arsenal Football Club is a professional football club based in Holloway, London which currently plays in the Premier League, the highest level of English football. One of the most successful clubs in English football, they have won 13 First Division and Premier League titles and a joint record 11 FA Cups.\r\n\r\nArsenals success has been particularly consistent: the club has accumulated the second most points in English top-flight football, hold the ongoing record for the longest uninterrupted period in the top flight, and would be placed first in an aggregated league of the entire 20th century. Arsenal is the second side to complete an English top-flight season unbeaten (in the 2003–04 season), playing almost twice as many matches as the previous invincibles Preston North End in the 1888–89 season.\r\n\r\nArsenal was founded in 1886 in Woolwich and in 1893 became the first club from the south of England to join the Football League. In 1913, they moved north across the city to Arsenal Stadium in Highbury. In the 1930s, they won five League Championship titles and two FA Cups. After a lean period in the post-war years they won the League and FA Cup Double, in the 1970–71 season, and in the 1990s and first decade of the 21st century, won two more Doubles and reached the 2006 UEFA Champions League Final. Since neighbouring Tottenham Hotspur, the two clubs have had a fierce rivalry, the North London derby.\r\n\r\nArsenal have one of the highest incomes and largest fanbases in the world. The club was named the fifth most valuable association football club in the world, valued at £1.3 billion in 2014.",
        strTeamBadge:
            "https://www.thesportsdb.com/images/media/team/badge/a1af2i1557005128.png",
        strTeamJersey:
            "https://www.thesportsdb.com/images/media/team/jersey/2019-133604-Jersey.png",
        strYoutube: "www.youtube.com/user/ArsenalTour");

    test(
      'should call SharedPreferences to save the teams data',
      () async {
        // When
        dataSource.saveTeams(tTeamModel);

        // Then
        final expectedJsonString = json.encode(tTeamModel.toJson());
        verify(
            mockSharedPreferences.setString(CACHED_TEAMS, expectedJsonString));
      },
    );
  });
}
