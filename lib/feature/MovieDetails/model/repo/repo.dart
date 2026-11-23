import 'package:movies_app/feature/MovieDetails/model/model_name/movie_details_model.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/movie_suggestion_model.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/parental_guide_model.dart';

import '../data_source/movie_details_data_source.dart';

class MovieDetailsRepo {
  final MovieDetailsDataSource _movieDetailsDataSource;
  const MovieDetailsRepo({required this._movieDetailsDataSource});

  Future<MovieDetailsModel> getMovieDetails({required int movieID}) async {
    try {
      final MovieDetailsModel? result = await _movieDetailsDataSource
          .getMovieDetails(movieID: movieID);
      if (result == null) {
        throw "Movies isn't Available now";
      }
      return result;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<MovieSuggestionModel> getSuggestionMovie({
    required int movieID,
  }) async {
    try {
      final result = await _movieDetailsDataSource.getSuggestionMovie(
        movieID: movieID,
      );
      return result;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<MovieParentalGuideModel> getParentalGuidesMovie({
    required int movieID,
  }) async {
    try {
      final result = await _movieDetailsDataSource.getParentalGuidesMovie(
        movieID: movieID,
      );
      return result;
    } catch (error) {
      throw error.toString();
    }
  }
}
