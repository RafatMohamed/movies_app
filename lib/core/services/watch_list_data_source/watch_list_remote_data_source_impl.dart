import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/services/firestore_service.dart';
import 'package:movies_app/core/services/watch_list_data_source/watch_list_data_source.dart';

import '../../../feature/MovieDetails/model/model_name/movie_details_model.dart';

class WatchListRemoteDataSourceImpl implements WatchListDataSource {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  WatchListRemoteDataSourceImpl({
    required this._authService,
    required this._firestoreService,
  });
  CollectionReference<MovieModel> get movieCollectionRef {
    final user = _authService.currentUser;

    if (user == null) {
      throw "No signed-in user";
    }

    return _firestoreService.usersRef
        .doc(user.uid)
        .collection('watchList')
        .withConverter<MovieModel>(
          fromFirestore: (snapshot, options) {
            return MovieModel.fromJson(snapshot.data()!);
          },
          toFirestore: (movie, options) {
            return movie.toJson();
          },
        );
  }

  @override
  Future<void> setMovieData({required MovieModel movie}) async {
    await movieCollectionRef.doc(movie.id.toString()).set(movie);
  }

  @override
  Stream<List<MovieModel>> getMovieData() {
    return movieCollectionRef.snapshots().map((movieSnap) {
      return movieSnap.docs.map((movie) {
        return movie.data();
      }).toList();
    });
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
