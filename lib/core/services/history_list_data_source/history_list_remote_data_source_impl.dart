import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/const.dart';
import '../../models/movie_history_cach_model.dart';
import 'history_list_data_source.dart';

class HistoryListRemoteDataSourceImpl implements HistoryListDataSource {
  const HistoryListRemoteDataSourceImpl({required this._historyBox});

  final Box<MovieCacheModel> _historyBox;
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieCacheModelAdapter());
    await Hive.openBox<MovieCacheModel>(AppConstChach.historyBox);
  }

  @override
  Future<void> cacheMovieData({required MovieCacheModel movie}) async {
    try {
      await _historyBox.put(movie.id, movie);
    } catch (error) {
      throw "something went wrong when cache Movie";
    }
  }

  @override
  Future<void> clearCache() async {
    await _historyBox.clear();
  }

  @override
  Future<void> deleteMovieData({required int movieID}) async {
    try {
      await _historyBox.delete(movieID);
    } catch (error) {
      throw "something went wrong when delete Movie cache";
    }
  }

  @override
  Future<List<MovieCacheModel>> getMovieCacheData() async {
    try {
      final response = _historyBox.values.toList();
      response.sort((a, b) {
        return b.openAt.compareTo(a.openAt);
      });
      return response;
    } catch (error) {
      throw "something went wrong when get Movie cache";
    }
  }
}
