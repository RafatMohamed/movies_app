import 'package:movies_app/core/models/movie_list_model.dart';

abstract class SearchDataSource {
  Future<MovieListModel>? getMovieFiltered({required String query});
}
