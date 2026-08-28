import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:svg_flutter/svg.dart';

class CustomMovieDetailsInfoPopular extends StatelessWidget {
  const CustomMovieDetailsInfoPopular({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryInfoModelPopular> itemList = [
      const CategoryInfoModelPopular(pathIcon: AppAssets.favIcon, text: "24"),
      const CategoryInfoModelPopular(pathIcon: AppAssets.watchIcon, text: "90"),
      const CategoryInfoModelPopular(pathIcon: AppAssets.starIcon, text: "3"),
    ];
    return Row(
      spacing: AppPadding.p10,
      children: List.generate(3, (index) {
        return DefaultInfoDetails(item: itemList[index]);
      }),
    );
  }
}

class DefaultInfoDetails extends StatelessWidget {
  const DefaultInfoDetails({super.key, required this.item});
  final CategoryInfoModelPopular item;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppPadding.p8
        ),
        decoration: BoxDecoration(
          color: AppColors.lightBlack,
          borderRadius: BorderRadius.circular(AppBorderRadius.r16),
        ),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            SvgPicture.asset(
              item.pathIcon,
              colorFilter: const ColorFilter.mode(AppColors.gold, .srcIn),
              fit: .scaleDown,
              width: 24,
              height: 24,
            ),
            Text(item.text, style: textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class CategoryInfoModelPopular {
  final String pathIcon;
  final String text;
  const CategoryInfoModelPopular({required this.pathIcon, required this.text});
}
