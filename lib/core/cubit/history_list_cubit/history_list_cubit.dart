import 'dart:async';
import 'package:movies_app/core/cubit/history_list_cubit/history_list_state.dart';
import 'package:movies_app/core/models/movie_history_cach_model.dart';
import 'package:movies_app/core/services/history_list_data_source/history_list_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryListDataSource _historyListDataSource;

  HistoryCubit({required this._historyListDataSource})
    : super(HistoryInitial());

  Future<void> cacheMovie(MovieCacheModel movie) async {
    try {
      await _historyListDataSource.cacheMovieData(movie: movie);

      final movies = await _historyListDataSource.getMovieCacheData();

      emit(HistorySuccess(movies));
    } catch (e) {
      emit(HistoryFailure(e.toString()));
    }
  }

  Future<void> getHistory() async {
    try {
      emit(HistoryLoading());

      final moviesResponse = await _historyListDataSource.getMovieCacheData();
      emit(HistorySuccess(moviesResponse));
    } catch (e) {
      emit(HistoryFailure(e.toString()));
    }
  }

  Future<void> removeMovie(int movieId) async {
    try {
      await _historyListDataSource.deleteMovieData(movieID: movieId);

      final movies = await _historyListDataSource.getMovieCacheData();

      emit(HistorySuccess(movies));
    } catch (e) {
      emit(HistoryFailure(e.toString()));
    }
  }

  Future<void> clearHistory() async {
    try {
      await _historyListDataSource.clearCache();

      emit(HistorySuccess([]));
    } catch (e) {
      emit(HistoryFailure(e.toString()));
    }
  }
}
