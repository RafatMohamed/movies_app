part of 'watch_list_cubit.dart';

@immutable
sealed class WatchListState {}

final class WatchListInitial extends WatchListState {}
final class WatchListLoading extends WatchListState {}
final class WatchListSuccess extends WatchListState {
  final List<MovieModel> movies;
  WatchListSuccess({required this.movies});
}
final class WatchListFailed extends WatchListState {
  final String errorMessage;
  WatchListFailed({required this.errorMessage});
}

final class MovieToggleFailed extends WatchListState {
  final String errorMessage;
  MovieToggleFailed({required this.errorMessage});
}

class WatchListStatusChanged extends WatchListState {
  final bool isInWatched;

  WatchListStatusChanged({
    required this.isInWatched,
  });
}
