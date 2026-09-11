import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/services/watch_list_data_source/watch_list_data_source.dart';

import '../../../feature/MovieDetails/model/model_name/movie_details_model.dart';

class WatchListRemoteDataSourceImpl implements WatchListDataSource {
  late final AuthService _authService;
  WatchListRemoteDataSourceImpl({required this._authService});
  late final CollectionReference<MovieModel> movieCollectionRef =
      FirebaseFirestore.instance
          .collection('users')
          .doc(_authService.currentUser!.uid)
          .collection('watchList')
          .withConverter<MovieModel>(
            fromFirestore: (snapshot, options) {
              return MovieModel.fromJson(snapshot.data()!);
            },
            toFirestore: (movie, options) {
              return movie.toJson();
            },
          );

  @override
  Future<void> setMovieData({required MovieModel movie}) async {
    await movieCollectionRef.doc(movie.id.toString()).set(movie);
  }

  @override
  Future<List<MovieModel>> getMovieData() async {
    var result = await movieCollectionRef.get();
    return result.docs.map((movie) {
      return movie.data();
    }).toList();
  }

  @override
  Future<void> deleteMovieData({required String movieID}) async {
    await movieCollectionRef.doc(movieID).delete();
  }

  @override
  Future<bool> getMovieDataIS({required String movieID}) async {
    final resultMovie = await movieCollectionRef.doc(movieID).get();
    return resultMovie.exists;
  }
}
