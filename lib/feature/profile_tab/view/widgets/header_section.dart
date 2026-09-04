import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/models/img_profile_model.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});
  @override
  Widget build(BuildContext context) {
    final String imageProfile =ImgProfileModel.avatars.first.imgPath;
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Expanded(
                  flex: 10,
                  child: FittedBox(
                    child: SvgPicture.asset(
                      imageProfile,
                      height: 118,
                      width: 118,
                      fit: .fill,
                    ),
                  ),
                ),
                const Gap(16),
                const Expanded(
                  flex: 3,
                  child: FittedBox(
                    child: Text(
                      'Ahmed elnoby',
                      style: TextStyle(color: AppColors.white),
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
                        const Expanded(
                          flex: 16,
                          child: FittedBox(
                            child: Text(
                              '12',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: .bold,
                              ),
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
                                fontWeight: .bold,
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
                      crossAxisAlignment: .end,
                      children: [
                        const Expanded(
                          flex: 16,
                          child: FittedBox(
                            child: Text(
                              '10',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: .bold,
                              ),
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
                                fontWeight: .bold,
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