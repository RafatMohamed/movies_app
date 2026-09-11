import 'package:flutter/cupertino.dart';
import 'package:movies_app/core/services/watch_list_data_source/watch_list_data_source.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/movie_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  final WatchListDataSource watchListDataSource;
  WatchListCubit({required this.watchListDataSource}) : super(WatchListInitial()) ;
  Future<void> getMovieWatchList() async {
    emit(WatchListLoading());
    try {
      final streamMovies =  watchListDataSource.getMovieData();
      streamMovies.listen((movies) {
        if (movies.isEmpty) {
          emit(WatchListSuccess(movies: const []));
          return;
        }
        emit(WatchListSuccess(movies: movies));
      },);
    } catch (error) {
      emit(WatchListFailed(errorMessage: "Something went wrong"));
    }
  }

}

class WatchMovieToggleCubit extends Cubit<WatchMovieToggleState> {
  final WatchListDataSource watchListDataSource;
  WatchMovieToggleCubit({required this.watchListDataSource}) : super(WatchMovieToggleState()) ;

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

}
