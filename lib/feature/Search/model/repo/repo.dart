import 'package:movies_app/feature/Search/model/data_source/search_data_source.dart';

import '../../../../core/models/movie_list_model.dart';

class SearchMovieRepo {
  final SearchDataSource _searchDataSource;
  const SearchMovieRepo({required this._searchDataSource});

  Future<MovieListModel> getMovieFiltered({required String query}) async {
    try {
      final result = await _searchDataSource.getMovieFiltered(query: query);
      if (result == null) {
        throw Exception("No movies are available for this search.");
      }
      return result;
    } catch (error) {
      throw Exception(error);
    }
  }
}
