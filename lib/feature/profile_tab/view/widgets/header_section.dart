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
import 'package:movies_app/core/utilities/helper/custom_indecator.dart';
import 'package:movies_app/feature/MovieDetails/view/widgets/movie_details__custom_cast.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';
import '../../../../core/cubit/history_list_cubit/history_list_state.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late Future<UserModel?> _currentUserData;

  @override
  void initState() {
    super.initState();
    _currentUserData =
        context.read<AuthCubit>().getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    final List<ImgProfileModel> imagesProfile =
        ImgProfileModel.avatars;

    final AppLocalizations l10n =
        AppLocalizations.of(context);

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

                if (snap.data == null) {
                  return const CharacterImagePlaceholder();
                }

                final UserModel item = snap.data!;

                return Column(
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    Expanded(
                      flex: 10,
                      child: FittedBox(
                        child: SvgPicture.asset(
                          imagesProfile[item.avatarIndex].imgPath,
                          height: 118,
                          width: 118,
                          fit: .fill,
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: .center,
                        ),
                      ),
                    ),
                  ],
                );
              },
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

                                return Text(
                                  "$count",
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: .center,
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
                                        ? state.movies.length
                                        : 0;

                                return Text(
                                  "$count",
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: .center,
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
  }
}