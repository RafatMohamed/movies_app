import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/feature/Onboarding/model/model_name/onboarding_model.dart';

class PosterImages extends StatelessWidget {
  final int startIndex;

  const PosterImages({super.key, required this.startIndex});

  static const double imageHeight = 180;
  static const double imageSpacing = 10;

  double get contentHeight => collection.length * (imageHeight + imageSpacing);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: contentHeight,
      width: double.infinity,
      child: Column(
        children: List.generate(collection.length, (index) {
          final int imageIndex = (index + startIndex) % collection.length;
          return Padding(
            padding: const EdgeInsets.only(bottom: imageSpacing),
            child: SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                child: Image.asset(collection[imageIndex], fit: BoxFit.cover),
              ),
            ),
          );
        }),
      ),
    );
  }
}
