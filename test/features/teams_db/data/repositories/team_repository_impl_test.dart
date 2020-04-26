import 'package:condor_sports_flutter/core/error/exceptions.dart';
import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/core/network/network_info.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_local_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_remote_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/data/repositories/teams_repository_impl.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements TeamsRemoteDataSource {}

class MockLocalDataSource extends Mock implements TeamsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  TeamsRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TeamsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getTeamsByLeague', () {
    final tLeagueId = '123';
    final List<APITeam> tTeamsList = [
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
        strDescriptionEN: "some description for the team",
        strTeamBadge: "some team badge",
        strTeamJersey: "some team jersey",
        strYoutube: "www.youtube.com/user/ArsenalTour",
      )
    ];

    test(
        'given network info when is connected is called then should check if the device is online',
        () async {
      // Given
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // When
      repository.getTeamsByLeague(tLeagueId);

      // Then
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'given RemoteDataSource when call is successfull then should return remote data',
          () async {
        // Given
        when(mockRemoteDataSource.getTeamsByLeague(any))
            .thenAnswer((_) async => tTeamsList);

        // When
        final result = await repository.getTeamsByLeague(tLeagueId);

        // Then
        verify(mockRemoteDataSource.getTeamsByLeague(tLeagueId));
        expect(result, equals((Right(tTeamsList))));
      });

      test(
          'given LocalDataSource when remote call is successfull then should save to local data',
          () async {
        // Given
        when(mockRemoteDataSource.getTeamsByLeague(any))
            .thenAnswer((_) async => tTeamsList);

        // When
        await repository.getTeamsByLeague(tLeagueId);

        // Then
        verify(mockRemoteDataSource.getTeamsByLeague(tLeagueId));
        verify(mockLocalDataSource.saveTeams(tTeamsList));
      });

      test(
          'given RemoteDataSource when call is unsuccessfull then should return ServerFailure',
          () async {
        // Given
        when(mockRemoteDataSource.getTeamsByLeague(any))
            .thenThrow(ServerException());

        // When
        final result = await repository.getTeamsByLeague(tLeagueId);

        // Then
        verify(mockRemoteDataSource.getTeamsByLeague(tLeagueId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'given LocalDataSource when data is present then should return team list',
          () async {
        // Given
        when(mockLocalDataSource.getTeams()).thenAnswer((_) async => tTeamsList);
        // When
        final result = await repository.getTeamsByLeague(tLeagueId);

        // Then
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getTeams());
        expect(result, equals(Right(tTeamsList)));
      });

      test(
          'given LocalDataSource when data is not present then should return NoLocalDataFailure',
          () async {
        // Given
        when(mockLocalDataSource.getTeams())
            .thenThrow(NoLocalDataException());

        // When
        final result = await repository.getTeamsByLeague(tLeagueId);

        // Then
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getTeams());
        expect(result, equals(Left(NoLocalDataFailure())));
      });
    });
  });

  group('getTeamEvents', () {
    final tTeamId = '13';
    final List<APITeamEvents> tEventsList = [
      APITeamEvents(
        strHomeTeam: "Brighton",
        strAwayTeam: "Liverpool",
        dateEvent: "2020-04-20",
        idHomeTeam: "133619",
        idAwayTeam: "133602",
      )
    ];

    test(
        'given network info when is connected is called then should check if the device is online',
            () async {
          // Given
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          // When
          repository.getTeamEvents(tTeamId);

          // Then
          verify(mockNetworkInfo.isConnected);
        });

    runTestsOnline(() {
      test(
          'given RemoteDataSource when call is successfull then should return remote data',
              () async {
            // Given
            when(mockRemoteDataSource.getTeamEvents(any))
                .thenAnswer((_) async => tEventsList);

            // When
            final result = await repository.getTeamEvents(tTeamId);

            // Then
            verify(mockRemoteDataSource.getTeamEvents(tTeamId));
            expect(result, equals((Right(tEventsList))));
          });

      test(
          'given LocalDataSource when remote call is successfull then should save to local data',
              () async {
            // Given
            when(mockRemoteDataSource.getTeamEvents(any))
                .thenAnswer((_) async => tEventsList);

            // When
            final result = await repository.getTeamEvents(tTeamId);

            // Then
            verify(mockRemoteDataSource.getTeamEvents(tTeamId));
            // missing call here
          });

      test(
          'given RemoteDataSource when call is unsuccessfull then should return ServerFailure',
              () async {
            // Given
            when(mockRemoteDataSource.getTeamEvents(any))
                .thenThrow(ServerException());

            // When
            final result = await repository.getTeamEvents(tTeamId);

            // Then
            verify(mockRemoteDataSource.getTeamEvents(tTeamId));
            //verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    runTestsOffline(() {
      test(
          'given LocalDataSource when data is present then should return team list',
              () async {
            // Given
//        when(mockLocalDataSource.getTeamById(any)).thenAnswer((_) async => tTeamsList);
            // When

            // Then
          });

      test(
          'given LocalDataSource when data is not present then should return NoLocalDataFailure',
              () async {
            // Given
            when(mockLocalDataSource.getTeams())
                .thenThrow(NoLocalDataException());

            // When
//            final result = await repository.

            // Then
          });
    });
  });
}
