import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_text.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/feature/Onboarding/model/model_name/onboarding_model.dart';
import 'package:movies_app/feature/Onboarding/view/widgets/poster_column.dart';

class StartingViewBody extends StatefulWidget {
  const StartingViewBody({super.key});

  @override
  State<StartingViewBody> createState() => _StartingViewBodyState();
}

class _StartingViewBodyState extends State<StartingViewBody>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  static const double imageHeight = 180;
  static const double imageSpacing = 10;

  double listHeight = collection.length * (imageHeight + imageSpacing);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 250),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -200,
          right: -100,
          bottom: 180,
          child: Transform.rotate(
            angle: -0.45,
            child: Row(
              children: [
                PosterColumn(
                  controller: _controller,
                  startIndex: 0,
                  moveUp: false,
                  listHeight: listHeight,
                ),
                const Gap(AppPadding.p10),
                PosterColumn(
                  controller: _controller,
                  startIndex: 7,
                  moveUp: true,
                  listHeight: listHeight,
                ),
                const Gap(AppPadding.p10),
                PosterColumn(
                  controller: _controller,
                  startIndex: 14,
                  moveUp: false,
                  listHeight: listHeight,
                ),
                const Gap(AppPadding.p10),
                PosterColumn(
                  controller: _controller,
                  startIndex: 21,
                  moveUp: true,
                  listHeight: listHeight,
                ),
                const Gap(AppPadding.p10),
                PosterColumn(
                  controller: _controller,
                  startIndex: 28,
                  moveUp: false,
                  listHeight: listHeight,
                ),
                const Gap(AppPadding.p10),
                PosterColumn(
                  controller: _controller,
                  startIndex: 0,
                  moveUp: true,
                  listHeight: listHeight,
                ),
              ],
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.deepBlack.withValues(alpha: 0.1),
                  AppColors.deepBlack.withValues(alpha: 0.8),
                  AppColors.deepBlack,
                ],
                stops: const [0.0, 0.5, 0.85],
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppText.startingPageTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Gap(AppPadding.p16),
                    Text(
                      AppText.startingPageDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Gap(AppPadding.p32),
                    CustomButtonApp(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppOnRouteText.onBoardingName,
                        );
                      },
                      text: 'Explore Now',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
