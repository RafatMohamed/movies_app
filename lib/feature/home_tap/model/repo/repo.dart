import 'package:movies_app/feature/home_tap/model/data_source/movies_data_source.dart';
import 'package:movies_app/feature/home_tap/model/models/movie_respone/movie.dart';

class HomeTapRepo {
  final MoviesDataSource moviesApiDataSource;
  HomeTapRepo({required this.moviesApiDataSource});

  Future<List<Movie>> getMoviesList({required String? page}) async {
    if (page == null) {
      try {
        return await moviesApiDataSource.getMovieFirstList();
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      try {
        return await moviesApiDataSource.getOnPaginationMovieList(page);
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }
}
