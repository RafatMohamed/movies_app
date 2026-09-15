import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/cubit/history_list_cubit/history_list_cubit.dart';
import 'package:movies_app/core/cubit/watch_list_cubit/watch_list_cubit/watch_list_cubit.dart';
import 'package:movies_app/core/models/img_profile_model.dart';
import 'package:movies_app/core/models/user_model.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/auth/auth_cubit.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';
import '../../../../core/cubit/history_list_cubit/history_list_state.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final authCubit = context.read<AuthCubit>();

    return StreamBuilder<UserModel?>(
      stream: authCubit.watchCurrentUserData(),
      builder: (context, snapshot) {
        final UserModel? user = snapshot.data;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
      ),
      child: Row(
        children: [

          Expanded(
            flex: 8,
            child: StreamBuilder<UserModel?>(
              stream: context.read<AuthCubit>().watchCurrentUserData(),
              builder: (context, snap) {
                if (snap.connectionState == .waiting) {
                  return const CustomIndicator();
                }
        final avatars = ImgProfileModel.avatars;

        final int avatarIndex = (user?.avatarIndex ?? 0).clamp(
          0,
          avatars.length - 1,
        );

        final String imageProfile = avatars[avatarIndex].imgPath;
        final String name = user?.name ?? '';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            children: [
              // Profile
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 10,
                      child: FittedBox(
                        child: SvgPicture.asset(
                          imageProfile,
                          height: 118,
                          width: 118,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

          Expanded(
            flex: 14,
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Row(
                children: [

                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          flex: 16,
                          child: FittedBox(
                            child: BlocBuilder<
                                WatchListCubit,
                                WatchListState>(
                              builder: (context, state) {
                                final count =
                                    state is WatchListSuccess
                                        ? state.movies.length
                                        : 0;
              // WatchList & History
              Expanded(
                flex: 14,
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Row(
                    children: [
                      // WatchList
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 16,
                              child: FittedBox(
                                child:
                                    BlocBuilder<WatchListCubit, WatchListState>(
                                      builder: (context, state) {
                                        final count = state is WatchListSuccess
                                            ? state.movies.length
                                            : 0;

                                        return Text(
                                          "$count",
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      },
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: FittedBox(
                                child: Text(
                                  l10n.watchList,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          flex: 16,
                          child: FittedBox(
                            child: BlocBuilder<
                                HistoryCubit,
                                HistoryState>(
                              builder: (context, state) {
                                final count =
                                    state is HistorySuccess
                      // History
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 16,
                              child: FittedBox(
                                child: BlocBuilder<HistoryCubit, HistoryState>(
                                  builder: (context, state) {
                                    final count = state is HistorySuccess
                                        ? state.movies.length
                                        : 0;

                                    return Text(
                                      "$count",
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: FittedBox(
                                child: Text(
                                  l10n.history,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
