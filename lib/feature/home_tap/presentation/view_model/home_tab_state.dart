import 'package:movies_app/feature/home_tap/model/models/movie_respone/movie.dart';

class HomeTabState {}

class InitialHomeTab extends HomeTabState {}

class HomeTabLoading extends HomeTabState {}

class HomeTabLoaded extends HomeTabState {
  List<Movie> movies;
  List<Movie> watchingNowMovies;
  HomeTabLoaded({required this.movies, required this.watchingNowMovies});
}

class HomeTabOnScrollLoading extends HomeTabState {
  List<Movie> movies;
  List<Movie> watchingNowMovies;

  HomeTabOnScrollLoading(this.movies, this.watchingNowMovies);
}

class HomeTapWatchingNowLoading extends HomeTabState {
  List<Movie> availableNowMovies;
  List<Movie> watchingNowMovies;
  HomeTapWatchingNowLoading({
    required this.availableNowMovies,
    required this.watchingNowMovies,
  });
}

class HomeTapWatchingLoaded extends HomeTabState {
  List<Movie> movies;
  HomeTapWatchingLoaded(this.movies);
}

class HomeTabEror extends HomeTabState {
  String messege;
  HomeTabEror(this.messege);
}

class HomeTabOnPaginationEror extends HomeTabState {
  String messege;
  List<Movie> homeTabMovies;
  List<Movie> watchNowMovies;

  HomeTabOnPaginationEror({
    required this.messege,
    required this.homeTabMovies,
    required this.watchNowMovies,
  });
}

class SeeMorePressed extends HomeTabState {
  String currentGenere;
  SeeMorePressed(this.currentGenere);
}
