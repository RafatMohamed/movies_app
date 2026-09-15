import 'package:dio/dio.dart';
import 'package:movies_app/core/const.dart';
import 'package:movies_app/feature/home_tap/model/data_source/movies_data_source.dart';
import 'package:movies_app/feature/home_tap/model/models/movie_respone/movie.dart';
import 'package:movies_app/feature/home_tap/model/models/movie_respone/movie_respone.dart';

class MoviesDataSourceApi extends MoviesDataSource {
  final Dio _dio;
  MoviesDataSourceApi({required this._dio});
  @override
  Future<List<Movie>> getMovieFirstList() async {
    try {
      final respone = await _dio.get(
        AppConstApi.endPointListMovies,
        queryParameters: {"sort_by": "year", "page": "1"},
      );
      final MovieRespone movieRespone = MovieRespone.fromJson(respone.data);
      if (movieRespone.status != 'ok') {
        throw Exception('Some thing went wrong!');
      }
      if (movieRespone.data == null) {
        throw Exception('Failed to load data');
      }
      return movieRespone.data?.movies ?? [];
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<Movie>> getOnPaginationMovieList(String page) async {
    try {
      final respone = await _dio.get(
        AppConstApi.endPointListMovies,
        queryParameters: {"page": page, "sort_by": "date"},
      );
      final MovieRespone movieRespone = MovieRespone.fromJson(respone.data);
      if (movieRespone.status != 'ok') {
        throw Exception('Some thing went wrong!');
      }
      if (movieRespone.data == null) {
        throw Exception('Failed to load data');
      }
      return movieRespone.data?.movies ?? [];
    } on DioException catch (e) {
      throw handleDioException(e);
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

String handleDioException(DioException e) => _handleDioException(e);
