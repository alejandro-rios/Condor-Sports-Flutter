import 'package:condor_sports_flutter/core/interactor/interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_from_db_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTeamsRepository extends Mock implements TeamsRepository {}

void main() {
  GetTeamsFromDBInteractor interactor;
  MockTeamsRepository mockTeamsRepository;

  setUp(() {
    mockTeamsRepository = MockTeamsRepository();
    interactor = GetTeamsFromDBInteractor(mockTeamsRepository);
  });

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
    'given repository when get teams from db is called then should return a list os Teams',
    () async {
      // Given
      when(mockTeamsRepository.getTeamsFromDB())
          .thenAnswer((_) async => Right(tTeamsList));

      // When
      final result = await interactor(NoParams());

      // Then
      expect(result, Right(tTeamsList));
      verify(mockTeamsRepository.getTeamsFromDB());
      verifyNoMoreInteractions(mockTeamsRepository);
    },
  );
}
