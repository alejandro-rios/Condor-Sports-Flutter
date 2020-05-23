import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_by_league_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_list/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetTeamsByLeagueInteractor extends Mock
    implements GetTeamsByLeagueInteractor {}

void main() {
  TeamsListBloc bloc;
  MockGetTeamsByLeagueInteractor mockGetTeamsByLeagueInteractor;

  setUp(() {
    mockGetTeamsByLeagueInteractor = MockGetTeamsByLeagueInteractor();

    bloc = TeamsListBloc(
      teamsByLeague: mockGetTeamsByLeagueInteractor,
    );
  });

  test('initialState should be Empty', () {
    // Then
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTeamsByLeagueInteractor', () {
    final tLeagueId = '12';
    final List<APITeam> tTeamList = [
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

    test('should get data from the concrete use case', () async {
      // Given
      when(mockGetTeamsByLeagueInteractor(any))
          .thenAnswer((_) async => Right(tTeamList));

      // When
      bloc.add(GetTeamsByLeagueEvent(tLeagueId));
      await untilCalled(mockGetTeamsByLeagueInteractor(any));

      // Then
      verify(mockGetTeamsByLeagueInteractor(LeagueParams(leagueId: tLeagueId)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // Given
      when(mockGetTeamsByLeagueInteractor(any))
          .thenAnswer((_) async => Right(tTeamList));

      // Then later
      final expected = [Empty(), Loading(), Loaded(teams: tTeamList)];
      expectLater(bloc, emitsInOrder(expected));

      // When
      bloc.add(GetTeamsByLeagueEvent(tLeagueId));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // Given
      when(mockGetTeamsByLeagueInteractor(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Then later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));

      // When
      bloc.add(GetTeamsByLeagueEvent(tLeagueId));
    });

    test(
        'should emit [Loading, Error] when a proper message for the error when getting data fails',
        () async {
      // Given
      when(mockGetTeamsByLeagueInteractor(any))
          .thenAnswer((_) async => Left(NoLocalDataFailure()));

      // Then later
      final expected = [
        Empty(),
        Loading(),
        Error(message: LOCAL_STORAGE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));

      // When
      bloc.add(GetTeamsByLeagueEvent(tLeagueId));
    });
  });
}
