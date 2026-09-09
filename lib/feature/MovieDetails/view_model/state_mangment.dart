import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/feature/MovieDetails/view_model/movie_details_state.dart';
import '../model/repo/repo.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepo _movieDetailsRepo;

  MovieDetailsCubit({required this._movieDetailsRepo})
    : super(MovieDetailsInitState());

  Future<void> getMovieDetails({required int movieID}) async {
    emit(MovieDetailsLoadingState());
    try {
      final movieDetails = await _movieDetailsRepo.getMovieDetails(
        movieID: movieID,
      );

      final movieSuggestion = await _movieDetailsRepo.getSuggestionMovie(
        movieID: movieID,
      );

      final movieParentalGuide = await _movieDetailsRepo.getParentalGuidesMovie(
        movieID: movieID,
      );
      if (isClosed) return;
      emit(
        MovieDetailsSuccessState(
          movieDetails: movieDetails,
          movieSuggestion: movieSuggestion,
          movieParentalGuide: movieParentalGuide,
        ),
      );
    } catch (error) {
      if (isClosed) return;
      emit(MovieDetailsFailerState(messageError: error.toString()));
    }
  }
}
