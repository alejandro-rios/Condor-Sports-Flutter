import 'package:condor_sports_flutter/core/error/failure.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_team_events_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_details/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetTeamEventsInteractor extends Mock
    implements GetTeamEventsInteractor {}

void main() {
  TeamDetailsBloc bloc;
  MockGetTeamEventsInteractor mockGetTeamEventsInteractor;

  setUp(() {
    mockGetTeamEventsInteractor = MockGetTeamEventsInteractor();

    bloc = TeamDetailsBloc(
      teamEvents: mockGetTeamEventsInteractor,
    );
  });

  test('initialState should be EmptyDetails', () {
    // Then
    expect(bloc.initialState, equals(EmptyDetails()));
  });

  group('GetTeamEventsInteractor', () {
    final tTeamId = '21';
    final List<APITeamEvents> tEventList = [
      APITeamEvents(
        strHomeTeam: "Brighton",
        strAwayTeam: "Liverpool",
        dateEvent: "2020-04-20",
        idHomeTeam: "133619",
        idAwayTeam: "133602",
      )
    ];

    test('should get data from the concrete use case', () async {
      // Given
      when(mockGetTeamEventsInteractor(any))
          .thenAnswer((_) async => Right(tEventList));

      // When
      bloc.add(GetEventsByTeamEvent(tTeamId));
      await untilCalled(mockGetTeamEventsInteractor(any));

      // Then
      verify(mockGetTeamEventsInteractor(TeamParams(teamId: tTeamId)));
    });

    test('should emit [LoadingDetails, LoadedDetails] when data is gotten successfully',
        () async {
      // Given
      when(mockGetTeamEventsInteractor(any))
          .thenAnswer((_) async => Right(tEventList));

      // Then later
      final expected = [
        EmptyDetails(),
        LoadingDetails(),
        LoadedDetails(events: tEventList)
      ];
      expectLater(bloc, emitsInOrder(expected));

      // When
      bloc.add(GetEventsByTeamEvent(tTeamId));
    });

    test('should emit [LoadingDetails, ErrorDetails] when getting data fails', () async {
      // Given
      when(mockGetTeamEventsInteractor(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Then later
      final expected = [
        EmptyDetails(),
        LoadingDetails(),
        ErrorDetails(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));

      // When
      bloc.add(GetEventsByTeamEvent(tTeamId));
    });
  });
}
