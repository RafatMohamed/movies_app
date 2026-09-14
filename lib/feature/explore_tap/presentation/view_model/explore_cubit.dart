import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/models/movie_list_model.dart';
import 'package:movies_app/feature/explore_tap/model/repo/explore_repo.dart';
import 'package:movies_app/feature/explore_tap/presentation/view_model/explore_cubit_state.dart';

class ExploreCubit extends Cubit<ExploreCubitState> {
  final ExploreRepo _repo;

  ExploreCubit(this._repo) : super(InitialExploreState());
  List<MovieListItemModel> moviesList = [];
  int page = 1;
  bool pageniationLoading = false;
  bool hasMore = true;
  void getFirstListMovies(String genere) async {
    page = 1;
    try {
      emit(LoadingExploreState());
      final movies = await _repo.getMovies(genere: genere, page: page);
      if (movies.isEmpty) {
        hasMore = false;
        if (isClosed) return;
        emit(ErrorExploreState("No data to dislay"));
        return;
      }
      if (isClosed) return;
      moviesList = movies;
      emit(LoadedExploreState(movies));
      page++;
    } catch (e) {
      if (isClosed) return;
      emit(ErrorExploreState(e.toString()));
    }
  }

  void getOnPagenationListMovies(String genere) async {
    if (pageniationLoading || !hasMore) return;
    pageniationLoading = true;
    try {
      emit(LoadingOnPaginationExploreState(moviesList));
      final movies = await _repo.getMovies(genere: genere, page: page);
      if (movies.isEmpty) {
        hasMore = false;
        if (isClosed) {
          pageniationLoading = false;
          return;
        }
        emit(ErrorOnPaginationExploreState("No data to dislay", moviesList));
        pageniationLoading = false;
        return;
      }
      if (isClosed) {
        pageniationLoading = false;
        return;
      }
      moviesList.addAll(movies);
      emit(LoadedExploreState(moviesList));
      pageniationLoading = false;
      page++;
    } catch (e) {
      pageniationLoading = false;
      if (isClosed) {
        pageniationLoading = false;
        return;
      }
      emit(ErrorOnPaginationExploreState(e.toString(), moviesList));
    }
  }
}
