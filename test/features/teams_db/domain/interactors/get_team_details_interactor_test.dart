import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_team_events_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTeamsRepository extends Mock implements TeamsRepository {}

void main() {
  GetTeamEventsInteractor interactor;
  MockTeamsRepository mockTeamsRepository;

  setUp(() {
    mockTeamsRepository = MockTeamsRepository();
    interactor = GetTeamEventsInteractor(mockTeamsRepository);
  });

  final tTeamId = '10';
  final List<APITeamEvents> tEventList = [
    APITeamEvents(
      strHomeTeam: "Brighton",
      strAwayTeam: "Liverpool",
      dateEvent: "2020-04-20",
      idHomeTeam: "133619",
      idAwayTeam: "133602",
    )
  ];

  test(
    'given repository when get team details is called the should return team data',
    () async {
      // Given
      when(mockTeamsRepository.getTeamEvents(any))
          .thenAnswer((_) async => Right(tEventList));

      // When
      final result = await interactor(TeamParams(teamId: tTeamId));

      // Then
      expect(result, Right(tEventList));
      verify(mockTeamsRepository.getTeamEvents(tTeamId));
      verifyNoMoreInteractions(mockTeamsRepository);
    },
  );
}
