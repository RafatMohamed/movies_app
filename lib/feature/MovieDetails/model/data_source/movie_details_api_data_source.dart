import 'package:dio/dio.dart';
import 'package:movies_app/core/const.dart';
import 'package:movies_app/feature/MovieDetails/model/data_source/movie_details_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/movie_suggestion_model.dart';

import '../model_name/movie_details_model.dart';
import '../model_name/parental_guide_model.dart';

class MovieDetailsApiDataSource implements MovieDetailsDataSource {
  final Dio _dio;

  const MovieDetailsApiDataSource({required this._dio});

  @override
  Future<MovieDetailsModel> getMovieDetails({required int movieID}) async {
    try {
      final movieResponse = await _dio.get(
        AppConstApi.endPointMovieDetails,
        queryParameters: {
          "movie_id": movieID,
          "with_images": true,
          "with_cast": true,
        },
      );
      final MovieDetailsModel movieDetails = MovieDetailsModel.fromJson(
        movieResponse.data,
      );
      if (movieDetails.status != "ok") {
        throw Exception("something Went Wrong");
      }
      return movieDetails;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieSuggestionModel> getSuggestionMovie({
    required int movieID,
  }) async {
    try {
      final movieResponse = await _dio.get(
        AppConstApi.endPointMovieSuggestion,
        queryParameters: {"movie_id": movieID},
      );
      final MovieSuggestionModel movieSuggestion =
          MovieSuggestionModel.fromJson(movieResponse.data);
      if (movieSuggestion.status != "ok") {
        throw Exception("something Went Wrong");
      }
      return movieSuggestion;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieParentalGuideModel> getParentalGuidesMovie({
    required int movieID,
  }) async {
    try {
      final movieResponse = await _dio.get(
        AppConstApi.endPointMovieParentalGuid,
        queryParameters: {"movie_id": movieID},
      );
      final MovieParentalGuideModel movieParentalGuid =
          MovieParentalGuideModel.fromJson(movieResponse.data);
      if (movieParentalGuid.status != "ok") {
        throw Exception("something Went Wrong");
      }
      return movieParentalGuid;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
