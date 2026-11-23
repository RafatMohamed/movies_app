import 'package:movies_app/core/models/movie_history_cach_model.dart';

sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistorySuccess extends HistoryState {
  final List<MovieCacheModel> movies;

  HistorySuccess(this.movies);
}

final class HistoryFailure extends HistoryState {
  final String message;

  HistoryFailure(this.message);
}