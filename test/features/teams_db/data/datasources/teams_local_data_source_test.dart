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
    final tAPITeams = json
        .decode(fixture('teams_list_cached.json'))
        .map((data) => APITeam.fromJson(data))
        .toList();

    test(
        'given local storage when get team data is called then should return TeamModel list from SharedPreferences',
        () async {
      // Given
      when(mockSharedPreferences.get(any))
          .thenReturn(fixture('teams_list_cached.json'));

      // When
      final result = await dataSource.getTeams();

      // Then
      verify(mockSharedPreferences.get(CACHED_TEAMS));
      expect(result, equals(tAPITeams));
    });

    test(
        'given local storage when there is not cached value then should return NoLocalStorageException from SharedPreferences',
        () async {
      // Given
      when(mockSharedPreferences.get(any)).thenReturn(null);

      // When
      final call = dataSource.getTeams;

      // Then
      expect(() => call(), throwsA(isA<NoLocalDataException>()));
    });
  });

  group('saveTeams', () {
    final List<APITeam> tTeamModel = [
      APITeam(
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
          strYoutube: "www.youtube.com/user/ArsenalTour"),
      APITeam(
          idTeam: "133602",
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
          strYoutube: "www.youtube.com/user/ArsenalTour")
    ];

    test(
      'given local storage when saveTeams is called then should save the teams data',
      () async {
        // When
        dataSource.saveTeams(tTeamModel);

        // Then
        final expectedJsonString = json.encode(tTeamModel);
        verify(
            mockSharedPreferences.setString(CACHED_TEAMS, expectedJsonString));
      },
    );
  });
}
