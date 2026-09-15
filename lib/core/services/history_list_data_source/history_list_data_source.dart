import 'package:movies_app/core/models/movie_history_cach_model.dart';

abstract class HistoryListDataSource {
  Future<void> cacheMovieData({required MovieCacheModel movie});
  Future<List<MovieCacheModel>> getMovieCacheData();
  Future<void> deleteMovieData({required int movieID});
  Future<void> clearCache();
}
