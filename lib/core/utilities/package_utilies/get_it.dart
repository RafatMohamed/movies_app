import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/cubit/history_list_cubit/history_list_cubit.dart';
import 'package:movies_app/core/cubit/watch_list_cubit/watch_list_cubit/watch_list_cubit.dart';
import 'package:movies_app/core/services/api_helper.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/services/firestore_service.dart';
import 'package:movies_app/core/services/history_list_data_source/history_list_data_source.dart';
import 'package:movies_app/core/services/history_list_data_source/history_list_remote_data_source_impl.dart';
import 'package:movies_app/core/services/watch_list_data_source/watch_list_data_source.dart';
import 'package:movies_app/core/services/watch_list_data_source/watch_list_remote_data_source_impl.dart';
import 'package:movies_app/core/utilities/auth/auth_cubit.dart';
import 'package:movies_app/feature/MovieDetails/model/data_source/movie_details_api_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/data_source/movie_details_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/repo/repo.dart';
import 'package:movies_app/feature/MovieDetails/view_model/state_mangment.dart';
import 'package:movies_app/feature/Search/model/data_source/search_data_source.dart';
import 'package:movies_app/feature/Search/model/repo/repo.dart';
import 'package:movies_app/feature/Search/view_model/state_mangment.dart';
import 'package:movies_app/feature/explore_tap/model/data_source/explore_data_source_api.dart';
import 'package:movies_app/feature/explore_tap/model/repo/explore_repo.dart';
import 'package:movies_app/feature/explore_tap/presentation/view_model/explore_cubit.dart';
import 'package:movies_app/feature/home_tap/model/data_source/movies_data_source_api.dart';
import 'package:movies_app/feature/home_tap/model/repo/repo.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_cubit.dart';
import '../../../feature/Search/model/data_source/search_data_source_imp.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<Dio>(() => ApiHelper.createDio());

  getIt.registerLazySingleton<MovieDetailsDataSource>(
    () => MovieDetailsApiDataSource(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<MovieDetailsRepo>(
    () => MovieDetailsRepo(
      movieDetailsDataSource: getIt<MovieDetailsDataSource>(),
    ),
  );

  getIt.registerFactory<MovieDetailsCubit>(
    () => MovieDetailsCubit(movieDetailsRepo: getIt<MovieDetailsRepo>()),
  );

  getIt.registerLazySingleton<SearchDataSource>(
    () => SearchDataSourceImp(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<SearchMovieRepo>(
    () => SearchMovieRepo(searchDataSource: getIt<SearchDataSource>()),
  );

  getIt.registerFactory<MovieSearchCubit>(
    () => MovieSearchCubit(searchMovieRepo: getIt<SearchMovieRepo>()),
  );
  //home tab
  getIt.registerLazySingleton<MoviesDataSourceApi>(
    () => MoviesDataSourceApi(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<HomeTapRepo>(
    () => HomeTapRepo(moviesApiDataSource: getIt<MoviesDataSourceApi>()),
  );
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthService>()));

  getIt.registerLazySingleton<WatchListDataSource>(
    () => WatchListRemoteDataSourceImpl(
      authService: getIt<AuthService>(),
      firestoreService: getIt<FirestoreService>(),
    ),
  );

  getIt.registerFactory<HomeTabCubit>(() => HomeTabCubit(getIt<HomeTapRepo>()));
  getIt.registerFactory<WatchListCubit>(
    () => WatchListCubit(watchListDataSource: getIt<WatchListDataSource>()),
  );
  getIt.registerFactory<WatchMovieToggleCubit>(
    () => WatchMovieToggleCubit(
      watchListDataSource: getIt<WatchListDataSource>(),
    ),
  );
  getIt.registerLazySingleton<ExploreDataSourceApi>(
    () => ExploreDataSourceApi(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ExploreRepo>(
    () => ExploreRepo(getIt<ExploreDataSourceApi>()),
  );

  getIt.registerFactory<ExploreCubit>(() => ExploreCubit(getIt<ExploreRepo>()));


  getIt.registerLazySingleton<HistoryListDataSource>(
    () => HistoryListRemoteDataSourceImpl(),
  );

  getIt.registerFactory<HistoryCubit>(
    () => HistoryCubit(historyListDataSource: getIt<HistoryListDataSource>()),
  );
}
