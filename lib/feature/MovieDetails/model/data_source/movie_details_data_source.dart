import 'package:movies_app/feature/MovieDetails/model/model_name/movie_suggestion_model.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/parental_guide_model.dart';
import '../model_name/movie_details_model.dart';

abstract class MovieDetailsDataSource {
  Future<MovieDetailsModel>? getMovieDetails({required int movieID});

  Future<MovieSuggestionModel> getSuggestionMovie({required int movieID});

  Future<MovieParentalGuideModel> getParentalGuidesMovie({
    required int movieID,
  });
}
