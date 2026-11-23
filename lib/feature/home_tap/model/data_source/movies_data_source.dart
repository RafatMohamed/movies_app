import 'package:movies_app/feature/home_tap/model/models/movie_respone/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getMovieFirstList();
  Future<List<Movie>> getOnPaginationMovieList(String page);
}
