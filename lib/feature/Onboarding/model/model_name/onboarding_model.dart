import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_text.dart';

class Onboarding {
  String title;
  String? description;
  String image;
  Color appColors;
  Onboarding({
    required this.title,
    this.description,
    required this.image,
    required this.appColors,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
    title: AppText.onboardingPageTitle1,
    description: AppText.onboardingPageDescription1,
    image: AppAssets.onboarding1,
    appColors: AppColors.deepSeaBlue,
  ),
  Onboarding(
    title: AppText.onboardingPageTitle2,
    description: AppText.onboardingPageDescription2,
    image: AppAssets.onboarding2,
    appColors: AppColors.maroon,
  ),
  Onboarding(
    title: AppText.onboardingPageTitle3,
    description: AppText.onboardingPageDescription3,
    image: AppAssets.onboarding3,
    appColors: AppColors.imperialPurple,
  ),
  Onboarding(
    title: AppText.onboardingPageTitle4,
    description: AppText.onboardingPageDescription4,
    image: AppAssets.onboarding4,
    appColors: AppColors.burgundy,
  ),
  Onboarding(
    title: AppText.onboardingPageTitle5,
    // description: '',
    image: AppAssets.onboarding5,
    appColors: AppColors.caviar,
  ),
];

List<String> collection = [
  AppAssets.collectionPic1,
  AppAssets.collectionPic2,
  AppAssets.collectionPic3,
  AppAssets.collectionPic4,
  AppAssets.collectionPic5,
  AppAssets.collectionPic6,
  AppAssets.collectionPic7,
  AppAssets.collectionPic8,
  AppAssets.collectionPic9,
  AppAssets.collectionPic10,
  AppAssets.collectionPic11,
  AppAssets.collectionPic12,
  AppAssets.collectionPic13,
  AppAssets.collectionPic14,
  AppAssets.collectionPic15,
  AppAssets.collectionPic16,
  AppAssets.collectionPic17,
  AppAssets.collectionPic18,
  AppAssets.collectionPic19,
  AppAssets.collectionPic20,
  AppAssets.collectionPic21,
  AppAssets.collectionPic22,
  AppAssets.collectionPic23,
  AppAssets.collectionPic24,
  AppAssets.collectionPic25,
  AppAssets.collectionPic26,
  AppAssets.collectionPic27,
  AppAssets.collectionPic28,
];
