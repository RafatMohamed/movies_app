import 'package:movies_app/core/models/movie_list_model.dart';

abstract class ExploreDataSource {
  Future<List<MovieListItemModel>> getMoviesByGenre({
    required String genere,
    required int page,
  });
}
