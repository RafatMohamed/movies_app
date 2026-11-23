import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:movies_app/core/utilities/helper/custom_indecator.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../model/model_name/movie_details_model.dart';

class CustomMovieDetailsCast extends StatelessWidget {
  const CustomMovieDetailsCast({super.key, required this.cast});
  final List<CastModel> cast;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Visibility(
      visible: cast.isNotEmpty,
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppPadding.p10,
        children: [
          Text(AppLocalizations.of(context).cast, style: textTheme.labelMedium),
          ...List.generate(cast.length, (index) {
            final itemCast = cast[index];
            return DefaultBuildCardCast(
              pathImageCast: itemCast.urlSmallImage,
              nameCast: itemCast.name.isNotEmpty?itemCast.name:"Unknow",
              characterCast:itemCast.characterName.isNotEmpty?itemCast.characterName:"Unknow",
            );
          }),
        ],
      ),
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
                return const CharacterImagePlaceholder();
              },
              progressIndicatorBuilder: (_, _, _) {
                return const CustomIndicator();
              },
            ),
          ),
          const Gap(AppPadding.p10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "${AppLocalizations.of(context).nameHint} : $nameCast",
                  style: textTheme.labelSmall,
                  maxLines: 1,
                  overflow: .ellipsis,
                  textAlign: .start,
                ),
                const Gap(AppPadding.p8),
                Text(
                  "${AppLocalizations.of(context).character} : $characterCast",
                  style: textTheme.labelSmall,
                  maxLines: 2,
                  overflow: .ellipsis,
                  textAlign: .start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterImagePlaceholder extends StatefulWidget {
  const CharacterImagePlaceholder({super.key});

  @override
  State<CharacterImagePlaceholder> createState() =>
      _CharacterImagePlaceholderState();
}

class _CharacterImagePlaceholderState
    extends State<CharacterImagePlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF202020),
      child: Center(
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0.45,
            end: 1,
          ).animate(_controller),
          child: const Icon(
            Icons.person_outline_rounded,
            size: 45,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}