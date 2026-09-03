import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';

/// Reusable English/Arabic toggle used on both Login and Register screens.
class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              if (isArabic) setState(() => isArabic = false);
            },
          ),
          _flagCircle(
            AppAssets.arabicIcon,
            selected: isArabic,
            onTap: () {
              if (!isArabic) setState(() => isArabic = true);
            },
          ),
        ],
      ),
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