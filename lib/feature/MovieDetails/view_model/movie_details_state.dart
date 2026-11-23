import 'package:movies_app/feature/MovieDetails/model/model_name/movie_suggestion_model.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/parental_guide_model.dart';

import '../model/model_name/movie_details_model.dart';

class MovieDetailsState {}

class MovieDetailsInitState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  final MovieSuggestionModel movieSuggestion;
  final MovieParentalGuideModel movieParentalGuide;
  MovieDetailsSuccessState({
    required this.movieDetails,
    required this.movieSuggestion,
    required this.movieParentalGuide,
  });
}

class MovieDetailsFailerState extends MovieDetailsState {
  final String messageError;
  MovieDetailsFailerState({required this.messageError});
}
