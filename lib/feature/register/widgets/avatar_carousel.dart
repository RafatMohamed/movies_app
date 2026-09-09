import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import '../../../core/models/img_profile_model.dart';

class AvatarCarousel extends StatefulWidget {
  const AvatarCarousel({super.key, this.onAvatarSelected});

  /// Called with the index into [ImgProfileModel.avatars] whenever the
  /// centered avatar changes, so the caller can persist it (e.g. to
  /// Firestore on register).
  final ValueChanged<int>? onAvatarSelected;

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  static const double _selectedSize = 150;
  static const double _viewportFraction = 0.5;

  late final PageController _controller;
  double _page = 1;
  int _lastReportedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: _viewportFraction,
      initialPage: 1,
    );
    _controller.addListener(() {
      final page = _controller.page ?? 1;
      setState(() => _page = page);

      final roundedIndex = page.round();
      if (roundedIndex != _lastReportedIndex) {
        _lastReportedIndex = roundedIndex;
        widget.onAvatarSelected?.call(roundedIndex);
      }
    });
    // Report the initial selection once the first frame is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onAvatarSelected?.call(_lastReportedIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ImgProfileModel> avatars = ImgProfileModel.avatars;
    return SizedBox(
      height: _selectedSize,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final peekWidth = constraints.maxWidth * (1 - _viewportFraction) / 2;
          final unselectedSize = (peekWidth - 6).clamp(50.0, 90.0);

          return PageView.builder(
            controller: _controller,
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final distance = (index - _page).abs().clamp(0.0, 1.0);
              final size =
                  unselectedSize +
                  (_selectedSize - unselectedSize) * (1 - distance);
              final side = index > _page ? -1.0 : (index < _page ? 1.0 : 0.0);
              final alignment = Alignment(side * distance, 0);

              return Align(
                alignment: alignment,
                child: Container(
                  width: size,
                  height: size,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlack,
                  ),
                  child: SvgPicture.asset(
                    avatars[index].imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}