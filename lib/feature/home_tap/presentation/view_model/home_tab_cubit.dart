import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/feature/home_tap/model/models/movie_respone/movie.dart';
import 'package:movies_app/feature/home_tap/model/repo/repo.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  List<Movie> movies = [];
  HomeTapRepo repo;
  HomeTabCubit(this.repo) : super(InitialHomeTab());

  int currentGenereIndex = 0;

  List<String> myGenereList = [];
  int page = 2;
  bool hasMore = true;
  bool isPaginationLoading = false;

  void getMoviesFirstPage() async {
    if (!hasMore) return;
    try {
      emit(HomeTabLoading());
      movies = await repo.getMoviesList(page: null);
      if (isClosed) return;
      myGenereList = _filterGenersFromMovieList(movies);
      if (movies.isEmpty) hasMore = false;
      emit(
        HomeTabLoaded(movies: movies, watchingNowMovies: filterMovieByGenre()),
      );
    } catch (e) {
      if (isClosed) return;
      emit(HomeTabEror(e.toString()));
    }
  }

  // void getMoviesOnPagination() async {
  //   if (!hasMore || isClosed || isPaginationLoading) return;
  //   isPaginationLoading = true;
  //   try {
  //     if (isClosed) return;
  //     emit(HomeTabOnScrollLoading(movies, filterMovieByGenre()));

  //     final newMovies = await repo.getMoviesList(page: page.toString());

  //     if (isClosed) return;

  //     if (newMovies.isEmpty) {
  //       hasMore = false;
  //       emit(
  //         HomeTabLoaded(
  //           movies: movies,
  //           watchingNowMovies: filterMovieByGenre(),
  //         ),
  //       );
  //       isPaginationLoading = false;
  //       return;
  //     }
  //     movies.addAll(newMovies);
  //     myGenereList = _filterGenersFromMovieList(movies);
  //     page++;
  //     emit(
  //       HomeTabLoaded(movies: movies, watchingNowMovies: filterMovieByGenre()),
  //     );
  //     isPaginationLoading = false;
  //   } catch (e) {
  //     if (isClosed) return;
  //     emit(
  //       HomeTabOnPaginationEror(
  //         messege: e.toString(),
  //         homeTabMovies: movies,
  //         watchNowMovies: movies,
  //       ),
  //     );
  //     isPaginationLoading = false;
  //   }
  // }

  List<String> _filterGenersFromMovieList(List<Movie> movies) {
    Set<String> generesSet = {};
    if (movies.isNotEmpty) {
      for (var movie in movies) {
        if (movie.genres == null || movie.genres!.isEmpty) {
          continue;
        } else {
          for (var genere in movie.genres!) {
            generesSet.add(genere);
          }
        }
      }
      return generesSet.toList();
    }
    return [];
  }

  String get currentGenreName {
    if (myGenereList.isNotEmpty &&
        currentGenereIndex >= 0 &&
        currentGenereIndex < myGenereList.length) {
      return myGenereList[currentGenereIndex];
    }
    return '';
  }

  void filterMovieByGenreOnNavigation() {
    if (movies.isNotEmpty && currentGenreName.isNotEmpty) {
      final filteredMovies = movies
          .where(
            (movie) =>
                movie.genres?.contains(currentGenreName) ??
                false,
          )
          .toList();
      if (isClosed) return;
      emit(HomeTabLoaded(movies: movies, watchingNowMovies: filteredMovies));
    }
  }

  List<Movie> filterMovieByGenre() {
    if (movies.isNotEmpty && currentGenreName.isNotEmpty) {
      final filteredMovies = movies
          .where(
            (movie) =>
                movie.genres?.contains(currentGenreName) ??
                false,
          )
          .toList();
      return filteredMovies;
    }
    return [];
  }

  void increaseCurrentIndexOFGenere() {
    if (myGenereList.isEmpty) return;
    if (currentGenereIndex >= myGenereList.length - 1) {
      currentGenereIndex = 0;
    } else {
      currentGenereIndex++;
    }
  }

  void seeMoreClicked() {
    if (currentGenreName.isNotEmpty) {
      emit(SeeMorePressed(currentGenreName));
    }
  }
}
