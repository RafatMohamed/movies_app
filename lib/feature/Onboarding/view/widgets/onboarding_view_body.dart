import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart'
    show ScreenUtilsContext;
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/feature/Onboarding/model/model_name/onboarding_model.dart';
import 'package:movies_app/feature/Onboarding/view/widgets/custom_back_button.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < onboardingList.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentOnboarding = onboardingList[currentIndex];

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: SizedBox(
              height: context.height / 1.2,
              width: context.width,
              child: Image.asset(currentOnboarding.image, fit: BoxFit.cover),
            ),
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: context.height / 1.2,
            width: context.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  currentOnboarding.appColors.withValues(alpha: 0),
                  currentOnboarding.appColors.withValues(alpha: 0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomSheet(
            enableDrag: false,
            backgroundColor: AppColors.deepBlack,
            constraints: BoxConstraints(maxWidth: context.width),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppBorderRadius.r40),
              ),
            ),
            onClosing: () {},
            builder: (context) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: Column(
                    key: ValueKey(currentIndex),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(AppPadding.p32),

                      Text(
                        currentOnboarding.title,
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),

                      const Gap(AppPadding.p10),
                      if (currentOnboarding.description != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p10,
                          ),
                          child: Text(
                            currentOnboarding.description!,
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),

                      const Gap(AppPadding.p20),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p20,
                        ),
                        child: CustomButtonApp(
                          onTap: nextPage,
                          text: currentIndex == onboardingList.length - 1
                              ? 'Finish'
                              : 'Next',
                        ),
                      ),

                      const Gap(AppPadding.p10),
                      if (currentIndex != 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomBackButton(
                                  ontap: () {
                                    previousPage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Gap(AppPadding.p32),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
