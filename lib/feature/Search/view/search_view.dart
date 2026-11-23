import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import 'package:movies_app/feature/Search/view/widgets/custom_text_field.dart';
import 'package:movies_app/feature/Search/view/widgets/search_view_body.dart';
import 'package:movies_app/feature/Search/view_model/movie_search_filter.dart';
import 'package:movies_app/feature/Search/view_model/state_mangment.dart';
import '../../../core/utilities/app_padding.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  void onSubmittedSearch(String query) async {
    context.read<MovieSearchCubit>().getMovieDetails(query: query.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16,
              vertical: AppPadding.p16,
            ),
            child: CustomTextFieldSearch(
              onSubmitted: onSubmittedSearch,
              onClear: (_) {
                context.read<MovieSearchCubit>().onClear();
              },
            ),
          ),
          BlocBuilder<MovieSearchCubit, MovieSearchFilterState>(
            builder: (context, state) {
              if (state is MovieSearchLoadingState) {
                return Expanded(
                  child: GridView.builder(
                    padding: .zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .7,
                          crossAxisSpacing: AppPadding.p20,
                          mainAxisSpacing: AppPadding.p16,
                        ),
                    itemCount: 8,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const MovieCardShimmer();
                    },
                  ),
                );
              }
              if (state is MovieSearchFailerState) {
                return Center(
                  child: Text(
                    state.messageError,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: .center,
                  ),
                );
              }
              if (state is MovieSearchSuccessState) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child:
                        state.movieList.data.movieCount == 0 ||
                            state.movieList.data.movies.isEmpty
                        ? Center(
                            child: Image.asset(
                              AppAssets.emptyMoviesImage,
                              fit: .scaleDown,
                              alignment: .center,
                            ),
                          )
                        : SearchViewBody(movies: state.movieList.data.movies),
                  ),
                );
              }
              return Expanded(
                child: Center(
                  child: Image.asset(
                    AppAssets.emptyMoviesImage,
                    fit: .scaleDown,
                    alignment: .center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
