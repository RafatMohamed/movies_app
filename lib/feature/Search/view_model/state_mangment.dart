import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/feature/Search/view_model/movie_search_filter.dart';
import '../model/repo/repo.dart';

class MovieSearchCubit extends Cubit<MovieSearchFilterState> {

  final SearchMovieRepo _searchMovieRepo;

  MovieSearchCubit({required this._searchMovieRepo})
    : super(MovieSearchInitState());

  Future<void> getMovieDetails({required String? query}) async {
    emit(MovieSearchLoadingState());
    try {
      final movieResult = await _searchMovieRepo.getMovieFiltered(
        query: query??"",
      );
      emit(MovieSearchSuccessState(
          movieList: movieResult,
      ));
    } catch (error) {
      emit(MovieSearchFailerState(messageError: error.toString()));
    }
  }

  void onClear() {
    emit(MovieSearchInitState());
  }
}
