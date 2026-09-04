import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../core/utilities/app_border_radius.dart';
import '../../../../core/utilities/app_padding.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class CustomTextFieldSearch extends StatefulWidget {
  const CustomTextFieldSearch({
    super.key,
    required this.onSubmitted,
    required this.onClear,
  });
  final Function(String) onSubmitted;
  final Function(void) onClear;
  @override
  State<CustomTextFieldSearch> createState() => _CustomTextFieldSearchState();
}

class _CustomTextFieldSearchState extends State<CustomTextFieldSearch> {
  TextEditingController queryController = TextEditingController();
  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextField(
      style: textTheme.labelSmall,
      enabled: true,
      controller: queryController,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: .text,
      onSubmitted: (query) {
        queryController.text = query;
        widget.onSubmitted(query);
      },
      textInputAction: .search,
      cursorColor: AppColors.gold,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).search,
        hintStyle: textTheme.titleMedium?.copyWith(color: AppColors.white),
        border: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        fillColor: AppColors.deepBlack,
        filled: true,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p16,
        ),
        prefixIcon: SvgPicture.asset(
          AppAssets.searchIcon,
          colorFilter: const ColorFilter.mode(AppColors.white, .srcIn),
          fit: .scaleDown,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.onClear(queryController.clear());
          },
          icon: const Icon(Icons.clear_outlined),
        ),
        suffixIconColor: AppColors.white,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppBorderRadius.r16),
    borderSide: const BorderSide(
      color: AppColors.lightBlack,
    ),
  );
}
