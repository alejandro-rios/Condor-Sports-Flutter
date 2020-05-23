import 'package:condor_sports_flutter/core/network/network_info.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_local_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/data/datasources/teams_remote_data_source.dart';
import 'package:condor_sports_flutter/features/teams_db/data/repositories/teams_repository_impl.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_team_events_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_by_league_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/interactors/get_teams_from_db_interactor.dart';
import 'package:condor_sports_flutter/features/teams_db/domain/repositories/teams_repository.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_list/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/teams_db/presentation/bloc/team_details/team_details_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Condor Sports
  // Bloc
  sl.registerFactory(() => TeamsListBloc(teamsByLeague: sl()));
  sl.registerFactory(() => TeamDetailsBloc(teamEvents: sl(), teamsFromDB: sl()));

  // Interactors
  sl.registerLazySingleton(() => GetTeamsByLeagueInteractor(sl()));
  sl.registerLazySingleton(() => GetTeamEventsInteractor(sl()));
  sl.registerLazySingleton(() => GetTeamsFromDBInteractor(sl()));

  // Repository
  sl.registerLazySingleton<TeamsRepository>(() => TeamsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<TeamsRemoteDataSource>(
      () => TeamsRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<TeamsLocalDataSource>(
      () => TeamsLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
