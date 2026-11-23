import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:readmore_flutter/readmore_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

import '../../../../core/utilities/app_locale_controller.dart';

class CustomReadMoreTextTranslate extends StatefulWidget {
  const CustomReadMoreTextTranslate({super.key, required this.text});
  final String text;

  @override
  State<CustomReadMoreTextTranslate> createState() =>
      _CustomReadMoreTextTranslateState();
}

class _CustomReadMoreTextTranslateState
    extends State<CustomReadMoreTextTranslate> {
  late final Future<String> _translationFuture;
  final bool _isAr = AppLocaleController.instance.value.languageCode == 'ar';

  @override
  void initState() {
    super.initState();
    // Only kick off the translation when the locale is Arabic
    _translationFuture = _isAr ? _getTextTr(widget.text) : Future.value('');
  }

  Future<String> _getTextTr(String text) async {
    try {
      if (text.trim().isEmpty) return text;
      final result = await GoogleTranslator().translate(
        text,
        from: 'en',
        to: 'ar',
      );
      return result.text.trim().isEmpty ? text : result.text;
    } catch (_) {
      // Fall back to the original text on any network / parse error
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    if (!_isAr) {
      return CustomReamMoreText(text: widget.text, textTheme: textTheme);
    }

    return FutureBuilder<String>(
      future: _translationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Container(
              width: double.infinity,
              height: context.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppBorderRadius.r8),
              ),
            ),
          );
        }
        // On error or missing data, show original text
        return CustomReamMoreText(
          text: snapshot.data ?? widget.text,
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
      readMoreText: l10n.read_more,
      readLessText: l10n.read_less,
      iconSize: 16,
      readMoreStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.white.withValues(alpha: 0.8),
      ),
    );
  }
}
