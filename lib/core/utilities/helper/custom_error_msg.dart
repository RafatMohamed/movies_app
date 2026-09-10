import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../feature/MovieDetails/model/model_name/movie_suggestion_model.dart';
import '../../../feature/MovieDetails/model/model_name/parental_guide_model.dart';
import '../app_border_radius.dart';
import '../app_colors.dart';
import '../app_padding.dart';

class CustomErrorBuilder extends StatelessWidget {
  const CustomErrorBuilder({
    super.key,
    required this.errorMsg,
    required this.onTapAgain
  });

  final String errorMsg;
  final Function() onTapAgain;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        children: [
          Text(
            errorMsg,
            style: textTheme.labelSmall,
            textAlign: .center,
          ),
          const Gap(20),
          ElevatedButton(
            onPressed:onTapAgain,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(AppBorderRadius.r16)
                ),
                backgroundColor: AppColors.gold
            ),
            child: Text(
              "try again",
              style: textTheme.labelSmall?.copyWith(
                  color: AppColors.caviar
              ),
              textAlign: .center,
            ),
          ),
        ],
      ),
    );
  }
}
