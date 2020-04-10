import 'dart:convert';

import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_remote_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  TeamsRemoteDataSourceImpl remoteSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteSource = TeamsRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientTeamsSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('api_team_list.json'), 200));
  }

  void setUpMockHttpClientEventsSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('api_team_events_list.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getTeamsByLeague', () {
    final tLeagueId = '4328';
    final tTeamsList = json
        .decode(fixture('api_team_list.json'))['teams']
        .map((data) => APITeam.fromJson(data))
        .toList();

    test('''should perform a GET request on a URL with number 
        beign the endpoint and with application/json header''', () async {
      // Given
      setUpMockHttpClientTeamsSuccess200();

      // When
      remoteSource.getTeamsByLeague(tLeagueId);

      // Then
      verify(mockHttpClient.get(
          'https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=4328',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          }));
    });

    test('should return a list of teams when the response code is 200',
        () async {
      // Given
      setUpMockHttpClientTeamsSuccess200();

      // When
      final result = await remoteSource.getTeamsByLeague(tLeagueId);

      // Then
      expect(result, tTeamsList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // Given
      setUpMockHttpClientFailure404();

      // When
      final call = remoteSource.getTeamsByLeague;

      // Then
      expect(() => call(tLeagueId), throwsA(isA<ServerException>()));
    });
  });

  group('getTeamEvents', () {
    final tTeamId = '133604';
    final tEventsList = json
        .decode(fixture('api_team_events_list.json'))['events']
        .map((data) => APITeamEvents.fromJson(data))
        .toList();

    test('''should perform a GET request on a URL with number 
        beign the endpoint and with application/json header''', () async {
      // Given
      setUpMockHttpClientEventsSuccess200();

      // When
      remoteSource.getTeamEvents(tTeamId);

      // Then
      verify(mockHttpClient.get(
          'https://www.thesportsdb.com/api/v1/json/1/eventsnext.php?id=133604',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          }));
    });

    test('should return a list of teams when the response code is 200',
        () async {
      // Given
      setUpMockHttpClientEventsSuccess200();

      // When
      final result = await remoteSource.getTeamEvents(tTeamId);

      // Then
      expect(result, tEventsList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // Given
      setUpMockHttpClientFailure404();

      // When
      final call = remoteSource.getTeamEvents;

      // Then
      expect(() => call(tTeamId), throwsA(isA<ServerException>()));
    });
  });
}
