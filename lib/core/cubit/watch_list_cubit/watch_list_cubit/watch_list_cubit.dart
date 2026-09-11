import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/services/watch_list_data_source/watch_list_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/movie_details_model.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  final WatchListDataSource watchListDataSource;
  WatchListCubit({required this.watchListDataSource, required String movieID})
    : super(WatchListInitial()) {
    getIsWatched(movieID: movieID);
  }

  bool isInWatched = false;

  Future<void> getIsWatched({required String movieID}) async {
    try {
      isInWatched = await watchListDataSource.getMovieDataIS(movieID: movieID);
      emit(WatchListStatusChanged(isInWatched: isInWatched));
    } catch (error) {
      emit(MovieToggleFailed(errorMessage: "Something went wrong"));
    }
  }

  Future<void> toggleWatched({required MovieModel movie}) async {
    try {
      if (isInWatched) {
        await watchListDataSource.deleteMovieData(movieID: movie.id.toString());
        isInWatched = false;
      } else {
       await watchListDataSource.setMovieData(movie: movie);
        isInWatched = true;
      }
      emit(WatchListStatusChanged(isInWatched: isInWatched));
    } catch (error) {
      emit(MovieToggleFailed(errorMessage: "Something went wrong"));
    }
  }

  Future<void> getMovieWatchList({required String movieID}) async {
    emit(WatchListLoading());
    try {
      final movies = await watchListDataSource.getMovieData();
      if (movies.isEmpty) {
        emit(WatchListInitial());
      }
      emit(WatchListSuccess(movies: movies));
    } catch (error) {
      emit(WatchListFailed(errorMessage: "Something went wrong"));
    }
  }
}
