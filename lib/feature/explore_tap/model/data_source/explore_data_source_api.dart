import 'package:dio/dio.dart';
import 'package:movies_app/core/const.dart';
import 'package:movies_app/core/models/movie_list_model.dart';
import 'package:movies_app/feature/explore_tap/model/data_source/explore_data_source.dart';

class ExploreDataSourceApi extends ExploreDataSource {
  final Dio _dio;
  ExploreDataSourceApi(this._dio);

  @override
  Future<List<MovieListItemModel>> getMoviesByGenre({
    required String genere,
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        AppConstApi.endPointListMovies,
        queryParameters: {"genre": genere, "page": page, 'sort_by': "rating"},
      );
      final exploreTabRespone = MovieListModel.fromJson(response.data);
      if (exploreTabRespone.status != "ok") {
        throw "Failed to get data";
      }
      return exploreTabRespone.data.movies;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }
}

String _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';

    case DioExceptionType.sendTimeout:
      return 'Send timeout';

    case DioExceptionType.receiveTimeout:
      return 'Receive timeout';

    case DioExceptionType.badResponse:
      return 'Server error: ${e.response?.statusCode}';

    case DioExceptionType.connectionError:
      return 'No internet connection';

    case DioExceptionType.cancel:
      return 'Request cancelled';

    default:
      return 'Something went wrong';
  }
}
