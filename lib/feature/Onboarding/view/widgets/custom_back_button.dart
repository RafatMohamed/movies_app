import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, required this.ontap});
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        ontap();
      },
      style: ButtonStyle(
        side: const WidgetStatePropertyAll(
          BorderSide(color: AppColors.gold, width: 1.5),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.r16),
          ),
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(AppPadding.p16)),
      ),
      child: Text('Back', style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.gold
      )),
    );
  }
}
