import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/watch_list_cubit/watch_list_cubit/watch_list_cubit.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/helper/custom_error_msg.dart';
import 'package:movies_app/core/utilities/helper/custom_indecator.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class WatchListSection extends StatelessWidget {
  const WatchListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepBlack,
      child: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          if (state is WatchListLoading) {
            return const CustomIndicator();
          }
          if (state is WatchListFailed) {
            return CustomErrorBuilder(
              errorMsg: state.errorMessage,
              onTapAgain: () =>
                  context.read<WatchListCubit>().getMovieWatchList(),
            );
          }
          if (state is WatchListSuccess) {
            return state.movies.isEmpty
                ? Center(child: Image.asset(AppAssets.emptyMoviesImage))
                : GridView.builder(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: MediaQuery.sizeOf(context).height * .3,
                    ),
                    itemCount: state.movies.length,
                    itemBuilder: (_, index) {
                      final item = state.movies[index];
                      return CustomMovieCard(
                        refresh: () {
                          context.read<WatchListCubit>().getMovieWatchList();
                        },
                        pathImage: item.largeCoverImage,
                        rate: item.rating.toString(),
                        movieId: item.id,
                      );
                    },
                  );
          }
          return Center(child: Image.asset(AppAssets.emptyMoviesImage));
        },
      ),
    );
  }
}
