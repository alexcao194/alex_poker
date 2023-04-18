import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/data/datasources/cache_data.dart';

import '/app/authentication/data/datasources/remote_data.dart' as ac;
import '/app/authentication/data/datasources/cache_data.dart' as ac;
import '/app/authentication/data/respositories/repositories_impl.dart' as ac;
import '/app/authentication/domain/repositories/repositories.dart' as ac;
import '/app/authentication/domain/usecases/signup.dart' as ac;
import '/app/authentication/domain/usecases/login.dart' as ac;
import '/app/authentication/domain/usecases/get_account.dart' as ac;
import '/app/authentication/domain/usecases/set_ip.dart' as ac;
import '/app/authentication/presentation/bloc/authentication/authentication_bloc.dart' as ac;
import '/app/authentication/presentation/bloc/account/account_cubit.dart' as ac;
import '/app/authentication/presentation/bloc/ip/ip_cubit.dart' as ac;

import 'app/home/data/datasources/remote_data.dart' as home;
import 'app/home/data/respositories/repositories_impl.dart' as home;
import 'app/home/domain/repositories/repositories.dart' as home;
import 'app/home/domain/usecases/get_profile.dart' as home;
import 'app/home/presentation/bloc/user_profile_bloc.dart' as home;

import 'app/poker/data/datasources/realtime_data.dart' as poker;
import 'app/poker/data/respositories/repositories_impl.dart' as poker;
import 'app/poker/domain/repositories/repositories.dart' as poker;
import 'app/poker/domain/usecases/connect.dart' as poker;
import 'app/poker/domain/usecases/disconnect.dart' as poker;
import 'app/poker/domain/usecases/join_room.dart' as poker;
import 'app/poker/domain/usecases/leave_room.dart' as poker;
import 'app/poker/domain/usecases/fetch_lobby_info.dart' as poker;
import 'app/poker/presentation/bloc/room/room_bloc.dart' as poker;
import 'app/poker/presentation/bloc/play/play_bloc.dart' as poker;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ac.AuthenticationBloc(
      signup: sl(),
      login: sl(),
      getAccount: sl()
  ));
  sl.registerFactory(() => ac.AccountCubit(
      getAccount: sl()
  ));
  sl.registerFactory(() => ac.IpCubit(
      setIp: sl()
  ));
  sl.registerFactory(() => home.UserProfileBloc(
    getProfile: sl()
  ));

  sl.registerFactory(() => poker.RoomBloc(
      connect: sl(),
      disconnect: sl(),
      fetchLobbyInfo: sl(),
      joinRoom: sl(),
  ));

  sl.registerFactory(() => poker.PlayBloc(
    leaveRoom: sl(),
    connect: sl()
  ));

  // Usecase
  sl.registerLazySingleton(() => ac.Signup(repositories: sl()));
  sl.registerLazySingleton(() => ac.Login(repositories: sl()));
  sl.registerLazySingleton(() => ac.SetIp(repositories: sl()));
  sl.registerLazySingleton(() => ac.GetAccount(repositories: sl()));
  sl.registerLazySingleton(() => home.GetProfile(repositories: sl()));
  sl.registerLazySingleton(() => poker.Connect(repositories: sl()));
  sl.registerLazySingleton(() => poker.Disconnect(repositories: sl()));
  sl.registerLazySingleton(() => poker.FetchLobbyInfo(repositories: sl()));
  sl.registerLazySingleton(() => poker.JoinRoom(repositories: sl()));
  sl.registerLazySingleton(() => poker.LeaveRoom(repositories: sl()));



  // Repositories
  sl.registerLazySingleton<ac.Repositories>(() => ac.RepositoriesImpl(
      remoteData: sl(),
      cacheData: sl(),
      coreCacheData: sl()
  ));

  sl.registerLazySingleton<home.Repositories>(() => home.RepositoriesImpl(
    coreCacheData: sl(),
    remoteData: sl()
  ));
  sl.registerLazySingleton<poker.Repositories>(() => poker.RepositoriesImpl(
      coreCacheData: sl(),
    realtimeData: sl()
  ));



  // Data
  sl.registerLazySingleton<ac.RemoteData>(() => ac.RemoteDataImpl(
      dio: sl()
  ));
  sl.registerLazySingleton<home.RemoteData>(() => home.RemoteDataImpl(
      dio: sl()
  ));
  sl.registerLazySingleton<poker.RealtimeData>(() => poker.RealtimeDataImpl());
  sl.registerLazySingleton<ac.CacheData>(() => ac.CacheDataImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<CoreCacheData>(() => CoreCacheDataImpl(sharedPreferences: sl()));


  // 3th service
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}