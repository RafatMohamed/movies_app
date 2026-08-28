import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';

class CustomMovieDetailsScreenShot extends StatelessWidget {
  const CustomMovieDetailsScreenShot({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text("Screen Shots",style: textTheme.labelMedium,),
        ...List.generate(3, (index) {
          return const DefaultScreenShotImage();
        })
      ],
    );
  }
}

class DefaultScreenShotImage extends StatelessWidget {
  const DefaultScreenShotImage({super.key,});
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Container(
      width: width,
      height: height*0.2,
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(AppBorderRadius.r16),
        image: const DecorationImage(
          image: AssetImage("assets/images/png/onBoarding1.png"),
          fit: .fill,
        ),
      ),
    );
  }
}
