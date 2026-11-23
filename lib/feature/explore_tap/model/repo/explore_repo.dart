import 'package:movies_app/core/models/movie_list_model.dart';
import 'package:movies_app/feature/explore_tap/model/data_source/explore_data_source.dart';

class ExploreRepo {
  final ExploreDataSource _dataSource;
  ExploreRepo(this._dataSource);

  Future<List<MovieListItemModel>> getMovies({
    required String genere,
    required int page,
  }) async {
    try {
      return await _dataSource.getMoviesByGenre(genere: genere, page: page);
    } catch (e) {
      rethrow;
    }
  }
}
