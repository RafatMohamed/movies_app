import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/helper/custom_error_msg.dart';
import 'package:movies_app/core/utilities/package_utilies/get_it.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import 'package:movies_app/core/widgets/movie_error_card.dart';
import 'package:movies_app/feature/explore_tap/presentation/view_model/explore_cubit.dart';
import 'package:movies_app/feature/explore_tap/presentation/view_model/explore_cubit_state.dart';

class TabViewByGenre extends StatefulWidget {
  final String genere;
  const TabViewByGenre({super.key, required this.genere});

  @override
  State<TabViewByGenre> createState() => _TabViewByGenreState();
}

class _TabViewByGenreState extends State<TabViewByGenre> {
  late ExploreCubit myCubit;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients &&
          _scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 200) {
        myCubit.getOnPagenationListMovies(widget.genere);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        myCubit = getIt<ExploreCubit>()..getFirstListMovies(widget.genere);
        return myCubit;
      },
      child: BlocBuilder<ExploreCubit, ExploreCubitState>(
        builder: (ctx, state) {
          if (state is LoadingExploreState) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: MediaQuery.sizeOf(context).height * .33,
                crossAxisCount: 2,
                crossAxisSpacing: AppPadding.p20,
                mainAxisSpacing: AppPadding.p8,
              ),
              itemBuilder: (_, index) => const MovieCardShimmer(),
            );
          }
          if (state is LoadedExploreState) {
            return GridView.builder(
              controller: _scrollController,
              itemCount: state.movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: MediaQuery.sizeOf(context).height * .33,
                crossAxisCount: 2,
                crossAxisSpacing: AppPadding.p20,
                mainAxisSpacing: AppPadding.p8,
              ),
              itemBuilder: (_, index) => CustomMovieCard(
                movieId: state.movies[index].id,
                pathImage: state.movies[index].largeCoverImage,
                rate: state.movies[index].rating.toString(),
              ),
            );
          }
          if (state is LoadingOnPaginationExploreState) {
            return GridView.builder(
              controller: _scrollController,
              itemCount: state.movies.length + 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: MediaQuery.sizeOf(context).height * .33,
                crossAxisCount: 2,
                crossAxisSpacing: AppPadding.p20,
                mainAxisSpacing: AppPadding.p8,
              ),
              itemBuilder: (_, index) {
                if (index >= state.movies.length) {
                  return const MovieCardShimmer();
                }
                return CustomMovieCard(
                  movieId: state.movies[index].id,

                  pathImage: state.movies[index].largeCoverImage,
                  rate: state.movies[index].rating.toString(),
                );
              },
            );
          }
          if (state is ErrorOnPaginationExploreState) {
            return GridView.builder(
              controller: _scrollController,
              itemCount: state.movies.length + 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: MediaQuery.sizeOf(context).height * .33,
                crossAxisCount: 2,
                crossAxisSpacing: AppPadding.p20,
                mainAxisSpacing: AppPadding.p8,
              ),
              itemBuilder: (_, index) {
                if (index >= state.movies.length) {
                  return MovieErrorCard(errorMessage: state.mgs);
                }
                return CustomMovieCard(
                  movieId: state.movies[index].id,

                  pathImage: state.movies[index].largeCoverImage,
                  rate: state.movies[index].rating.toString(),
                );
              },
            );
          }
          if (state is ErrorExploreState) {
            return CustomErrorBuilder(
              errorMsg: state.mgs,
              onTapAgain: () {
                ctx.read<ExploreCubit>().getFirstListMovies(widget.genere);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
