import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/history_list_cubit/history_list_cubit.dart';
import 'package:movies_app/core/cubit/history_list_cubit/history_list_state.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import '../../../../core/utilities/helper/custom_error_msg.dart';
import '../../../../core/utilities/helper/custom_indecator.dart';

class HistoryListSection extends StatelessWidget {
  const HistoryListSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepBlack,
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const CustomIndicator();
          }
          if (state is HistoryFailure) {
            return CustomErrorBuilder(
              errorMsg: state.message,
              onTapAgain: () => context.read<HistoryCubit>().getHistory(),
            );
          }
          if (state is HistorySuccess) {
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
                    itemCount: state.movies.length<20?state.movies.length:20,
                    itemBuilder: (_, index) {
                      final item = state.movies[index];
                      return CustomMovieCard(
                        pathImage: item.image,
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
