import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_locale_controller.dart';


class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocaleController.instance,
      builder: (context, locale, _) {
        final bool isArabic = locale.languageCode == 'ar';
        return Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.r24),
            border: Border.all(color: AppColors.gold, width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _flagCircle(
                AppAssets.englishIcon,
                selected: !isArabic,
                onTap: () =>
                    AppLocaleController.instance.changeLocale(AppLocaleController.english),
              ),
              _flagCircle(
                AppAssets.arabicIcon,
                selected: isArabic,
                onTap: () =>
                    AppLocaleController.instance.changeLocale(AppLocaleController.arabic),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _flagCircle(
    String iconPath, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.gold : Colors.transparent,
        ),
        padding: EdgeInsets.all(selected ? 5 : 3),
        child: ClipOval(
          child: SvgPicture.asset(iconPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}