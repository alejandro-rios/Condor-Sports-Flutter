import 'dart:convert';

import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/features/teams_list/data/datasources/teams_local_data_source.dart';
import 'package:condor_sports_flutter/features/teams_list/data/models/team_model.dart';
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
    final tTeamModel = TeamModel.fromJson(json.decode(fixture('team.json')));

    test(
        'gievn local storage when get team data is called then should return TeamModel from SharedPreferences',
        () async {
      // Given
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('team.json'));

      // When
      final result = await dataSource.getTeamById(tTeamId);

      // Then
      verify(mockSharedPreferences.getString(CACHED_TEAMS));
      expect(result, equals(tTeamModel));
    });

    test(
        'should return NoLocalStorageException from SharedPreferences when there is not cached value',
        () async {
      // Given
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // When
      final result = await dataSource.getTeamById(tTeamId);

      // Then
      expect(result, throwsA(isA<NoLocalDataException>()));
    });
  });
}
