import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';

class CustomMovieDetailsCast extends StatelessWidget {
  const CustomMovieDetailsCast({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text("Cast", style: textTheme.labelMedium),
        ...List.generate(4, (index) {
          return const DefaultBuildCardCast(
            pathImageCast:"https://tse1.mm.bing.net/th/id/OIP.Xs5UDI5P5SteWK_qybY7vwHaFk?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
            nameCast: " Hayley Atwell",
            characterCast: "Wanda Maximoff / The Scarlet Witch",
          );
        }),
      ],
    );
  }
}

class DefaultBuildCardCast extends StatelessWidget {
  const DefaultBuildCardCast({
    super.key,
    required this.pathImageCast,
    required this.nameCast,
    required this.characterCast,
  });
  final String pathImageCast;
  final String nameCast;
  final String characterCast;
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      clipBehavior: .antiAlias,
      width: width,
      padding: const EdgeInsetsDirectional.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(AppBorderRadius.r16),
      ),
      child: Row(
        mainAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(AppBorderRadius.r12),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: pathImageCast,
              fit: .fill,
              width: width * 0.2,
              height: height * 0.1,
              errorWidget: (_, _, _) {
                return const Placeholder();
              },
              progressIndicatorBuilder: (_, _, _) {
                return const CircularProgressIndicator();
              },
            ),
          ),
          const Gap(AppPadding.p10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Name : $nameCast",
                  style: textTheme.labelSmall,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
                const Gap(AppPadding.p8),
                Text(
                  "Character : $characterCast",
                  style: textTheme.labelSmall,
                  maxLines: 2,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
