import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_by_league_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTeamsRepository extends Mock implements TeamsRepository {}

void main() {
  GetTeamsByLeagueInteractor interactor;
  MockTeamsRepository mockTeamsRepository;

  setUp(() {
    mockTeamsRepository = MockTeamsRepository();
    interactor = GetTeamsByLeagueInteractor(mockTeamsRepository);
  });

  final tLeagueId = "1";
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
    'given repository when get teams by league is called then should return a list os Teams',
    () async {
      // Given
      when(mockTeamsRepository.getTeamsByLeague(any))
          .thenAnswer((_) async => Right(tTeamsList));

      // When
      final result = await interactor(LeagueParams(leagueId: tLeagueId));

      // Then
      expect(result, Right(tTeamsList));
      verify(mockTeamsRepository.getTeamsByLeague(tLeagueId));
      verifyNoMoreInteractions(mockTeamsRepository);
    },
  );
}
