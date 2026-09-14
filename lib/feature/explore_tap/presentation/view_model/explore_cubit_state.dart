import 'package:movies_app/core/models/movie_list_model.dart';

class ExploreCubitState {}

class InitialExploreState extends ExploreCubitState {}

class LoadingExploreState extends ExploreCubitState {}

class LoadedExploreState extends ExploreCubitState {
  final List<MovieListItemModel> movies;
  LoadedExploreState(this.movies);
}

class ErrorExploreState extends ExploreCubitState {
  final String mgs;
  ErrorExploreState(this.mgs);
}
class ErrorOnPaginationExploreState extends ExploreCubitState {
  final String mgs;
  final List<MovieListItemModel> movies;
  ErrorOnPaginationExploreState(this.mgs,this.movies);
}
class LoadingOnPaginationExploreState extends ExploreCubitState {
  final List<MovieListItemModel> movies;
  LoadingOnPaginationExploreState(this.movies);
}
