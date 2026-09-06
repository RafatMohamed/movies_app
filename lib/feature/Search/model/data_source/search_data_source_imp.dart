import 'package:dio/dio.dart';
import 'package:movies_app/core/models/movie_list_model.dart';
import 'package:movies_app/feature/Search/model/data_source/search_data_source.dart';

import '../../../../core/const.dart';

 class SearchDataSourceImp implements SearchDataSource {
  final Dio _dio;
 const SearchDataSourceImp({required this._dio});

  @override
  Future<MovieListModel>? getMovieFiltered({required String query})async{
   try {
    final movieFilteredResponse = await _dio.get(
     AppConstApi.endPointListMovies,
     queryParameters: {
      "query_term": query,
     },
    );
    final MovieListModel movieList = MovieListModel.fromJson(movieFilteredResponse.data);
    if(movieList.status!= "ok"){
     throw Exception("something Went Wrong");
    }
    return movieList;
   }on DioException catch(_) {
    rethrow;
   }
  }
}