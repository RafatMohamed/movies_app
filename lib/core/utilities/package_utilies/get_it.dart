import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/services/api_helper.dart';
import 'package:movies_app/feature/MovieDetails/model/data_source/movie_details_api_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/data_source/movie_details_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/repo/repo.dart';
import 'package:movies_app/feature/MovieDetails/view_model/state_mangment.dart';

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
}
