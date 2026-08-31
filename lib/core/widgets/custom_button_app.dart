import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:svg_flutter/svg.dart';
import '../utilities/app_border_radius.dart';
import '../utilities/app_padding.dart';

class CustomButtonApp extends StatelessWidget {
  const CustomButtonApp({
    super.key,
    required this.onTap,
    required this.text,
    this.withIcon = false,
    this.icon,
    this.background = AppColors.gold,
    this.textStyle,
  });
  final VoidCallback onTap;
  final String text;
  final bool withIcon;
  final Widget? icon;
  final Color? background;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    final ThemeData them = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: .center,
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(AppPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(AppBorderRadius.r16),
          color: background,
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Text(text, style: textStyle ?? them.textTheme.titleLarge),
            if (withIcon) SvgPicture.asset(AppAssets.exitIconSvg),
          ],
        ),
      ),
    );
  }
}
