import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import '../utilities/app_assets.dart';
import '../utilities/app_border_radius.dart';
import '../utilities/app_padding.dart';
import '../utilities/app_them.dart';

class CustomMovieCard extends StatelessWidget {
  const CustomMovieCard({
    super.key,
    required this.pathImage,
    required this.rate,
  });
  final String pathImage;
  final String rate;
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        // Handle card tap
      },
      child: Stack(
        alignment: .topStart,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(AppBorderRadius.r16),
            child: Image.asset(pathImage, fit: .fill, width: width),
          ),
          Positioned.directional(
            textDirection: .ltr,
            start: AppPadding.p8,
            top: AppPadding.p8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppBorderRadius.r8),
                color: AppColors.deepBlack.withValues(alpha: 0.7),
              ),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p4,
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Text(
                    rate,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: .w400,
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(AppPadding.p8),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    colorFilter: const ColorFilter.mode(AppColors.gold, .srcIn),
                    fit: .scaleDown,
                    width: 16,
                    height: 16,
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
