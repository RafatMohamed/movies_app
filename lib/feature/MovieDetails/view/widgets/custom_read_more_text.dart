import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:readmore_flutter/readmore_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

import '../../../../core/utilities/app_locale_controller.dart';

class CustomReadMoreTextTranslate extends StatelessWidget {
  const CustomReadMoreTextTranslate({super.key, required this.text});
  final String text;
  Future<String> getTextTr(String text) async {
    final result = await GoogleTranslator().translate(
      text,
      from: 'en',
      to: 'ar',
    );

    return result.text;
  }

  @override
  Widget build(BuildContext context) {
    final bool isAr = AppLocaleController.instance.value.languageCode == "ar";
    final TextTheme textTheme = Theme.of(context).textTheme;
    return !isAr || getTextTr(text).toString().isEmpty
        ? CustomReamMoreText(text: text, textTheme: textTheme)
        : FutureBuilder(
            future: getTextTr(text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == .waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade800,
                  highlightColor: Colors.grey.shade700,
                  child: Container(
                    width: double.infinity,
                    height: context.height*0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppBorderRadius.r8),
                    ),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return  const SizedBox();
              }
              return CustomReamMoreText(
                text: snapshot.data ?? text,
                textTheme: textTheme,
              );
            },
          );
  }
}

class CustomReamMoreText extends StatelessWidget {
  const CustomReamMoreText({
    super.key,
    required this.text,
    required this.textTheme,
  });

  final String text;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return ReadMore(
      text,
      style: textTheme.titleLarge?.copyWith(
        color: AppColors.white,
        fontWeight: .w400,
      ),
      textAlign: .start,
      minLines: 3,
      readMoreIconVisible: false,
      readMoreText:l10n.read_more,
      readLessText: l10n.read_less,
      iconSize: 16,
      readMoreStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.white.withValues(alpha: 0.8),
      ),
    );
  }
}
