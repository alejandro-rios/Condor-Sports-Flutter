import 'package:condor_sports_flutter/core/util/freezed_classes.dart';
import 'package:condor_sports_flutter/features/teams_list/domain/interactors/get_team_details_interactor.dart';
import 'package:condor_sports_flutter/features/teams_list/domain/repositories/teams_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTeamsRepository extends Mock implements TeamsRepository {}

void main() {
  GetTeamDetailsInteractor interactor;
  MockTeamsRepository mockTeamsRepository;

  setUp(() {
    mockTeamsRepository = MockTeamsRepository();
    interactor = GetTeamDetailsInteractor(mockTeamsRepository);
  });

  final tTeamId = '10';
  final tTeam = APITeam(
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
  );

  test(
    'given repository when get team details is called the should return team data',
    () async {
      // Given
      when(mockTeamsRepository.getTeamDetails(any))
          .thenAnswer((_) async => Right(tTeam));

      // When
      final result = await interactor(Params(teamId: tTeamId));

      // Then
      expect(result, Right(tTeam));
      verify(mockTeamsRepository.getTeamDetails(tTeamId));
      verifyNoMoreInteractions(mockTeamsRepository);
    },
  );
}
