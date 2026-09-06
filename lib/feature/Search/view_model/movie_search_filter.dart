import 'package:movies_app/core/models/movie_list_model.dart';

class MovieSearchFilterState {}

class MovieSearchInitState extends MovieSearchFilterState{}

class MovieSearchLoadingState extends MovieSearchFilterState{}

class MovieSearchSuccessState extends MovieSearchFilterState{
  final MovieListModel movieList;
  MovieSearchSuccessState({required this.movieList,});
}

class MovieSearchFailerState extends MovieSearchFilterState{
  final String messageError;
  MovieSearchFailerState({required this.messageError});
}