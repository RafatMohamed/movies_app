import 'package:hive_flutter/hive_flutter.dart';
import '../../models/movie_history_cach_model.dart';
import '../../utilities/package_utilies/get_it.dart';
import '../auth_service.dart';
import 'history_list_data_source.dart';

class HistoryListRemoteDataSourceImpl implements HistoryListDataSource {


  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieCacheModelAdapter());
  }

  static String? _getUId() {
    return getIt<AuthService>().currentUser?.uid;
  }

  static Future<Box<MovieCacheModel>> getOpenBox() async {
    final String? uid = _getUId();
    if (uid == null) {
      throw "Not user Register";
    }
    final bool isOpen = Hive.isBoxOpen("history$uid");
    if (isOpen) {
      return Hive.box<MovieCacheModel>("history$uid");
    } else {
      return Hive.openBox<MovieCacheModel>("history$uid");
    }
  }

  @override
  Future<void> cacheMovieData({required MovieCacheModel movie}) async {
    try {
      Box<MovieCacheModel> historyBox =await getOpenBox();
      await historyBox.put(movie.id, movie);
    } catch (error) {
      throw "something went wrong when cache Movie";
    }
  }

  @override
  Future<void> clearCache() async {
    Box<MovieCacheModel> historyBox =await getOpenBox();
    await historyBox.clear();
  }

  @override
  Future<void> deleteMovieData({required int movieID}) async {
    try {
      Box<MovieCacheModel> historyBox =await getOpenBox();
      await historyBox.delete(movieID);
    } catch (error) {
      throw "something went wrong when delete Movie cache";
    }
  }

  @override
  Future<List<MovieCacheModel>> getMovieCacheData() async {
    try {
      Box<MovieCacheModel> historyBox =await getOpenBox();
      final response = historyBox.values.toList();
      response.sort((a, b) {
        return b.openAt.compareTo(a.openAt);
      });
      return response;
    } catch (error) {
      throw "something went wrong when get Movie cache";
    }
  }
}
