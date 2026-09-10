import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../feature/MovieDetails/model/model_name/movie_details_model.dart';

abstract class WatchListDataSource {
  Future<void> setMovieData({required MovieModel movie});
  Future<List<MovieModel>> getMovieData();
  Future<void> deleteMovieData({required String movieID});
  Future<bool> getMovieDataIS({required String movieID});
}